use Collateral_View_202604;
go

CREATE PROCEDURE dbo.FannieMaeCollateralCalc_C_CreateTables
AS
BEGIN
    SET NOCOUNT ON

    if object_id(N'dbo.support_R01_unsortedReportDa_B', N'U') is null
    begin   
      create table support_R01_unsortedReportDa_B (
        ID1 bigint identity(1,1)
      , [Reinsurer Name] nvarchar(255)
      , [FEIN] nvarchar(255)
      , [LEI] nvarchar(255)
      , [Bank] nvarchar(255)
      , [Name] nvarchar(255)
      , [ID] nvarchar(255)
      , [All Securities] float
      , [Security Tests] float
      , [Level Tests] float)
    end;

      
    if object_id(N'dbo.stepdownReportActivityPeriods', N'U') is null
    begin   
      create table stepdownReportActivityPeriods (
        [Activity Period] datetime
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.support_R02_Dataload_A', N'U') is null
    begin   
      create table support_R02_Dataload_A (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Description] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Industry (Original)] nvarchar(255)
      , [S&P Rating] nvarchar(255)
      , [Market Value (Pre-Test)] float
      , [Maturity Date] nvarchar(255)
      , [Years to Maturity] float
      , [Moody's Rating] nvarchar(255)
      , [MV % of Total] float
      , [As of Date] datetime
      , [CUSIP] nvarchar(255)
      , [Corporate Bond Flag (CB)] float
      , [CUSIP_noSpaces] nvarchar(255)
      , [Industry] nvarchar(255)
      , [3yr Maturity Flag (M3)] float
      , [Flag for 10%+ MV of Total (MV10)] float
      , [Valid S&P Bond Rating Flag (SPBR)] float
      , [Valid Moody's Bond Rating Flag (MBR)] float
      , [Flag for S&P Bond Rating A or Higher (SPBRA)] float
      , [Flag for Moody's Bond Rating A or Higher (MBRA)] float
      , [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)] float
      , [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check] nvarchar(255)
      , [Fitch Check Flag (FC)] float
      , [Fitch Rating] nvarchar(255)
      , [CB*M3] float
      , [Flag for Fitch Bond Rating A or Higher (FBRA)] float
      , [Impermissible Corporate Bond due to Ratings (ICBR)] float
      , [CB*MV10] float
      , [At Least 1 Exception pre-Fitch Check] float
      , [At Least 1 Exception post-Fitch Check] float
      , [Market Value (Corporates)] float
      , [Market Value (Corporates >= 3yrs)] float
      , [accountChangeFlag] nvarchar(255)
      , [Market Value (Post-Individual-Test)] float
      , [Market Value (Post-CBMV-Haircut)] float
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.priorMonth_support_R02_Dataload_A', N'U') is null
    begin   
      create table priorMonth_support_R02_Dataload_A (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Description] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Industry (Original)] nvarchar(255)
      , [S&P Rating] nvarchar(255)
      , [Market Value (Pre-Test)] float
      , [Maturity Date] nvarchar(255)
      , [Years to Maturity] float
      , [Moody's Rating] nvarchar(255)
      , [MV % of Total] float
      , [As of Date] datetime
      , [CUSIP] nvarchar(255)
      , [Corporate Bond Flag (CB)] float
      , [CUSIP_noSpaces] nvarchar(255)
      , [Industry] nvarchar(255)
      , [3yr Maturity Flag (M3)] float
      , [Flag for 10%+ MV of Total (MV10)] float
      , [Valid S&P Bond Rating Flag (SPBR)] float
      , [Valid Moody's Bond Rating Flag (MBR)] float
      , [Flag for S&P Bond Rating A or Higher (SPBRA)] float
      , [Flag for Moody's Bond Rating A or Higher (MBRA)] float
      , [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)] float
      , [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check] nvarchar(255)
      , [Fitch Check Flag (FC)] float
      , [Fitch Rating] nvarchar(255)
      , [CB*M3] float
      , [Flag for Fitch Bond Rating A or Higher (FBRA)] float
      , [Impermissible Corporate Bond due to Ratings (ICBR)] float
      , [CB*MV10] float
      , [At Least 1 Exception pre-Fitch Check] float
      , [At Least 1 Exception post-Fitch Check] float
      , [Market Value (Corporates)] float
      , [Market Value (Corporates >= 3yrs)] float
      , [accountChangeFlag] nvarchar(255)
      , [Market Value (Post-Individual-Test)] float
      , [Market Value (Post-CBMV-Haircut)] float
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.support_R02_Dataload_History', N'U') is null
    begin   
      create table support_R02_Dataload_History (
        [Activity Period] datetime
      , [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Description] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Industry (Original)] nvarchar(255)
      , [S&P Rating] nvarchar(255)
      , [Market Value (Pre-Test)] float
      , [Maturity Date] nvarchar(255)
      , [Years to Maturity] float
      , [Moody's Rating] nvarchar(255)
      , [MV % of Total] float
      , [As of Date] datetime
      , [CUSIP] nvarchar(255)
      , [Corporate Bond Flag (CB)] float
      , [CUSIP_noSpaces] nvarchar(255)
      , [Industry] nvarchar(255)
      , [3yr Maturity Flag (M3)] float
      , [Flag for 10%+ MV of Total (MV10)] float
      , [Valid S&P Bond Rating Flag (SPBR)] float
      , [Valid Moody's Bond Rating Flag (MBR)] float
      , [Flag for S&P Bond Rating A or Higher (SPBRA)] float
      , [Flag for Moody's Bond Rating A or Higher (MBRA)] float
      , [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)] float
      , [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check] nvarchar(255)
      , [Fitch Check Flag (FC)] float
      , [Fitch Rating] nvarchar(255)
      , [CB*M3] float
      , [Flag for Fitch Bond Rating A or Higher (FBRA)] float
      , [Impermissible Corporate Bond due to Ratings (ICBR)] float
      , [CB*MV10] float
      , [At Least 1 Exception pre-Fitch Check] float
      , [At Least 1 Exception post-Fitch Check] float
      , [Market Value (Corporates)] float
      , [Market Value (Corporates >= 3yrs)] float
      , [accountChangeFlag] nvarchar(255)
      , [Market Value (Post-Individual-Test)] float
      , [Market Value (Post-CBMV-Haircut)] float
      , [i] bigint identity(1,1))
    end;


      
    if object_id(N'dbo.support_R10_MoM_AssetChangeDetail', N'U') is null
    begin   
      create table support_R10_MoM_AssetChangeDetail (
        [Account] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [CUSIP_noSpaces] nvarchar(255)
      , [Description] nvarchar(255)
      , [reinsurerName] nvarchar(255)
      , [marketValue_prior] float
      , [marketValue_current] float
      , [changeCohort] float
      , [marketValue_runoff] float
      , [marketValue_new] float
      , [marketValue_continuing_prior] float
      , [marketValue_continuing_current] float
      , i bigint identity(1,1)
      )
    end;


      
    if object_id(N'dbo.support_R11_spGlobalFSR_history', N'U') is null
    begin   
      create table support_R11_spGlobalFSR_history (
        stepdownReportActivityPeriod datetime
      , SP_ENTITY_NAME nvarchar(127)
      , SP_CIQ_ID nvarchar(31)
      , RD_CREDIT_RATING_GLOBAL nvarchar(31)
      , SP_FITCH_INSURER_FSR nvarchar(31)
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.support_R11_amBestFSR_history', N'U') is null
    begin   
      create table support_R11_amBestFSR_history (
        [Activity Period] datetime
      , [reinsurerNameWOComments] nvarchar(255)
      , [amBestFSR] nvarchar(4000)
      , [ID] int
      , [AMB#] float
      , [NAIC#] float
      , [Company Name] nvarchar(255)
      , [Best's Financial Strength Rating - Current] nvarchar(255)
      , [Best's Long-Term Issuer Credit Rating - Current] nvarchar(255)
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.R01_reinsCollateralByAccount', N'U') is null
    begin   
      create table R01_reinsCollateralByAccount (
        [reinsurerName] nvarchar(127)
      , [FEIN] nvarchar(31)
      , [LEI] nvarchar(31)
      , [trustAccountBank] nvarchar(127)
      , [trustAccountName] nvarchar(127)
      , [trustAccountID] nvarchar(31)
      , [mv_collHeld_cashAndSec_combined] float
      , [mv_collHeld_cashAndSec_passingIndivTests] float
      , [mv_collHeld_cashAndSec_passingPortTests] float
      , [mv_collHeld_corpBonds_all_nominal] float
      , [mv_collHeld_corpBonds_all_pctOfCombined] float
      , [mv_collHeld_corpBonds_3yr_nominal] float
      , [mv_collHeld_corpBonds_3yr_pctOfCombined] float
      , i bigint identity(1,1)
      )
    end;


    if object_id(N'dbo.corporateBondHaircutFactors', N'U') is null
    begin   
      create table corporateBondHaircutFactors (
        [ID] int
      , [Account Title] nvarchar(255)
      , [Account Title|Industry] nvarchar(255)
      , [Total Corporates] float
      , [Total Credit Check] nvarchar(255)
      , [Haircut Factor] float
      , i bigint identity(1,1)
      );
	end;


      
    if object_id(N'dbo.R02_Coll_Held_1_Reinsurer', N'U') is null
    begin   
      create table R02_Coll_Held_1_Reinsurer (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Description] nvarchar(255)
      , [Industry] nvarchar(255)
      , [CUSIP] nvarchar(255)
      , [Maturity Date] nvarchar(255)
      , [Years to Maturity] float
      , [As of Date] datetime
      , [S&P Rating] nvarchar(255)
      , [Moody's Rating] nvarchar(255)
      , [Market Value (Pre-Test)] float
      , [MV % of Total] float
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.R03_Re_Collateral_by_Reinsurer', N'U') is null
    begin   
      create table R03_Re_Collateral_by_Reinsurer (
        [Reinsurer Name] nvarchar(255)
      , [FEIN] nvarchar(255)
      , [LEI] nvarchar(255)
      , [Trust Account 1] nvarchar(255)
      , [Trust Account 2] nvarchar(255)
      , [Trust Account 3] nvarchar(255)
      , [Market Value of Collateral] float
      , [100pct of Collateral Required] float
      , [102pct of Collateral Required] float
      , [Ratio of Collateral Held to Collateral Required] float
      , [Collateral Shortfall] float
      , [Excess Collateral] float
      , [Combined Collateral Variance] float
      , i bigint identity(1,1)
      )
    end;


      
    if object_id(N'dbo.R04_Coll_Req_by_Reins_All_Deals', N'U') is null
    begin   
      create table R04_Coll_Req_by_Reins_All_Deals (
        [reinsurerName] nvarchar(255)
      , [dealName] nvarchar(255)
      , [reinsurerParticipation_initial] float
      , [effectiveDate] datetime
      , [reinsurerParticipation] float
      , [collateralFactor] float
      , [reductionFactor] float
      , [seasoningFactor] float
      , [netCollateralFactor] float
      , [collateralRequirement] float
      , i bigint identity(1,1)
      )
    end;

      
    if object_id(N'dbo.R05_Coll_Required_1_Reinsurer', N'U') is null
    begin   
      create table R05_Coll_Required_1_Reinsurer (
        [reinsurerName] nvarchar(255)
      , [dealName] nvarchar(255)
      , [reinsurerParticipation_initial] float
      , [effectiveDate] datetime
      , [reinsurerParticipation] float
      , [collateralFactor] float
      , [reductionFactor] float
      , [seasoningFactor] float
      , [netCollateralFactor] float
      , [collateralRequirement] float
      , [i] bigint identity(1,1))
    end;

      
    if object_id(N'dbo.R06_Global_Credit_Check', N'U') is null
    begin  
      create table R06_Global_Credit_Check (
        [reinsurerName] nvarchar(127)
      , [Total Corporates] float
      , [Total Credit Check] varchar(4)
      , [Haircut Factor] float
      , [i] bigint identity(1,1))
    end;

      
    if object_id(N'dbo.R07_Rating_Exception', N'U') is null
    begin 
      create table R07_Rating_Exception (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Description] nvarchar(255)
      , [Industry] nvarchar(255)
      , [CUSIP] nvarchar(255)
      , [Maturity Date] nvarchar(255)
      , [Market Value] float
      , [MV % of Total] float
      , [Years to Maturity] float
      , [As of Date] datetime
      , [S&P Rating] nvarchar(255)
      , [Moody's Rating] nvarchar(255)
      , [Fitch Rating] nvarchar(255)
      , [Rating Check] varchar(4)
      , [Maturity Check] varchar(4)
      , [Individual Weight Check] varchar(4)
      , [i] bigint identity(1,1))
    end;

      
    if object_id(N'dbo.R08_Maturity_Exceptions', N'U') is null
    begin
      create table R08_Maturity_Exceptions (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Description] nvarchar(255)
      , [Industry] nvarchar(255)
      , [CUSIP] nvarchar(255)
      , [Maturity Date] nvarchar(255)
      , [Market Value] float
      , [MV % of Total] float
      , [Years to Maturity] float
      , [As of Date] datetime
      , [S&P Rating] nvarchar(255)
      , [Moody's Rating] nvarchar(255)
      , [Fitch Rating] nvarchar(255)
      , [Rating Check] varchar(4)
      , [Maturity Check] varchar(4)
      , [Individual Weight Check] varchar(4)
      , [i] bigint identity(1,1))
    end;

      
    if object_id(N'dbo.R09_Individual_Weight_Check', N'U') is null
    begin
      create table R09_Individual_Weight_Check (
        [Account Title] nvarchar(255)
      , [Account] nvarchar(255)
      , [Portfolio Type] nvarchar(255)
      , [Security Type] nvarchar(255)
      , [Description] nvarchar(255)
      , [Industry] nvarchar(255)
      , [CUSIP] nvarchar(255)
      , [Maturity Date] nvarchar(255)
      , [Market Value] float
      , [MV % of Total] float
      , [Years to Maturity] float
      , [As of Date] datetime
      , [S&P Rating] nvarchar(255)
      , [Moody's Rating] nvarchar(255)
      , [Fitch Rating] nvarchar(255)
      , [Rating Check] varchar(4)
      , [Maturity Check] varchar(4)
      , [Individual Weight Check] varchar(4)
      , [i] bigint identity(1,1))
    end;


	
    if object_id(N'dbo.individualAssetsFailingTests', N'U') is null
    begin
      create table individualAssetsFailingTests (
        ID bigint identity(1,1)
      , [Index] bigint
      , CUSIP nvarchar(255)
      );
    end


      
    if object_id(N'dbo.R10_MoM_Asset_Changes', N'U') is null
    begin
      create table R10_MoM_Asset_Changes (
        [Account] nvarchar(255)
      , [Description] nvarchar(255)
      , [reinsurerName] nvarchar(255)
      , [marketValue_runoff] float
      , [marketValue_new] float
      , [marketValue_continuing_prior] float
      , [marketValue_continuing_current] float
      , [marketValue_continuing_change] float
      , [marketValue_combined_prior] float
      , [marketValue_combined_current] float
      , [marketValue_combined_change] float
      , i bigint identity(1,1))
    end;

      
    if object_id(N'dbo.R11_MoM_Fin_Strength_Rtg_Changes', N'U') is null
    begin
      create table R11_MoM_Fin_Strength_Rtg_Changes (
        [reinsurerName] nvarchar(127)
      , [rating_SPCIQ_ID] nvarchar(31)
      , [rating_SPCIQ_Prior] nvarchar(31)
      , [rating_SPCIQ_Current] nvarchar(31)
      , [rating_SPCIQ_Change] nvarchar(31)
      , [rating_Fitch_Prior] nvarchar(31)
      , [rating_Fitch_Current] nvarchar(31)
      , [rating_Fitch_Change] nvarchar(31)
      , [rating_AM_Best_Number] nvarchar(31)
      , [rating_AM_Best_Prior] nvarchar(31)
      , [rating_AM_Best_Current] nvarchar(31)
      , [rating_AM_Best_Change] nvarchar(31)
      , [i] bigint identity(1,1))
    end;

    
    if object_id(N'dbo.R12_Limit_Stepdowns', N'U') is null
    begin
      create table R12_Limit_Stepdowns (
        [deal] nvarchar(31)
      , [remainingLimitOfLiability_Prior] float
      , [remainingLimitOfLiability_Current] float
      , [change] float
      , [i] bigint identity(1,1))
    end;
END
