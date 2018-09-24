queryNL = "WITH kbs AS ( SELECT
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, CASE
WHEN lower(device) LIKE \"%tablet\" THEN \"Tablet\"
WHEN lower(device) LIKE \"%mobile%\" THEN \"Mobile\"
WHEN Lower(device) LIKE \"%desktop%\" THEN \"Desktop\"
ELSE \"Unknown\" END AS Device
, SUM(Impressions) AS Impressions
, SUM(Clicks) AS Clicks
, SUM(Cost/1000000) AS Cost
, SAFE_DIVIDE(SUM(AveragePosition* Impressions),SUM(IF(AveragePosition IS NULL, 0, Impressions))) AS AveragePosition
FROM `coolblue-bi-adwords-2.adwords_data_transfer.p_KeywordBasicStats_4248964433` 
WHERE DATE(_PARTITIONTIME) BETWEEN \"2018-01-01\" AND \"2018-08-26\"
AND lower(AdNetworkType2) NOT LIKE \"%partner%\" --removed data from search partners
GROUP BY
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, Device)

SELECT 
-- Every row contains a unique combination of Date, CriterionId and AdGroupId. 
kbs.date
, CAST(kbs.CriterionId AS string) AS CriterionId
, CAST(kbs.AdGroupId AS string) AS AdGroupId
, CAST(kbs.CampaignId AS string) AS CampaignId
, CAST(kbs.ExternalCustomerid AS string) AS ExternalCustomerid
, kbs.device
, cc.country
, cc.language
, cc.producttype
, cc.brand
, cc.Funnel
, Impressions
, Clicks
, Cost
, AveragePosition
, SAFE_DIVIDE(Cost, Clicks) AS AvgCpc

FROM kbs
LEFT JOIN `coolblue-facebook-test.adwords.dim_gadw_campaigncategories` AS cc ON kbs.adgroupid = cc.adgroupid

WHERE
objective = \"SEA\" -- removes data that isn't focused on product sales
AND kbs.Clicks <> 0
AND kbs.campaignid IN (
1355302796,
1346379576,
1355691089,
1352443134,
1345786211,
1355984847,
1355690831,
1355691092,
1355577341,
1355576594,
1346379570,
1040477171,
1413430788,
1381496627,
1356149944,
1041306407,
1352098202,
1355302793,
1342463275,
1042521967,
1042522285,
1042522048,
1336071113,
1368374793,
1355984841,
1341215903,
1041307850,
1356129988,
774095682,
1418975171,
1356149641,
1355577359,
1356309724,
1396612055,
1356236376,
1381496798,
1356264957,
1040477243,
1420117562,
1041306362,
1356264414,
1342463257,
1381496771,
1041308045,
1041308051,
1356149485,
1356243523,
1420117862,
1381496609,
1421182281)

ORDER BY kbs.date"



queryBL = "WITH kbs AS ( SELECT
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, CASE
WHEN lower(device) LIKE \"%tablet\" THEN \"Tablet\"
WHEN lower(device) LIKE \"%mobile%\" THEN \"Mobile\"
WHEN Lower(device) LIKE \"%desktop%\" THEN \"Desktop\"
ELSE \"Unknown\" END AS Device
, SUM(Impressions) AS Impressions
, SUM(Clicks) AS Clicks
, SUM(Cost/1000000) AS Cost
, SAFE_DIVIDE(SUM(AveragePosition* Impressions),SUM(IF(AveragePosition IS NULL, 0, Impressions))) AS AveragePosition
FROM `coolblue-bi-adwords-2.adwords_data_transfer.p_KeywordBasicStats_4248964433` 
WHERE DATE(_PARTITIONTIME) BETWEEN \"2018-01-01\" AND \"2018-08-26\"
AND lower(AdNetworkType2) NOT LIKE \"%partner%\" --removed data from search partners
GROUP BY
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, Device)

SELECT 
-- Every row contains a unique combination of Date, CriterionId and AdGroupId. 
kbs.date
, CAST(kbs.CriterionId AS string) AS CriterionId
, CAST(kbs.AdGroupId AS string) AS AdGroupId
, CAST(kbs.CampaignId AS string) AS CampaignId
, CAST(kbs.ExternalCustomerid AS string) AS ExternalCustomerid
, kbs.device
, cc.country
, cc.language
, cc.producttype
, cc.brand
, cc.Funnel
, Impressions
, Clicks
, Cost
, AveragePosition
, SAFE_DIVIDE(Cost, Clicks) AS AvgCpc

FROM kbs
LEFT JOIN `coolblue-facebook-test.adwords.dim_gadw_campaigncategories` AS cc ON kbs.adgroupid = cc.adgroupid

WHERE
objective = \"SEA\" -- removes data that isn't focused on product sales
AND kbs.Clicks <> 0
AND cc.country = \"Netherlands\"
"
queryBL = "WITH kbs AS ( SELECT
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, CASE
WHEN lower(device) LIKE \"%tablet\" THEN \"Tablet\"
WHEN lower(device) LIKE \"%mobile%\" THEN \"Mobile\"
WHEN Lower(device) LIKE \"%desktop%\" THEN \"Desktop\"
ELSE \"Unknown\" END AS Device
, SUM(Impressions) AS Impressions
, SUM(Clicks) AS Clicks
, SUM(Cost/1000000) AS Cost
, SAFE_DIVIDE(SUM(AveragePosition* Impressions),SUM(IF(AveragePosition IS NULL, 0, Impressions))) AS AveragePosition
FROM `coolblue-bi-adwords-2.adwords_data_transfer.p_KeywordBasicStats_4248964433` 
WHERE DATE(_PARTITIONTIME) BETWEEN \"2018-01-01\" AND \"2018-08-26\"
AND lower(AdNetworkType2) NOT LIKE \"%partner%\" --removed data from search partners
GROUP BY
date
, CriterionId
, AdGroupId
, CampaignId
, ExternalCustomerid
, Device)

SELECT 
-- Every row contains a unique combination of Date, CriterionId and AdGroupId. 
kbs.date
, CAST(kbs.CriterionId AS string) AS CriterionId
, CAST(kbs.AdGroupId AS string) AS AdGroupId
, CAST(kbs.CampaignId AS string) AS CampaignId
, CAST(kbs.ExternalCustomerid AS string) AS ExternalCustomerid
, kbs.device
, cc.country
, cc.language
, cc.producttype
, cc.brand
, cc.Funnel
, Impressions
, Clicks
, Cost
, AveragePosition
, SAFE_DIVIDE(Cost, Clicks) AS AvgCpc

FROM kbs
LEFT JOIN `coolblue-facebook-test.adwords.dim_gadw_campaigncategories` AS cc ON kbs.adgroupid = cc.adgroupid

WHERE
objective = \"SEA\" -- removes data that isn't focused on product sales
AND kbs.Clicks <> 0
AND cc.country = \"Belgium\"
"



