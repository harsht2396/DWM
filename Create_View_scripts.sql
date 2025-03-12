--1) Created view using the Risk_DB table and applied required conditions to align both views.

USE [test]
GO

/****** Object:  View [dbo].[vw_risk_DB]    Script Date: 01-02-2025 21:20:19 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create view [dbo].[vw_risk_DB] as 


SELECT TOP (1000) [Latest_Month_Reported]
      ,[Fund]
      ,[MFI_Name]
      ,[Country]
      ,[Region]
	  ,case 
		when [Country]='CAMBODIA' then 'SSEEA'
		when [Country]='NICARAGUA' then  'CACM'  
		when [Country]='ROMANIA' then  'EE' 
		when [Country]='TAJIKISTAN' then 'CCA'  
		else Region
		end as [Region_updated]
      ,[Total_Amount_Invested]
      ,[Total_Assets]
      ,[GLP]
      ,[Total_Equity]
      ,[Net_Income]
      ,cast([ROA_YTD_Annualized] as decimal(10,2))*100 as[ROA_YTD_Annualized]
      ,cast([Risk_Coverage_Ratio] as decimal(10,2))*100 as [Risk_Coverage_Ratio]
      ,[Number_of_Active_Borrowers]
      ,cast([Average_Loan_Size] as decimal(10,2))*100 as	[Average_Loan_Size]
      ,cast([PAR_30_R_R]	    as decimal(10,2))*100 as	[PAR_30_R_R]
      ,cast([Solvency]		    as decimal(10,2))*100 as	[Solvency]
      ,[OLER]
      ,[Loan_Loss_Reserves]
  FROM [test].[dbo].[risk_DB_FInal2]
GO

****************************************************************************************************************************`
--2) Created view using the Portfolio_DB table and applied required conditions to align both views.

USE [test]
GO

/****** Object:  View [dbo].[vw_Portfolio_DB]    Script Date: 01-02-2025 21:23:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create view [dbo].[vw_Portfolio_DB] as

select 
	   [Borrower_Country]
      ,[Region]
	  ,Borrower
      ,case 
		when [Borrower]= 'ARMET Microfinance Institution' then 'Armet' 
		when [Borrower]= 'Agriculture Credit IFN SA' then 'Agriculture Credit' 
		when [Borrower]= 'Champion Microfinance PLC' then 'Champion' 
		when [Borrower]= 'Financiera  de Banco' then 'Banco Financiera' 
		when [Borrower]= 'FMA Nicaragua' then 'FMA Finance'
		when [Borrower]= 'NoCredit Romania' then 'NoCredit' 
		else Borrower 
		end as [Borrower_updated]
      ,[Fund]
      ,[Total_Amount_Invested]
  FROM [test].[dbo].[Portfolio_DB]
GO
