# estimate.R
# queries the data (NL or BE) and fits the curves
# by <Criteria, Adgroup, Device> if applicable
# 
# Input: ./resouces/query.R - with the queries for NL and BL
#
# Output: ./Coefficients/*.csv - N csvs with the coefficients
#         of each fitted model which will be retrieves by get_curves.R 
#
library(coolblueshiny)
source('resources/query.R')

###
# input parameters
###
# query, change query to queryNL (contained in the source query.R)
# to estimate the shortlisted campaigns in the netherlands. Be aware
# that it is needed to remove the list of campaigns in the query if you
# want to query all data in the Netherlans
# The queries compress from 01-2018 to 06-2018. Change the data as 
# desired bearing in mind the amount of data in NL might not fit
# in memory
query = queryBL
project = 'coolblue-facebook-test'

response = coolblueshiny::query_exec_fixed(query, 
                                          project=project, 
                                          max_pages=Inf, 
                                          use_legacy_sql = FALSE)

# filter defined by <Criteria, Adgroup, Device> one curve 
# will be fitted by this unique groups
groups_ini = unique(response[, names(response) %in% c('CriterionId', 'AdGroupId', 'device')])

# slice the data to save intermidiate results in case 
# something fails
slice <- function(input, by=2){ 
  starts <- seq(1,length(input),by)
  tt <- lapply(starts, function(y) input[y:(y+(by-1))])
  plyr::llply(tt, function(x) x[!is.na(x)])
}

spl = slice(1:dim(groups_ini)[1], by = 1000) # sliced 1000 by a 1000

for (l in 1:length(spl)){
  j = 0
  groups = groups_ini[spl[[l]], ]
  
  for (i in 1:nrow(groups)){
    sel_data = response[response$CriterionId == groups$CriterionId[i], ]
    sel_data = sel_data[sel_data$AdGroupId == groups$AdGroupId[i], ]
    sel_data = sel_data[sel_data$device == groups$device[i], ]
    
    # only fit curves when we have more than 4 points in the scatter
    if(dim(sel_data)[1] > 4){
      
      # add 2 "example" point to force the logarithm be 0 
      # at position 10, this can be change to adjust the
      # shape of the log
      example  = tail(sel_data, 1)
      
      example$AveragePosition = 10
      example$AvgCpc = 1
      sel_data = rbind(sel_data, example)  
      
      example$AveragePosition = 10
      example$AvgCpc = -1
      sel_data = rbind(sel_data, example)  
      
      # fit 
      model = lm(data=sel_data, formula = AvgCpc ~ log(AveragePosition))
      
      # save
      if(j == 0){
        res = c(groups$AdGroupId[i], groups$CriterionId[i], groups$device[i],
                model$coefficients[2], model$coefficients[1]) 
        j = j + 1
      } else {
        res = rbind(res, c(groups$AdGroupId[i], groups$CriterionId[i], groups$device[i],
                model$coefficients[2], model$coefficients[1]))
      }
      
    } else {
      if(j == 0){
        res = c(groups$AdGroupId[i], groups$CriterionId[i], groups$device[i],
                NA, NA)   
        j = j + 1
      } else {
        res = rbind(res, c(groups$AdGroupId[i], groups$CriterionId[i], groups$device[i],
                           NA, NA))
      }
    }                   
  }

  # store the coefficients in csvs for future reading
  res = data.frame(res)
  names(res) = c('AdGroupId', 'CriterionId', 'device', 'log_AvpPos', 'Intercept')
  write.csv(res, file = paste0('./Coefficients/chunk_', k, '.csv'))
  print(paste0(k, '/', length(spl)))
  k = k + 1
}
