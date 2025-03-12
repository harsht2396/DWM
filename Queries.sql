--3)Merge the 2 databases into a single combined database identifying Logics (ETLs) where data identifiers and descriptions do not match, providing potential solutions.

SELECT
    t1.borrower_Country AS Country,
    t1.Region AS Region,
    t1.Borrower AS MFI_Name,
    t1.Fund AS Fund,
    t1.Total_Amount_Invested AS Total_Amount_Invested_Portfolio_DB,
    t2.Total_Amount_Invested as Total_Amount_Invested_Risk_DB
	
FROM [dbo].[vw_Portfolio_DB] t1
LEFT JOIN test..[vw_risk_DB]  t2
    ON t1.borrower_country = t2.Country
    AND t1.Region = t2.Region_updated
    AND t1.Borrower_updated = t2.MFI_Name
    AND t1.Fund = t2.Fund;
****************************************************************************************************************************`
--4)Write queries to generate a report with the average PAR>30 by country, by region

by country : 

SELECT 
    Country, AVG(PAR_30_R_R) AS Avg_PAR_30
FROM [dbo].[vw_risk_DB]
WHERE PAR_30_R_R > 30
GROUP BY Country
ORDER BY Avg_PAR_30 DESC;

by region : 

SELECT 
    Region_updated, 
    AVG(PAR_30_R_R) AS Avg_PAR_30
FROM [dbo].[vw_risk_DB]
WHERE PAR_30_R_R > 30
GROUP BY Region_updated
ORDER BY Avg_PAR_30 DESC;

****************************************************************************************************************************`
--5)Write a query to reconcile the differences between the two tables assumptions of the Total Amount Invested / Portfolio Base Market Values

SELECT
    t1.borrower_Country AS Country,
    t1.Region AS Region,
    t1.Borrower AS MFI_Name,
    t1.Fund AS Fund,
    t1.Total_Amount_Invested AS Total_Amount_Invested_Portfolio_DB,
    t2.Total_Amount_Invested as Total_Amount_Invested_Risk_DB,
	t1.Total_Amount_Invested-t2.Total_Amount_Invested as difference_
	
FROM [dbo].[vw_Portfolio_DB] t1
LEFT JOIN test..[vw_risk_DB]  t2
    ON t1.borrower_country = t2.Country
    AND t1.Region = t2.Region_updated
    AND t1.Borrower_updated = t2.MFI_Name
    AND t1.Fund = t2.Fund;
