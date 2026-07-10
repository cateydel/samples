use Collateral_View_202603;
go

CREATE PROCEDURE dbo.FannieMaeCollateralCalc_A_SetUpHistoryTables
AS
BEGIN
    SET NOCOUNT ON

    if object_id(N'dbo.history_bkp_priorMonth_support_R02_DL_A ', N'U') is null begin create table history_bkp_priorMonth_support_R02_DL_A ([valuationDate] datetime, [ID] int
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
    , [As of Date] float
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
    , [accountChangeFlag] float
    , [Market Value (Post-Individual-Test)] float
    , [Market Value (Post-CBMV-Haircut)] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_bkp_support_R01_cvMasterEntityIDMap ', N'U') is null begin create table history_bkp_support_R01_cvMasterEntityIDMap ([valuationDate] datetime, [ID1] int
    , [ID] float
    , [FEIN] nvarchar(255)
    , [Reinsurer_Name] nvarchar(255)
    , [Reinsurer_Name_AonVersion] nvarchar(255)
    , [LEI] nvarchar(255)
    , [rating_SPCIQ_ID] nvarchar(255)
    , [rating_AM_Best_Number] nvarchar(255)
    , [trustAccount1] nvarchar(255)
    , [fitch_rating_raw] nvarchar(255)
    , [trustAccount2] nvarchar(255)
    , [trustAccount3] nvarchar(255)
    , [sp_rating_raw] nvarchar(255)
    , [ambest_rating_raw] nvarchar(255)
    , [sp_rating_gridlookup] nvarchar(255)
    , [ambest_rating_gridlookup] nvarchar(255)
    , [eRatingPairing_gridLookup] nvarchar(255)
    , [eActiveReinsurer] float
    , [eMultifamily] nvarchar(255)
    , [eMultiline] nvarchar(255)
    , [ePremiumCapture] nvarchar(255)
    , [eReinsurerName_ReductionFactorLookup] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_bkp_support_R02_Dataload_A ', N'U') is null begin create table history_bkp_support_R02_Dataload_A ([valuationDate] datetime, [ID] int
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
    , [Market Value (Post-CBMV-Haircut)] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_competingBrokerTrustAccounts ', N'U') is null begin create table history_competingBrokerTrustAccounts ([valuationDate] datetime, [Account] nvarchar(255)
    , [reinsurerName] nvarchar(255)
    , [Description] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_corporateBondFlags ', N'U') is null begin create table history_corporateBondFlags ([valuationDate] datetime, [ID] int
    , [Industry] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_corporateBondHaircutFactors ', N'U') is null begin create table history_corporateBondHaircutFactors ([valuationDate] datetime, [ID] int
    , [Account Title] nvarchar(255)
    , [Account Title|Industry] nvarchar(255)
    , [Total Corporates] float
    , [Total Credit Check] nvarchar(255)
    , [Haircut Factor] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_fitchBondRatingLookup ', N'U') is null begin create table history_fitchBondRatingLookup ([valuationDate] datetime, [A or Higher] float
    , [Rating] nvarchar(255)
    , [ID] int
    , [Lower than A-] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_historyTableBuilds_tableAndColumnNames ', N'U') is null begin create table history_historyTableBuilds_tableAndColumnNames ([valuationDate] datetime, [TABLE_NAME] nvarchar(128)
    , [COLUMN_NAME] nvarchar(128)
    , [ORDINAL_POSITION] bigint
    , [DATA_TYPE] nvarchar(128)
    , [CHARACTER_MAXIMUM_LENGTH] bigint
    , [startingRow] bigint
    , [finalRow] bigint
    , [sqlCode_dropTable] nvarchar(255)
    , [sqlCode_createTable] nvarchar(255)
    , [sqlCode_insertInto] nvarchar(255)
    , [sqlCode_select] nvarchar(255)
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_individualAssetsFailingTests ', N'U') is null begin create table history_individualAssetsFailingTests ([valuationDate] datetime, [ID] int
    , [Index] float
    , [CUSIP] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_industryOverridesByCUSIP ', N'U') is null begin create table history_industryOverridesByCUSIP ([valuationDate] datetime, [CUSIP] nvarchar(255)
    , [ID] int
    , [Industry Override] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_moodysBondRatingLookup ', N'U') is null begin create table history_moodysBondRatingLookup ([valuationDate] datetime, [A or Higher] float
    , [Rating] nvarchar(255)
    , [ID] int
    , [Lower than A3] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_priorMonth_support_R01_spGlobal ', N'U') is null begin create table history_priorMonth_support_R01_spGlobal ([valuationDate] datetime, [SP_ENTITY_ID] float
    , [SP_ENTITY_NAME] nvarchar(255)
    , [SP_COMPANY_NAME_ABBR] nvarchar(255)
    , [SP_CIQ_ID] nvarchar(255)
    , [SP_COMPANY_NAME_SHORT] nvarchar(255)
    , [SP_LEI] nvarchar(255)
    , [RD_CREDIT_RATING_GLOBAL] nvarchar(255)
    , [SP_TAX_ID] nvarchar(255)
    , [RD_CWOL_GLOBAL] nvarchar(255)
    , [RD_LAST_REVIEW_DATE_GLOBAL] datetime
    , [RD_RATING_ACTION_GLOBAL] nvarchar(255)
    , [ID] int
    , [SP_FITCH_INSURER_FSR] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_priorMonth_support_R02_Dataload_A ', N'U') is null begin create table history_priorMonth_support_R02_Dataload_A ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_priorMonth_Support_R11_AMBest_R ', N'U') is null begin create table history_priorMonth_Support_R11_AMBest_R ([valuationDate] datetime, [ID] int
    , [AMB#] float
    , [NAIC#] float
    , [Company Name] nvarchar(255)
    , [Best's Financial Strength Rating - Current] nvarchar(255)
    , [Best's Long-Term Issuer Credit Rating - Current] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R01_reinsCollateralByAccount ', N'U') is null begin create table history_R01_reinsCollateralByAccount ([valuationDate] datetime, [reinsurerName] nvarchar(127)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R02_Coll_Held_1_Reinsurer ', N'U') is null begin create table history_R02_Coll_Held_1_Reinsurer ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R03_Re_Collateral_by_Reinsurer ', N'U') is null begin create table history_R03_Re_Collateral_by_Reinsurer ([valuationDate] datetime, [Reinsurer Name] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R04_Coll_Req_by_Reins_All_Deals ', N'U') is null begin create table history_R04_Coll_Req_by_Reins_All_Deals ([valuationDate] datetime, [reinsurerName] nvarchar(255)
    , [dealName] nvarchar(255)
    , [reinsurerParticipation_initial] float
    , [effectiveDate] datetime
    , [reinsurerParticipation] float
    , [collateralFactor] float
    , [reductionFactor] float
    , [seasoningFactor] float
    , [netCollateralFactor] float
    , [collateralRequirement] float
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R05_Coll_Required_1_Reinsurer ', N'U') is null begin create table history_R05_Coll_Required_1_Reinsurer ([valuationDate] datetime, [reinsurerName] nvarchar(255)
    , [dealName] nvarchar(255)
    , [reinsurerParticipation_initial] float
    , [effectiveDate] datetime
    , [reinsurerParticipation] float
    , [collateralFactor] float
    , [reductionFactor] float
    , [seasoningFactor] float
    , [netCollateralFactor] float
    , [collateralRequirement] float
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R06_Global_Credit_Check ', N'U') is null begin create table history_R06_Global_Credit_Check ([valuationDate] datetime, [reinsurerName] nvarchar(127)
    , [Total Corporates] float
    , [Total Credit Check] varchar(4)
    , [Haircut Factor] float
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R07_Rating_Exception ', N'U') is null begin create table history_R07_Rating_Exception ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R08_Maturity_Exceptions ', N'U') is null begin create table history_R08_Maturity_Exceptions ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R09_Individual_Weight_Check ', N'U') is null begin create table history_R09_Individual_Weight_Check ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R10_MoM_Asset_Changes ', N'U') is null begin create table history_R10_MoM_Asset_Changes ([valuationDate] datetime, [Account] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R11_MoM_Fin_Strength_Rtg_Changes ', N'U') is null begin create table history_R11_MoM_Fin_Strength_Rtg_Changes ([valuationDate] datetime, [reinsurerName] nvarchar(127)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_R12_Limit_Stepdowns ', N'U') is null begin create table history_R12_Limit_Stepdowns ([valuationDate] datetime, [deal] nvarchar(31)
    , [remainingLimitOfLiability_Prior] float
    , [remainingLimitOfLiability_Current] float
    , [change] float
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_reinsurerSelection ', N'U') is null begin create table history_reinsurerSelection ([valuationDate] datetime, [reinsurerSelection] varchar(34), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_spBondRatingLookup ', N'U') is null begin create table history_spBondRatingLookup ([valuationDate] datetime, [A or Higher] float
    , [Rating] nvarchar(255)
    , [ID] int
    , [Lower than A-] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R01_cvMasterEntityIDMap ', N'U') is null begin create table history_support_R01_cvMasterEntityIDMap ([valuationDate] datetime, [ID1] int
    , [ID] float
    , [FEIN] nvarchar(255)
    , [Reinsurer_Name] nvarchar(255)
    , [Reinsurer_Name_AonVersion] nvarchar(255)
    , [LEI] nvarchar(255)
    , [rating_SPCIQ_ID] nvarchar(255)
    , [rating_AM_Best_Number] nvarchar(255)
    , [trustAccount1] nvarchar(255)
    , [fitch_rating_raw] nvarchar(255)
    , [trustAccount2] nvarchar(255)
    , [trustAccount3] nvarchar(255)
    , [sp_rating_raw] nvarchar(255)
    , [ambest_rating_raw] nvarchar(255)
    , [sp_rating_gridlookup] nvarchar(255)
    , [ambest_rating_gridlookup] nvarchar(255)
    , [eRatingPairing_gridLookup] nvarchar(255)
    , [eActiveReinsurer] float
    , [eMultifamily] nvarchar(255)
    , [eMultiline] nvarchar(255)
    , [ePremiumCapture] nvarchar(255)
    , [eReinsurerName_ReductionFactorLookup] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R01_spGlobalFSRs ', N'U') is null begin create table history_support_R01_spGlobalFSRs ([valuationDate] datetime, [SP_ENTITY_ID] nvarchar(255)
    , [SP_ENTITY_NAME] nvarchar(255)
    , [SP_COMPANY_NAME_ABBR] nvarchar(255)
    , [SP_CIQ_ID] nvarchar(255)
    , [SP_COMPANY_NAME_SHORT] nvarchar(255)
    , [SP_LEI] nvarchar(255)
    , [RD_CREDIT_RATING_GLOBAL] nvarchar(255)
    , [SP_TAX_ID] nvarchar(255)
    , [RD_CWOL_GLOBAL] nvarchar(255)
    , [RD_LAST_REVIEW_DATE_GLOBAL] datetime
    , [RD_RATING_ACTION_GLOBAL] nvarchar(255)
    , [ID] int
    , [SP_FITCH_INSURER_FSR] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R01_unsortedReportDa_B ', N'U') is null begin create table history_support_R01_unsortedReportDa_B ([valuationDate] datetime, [ID1] bigint
    , [Reinsurer Name] nvarchar(255)
    , [FEIN] nvarchar(255)
    , [LEI] nvarchar(255)
    , [Bank] nvarchar(255)
    , [Name] nvarchar(255)
    , [ID] nvarchar(255)
    , [All Securities] float
    , [Security Tests] float
    , [Level Tests] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R02_Dataload_A ', N'U') is null begin create table history_support_R02_Dataload_A ([valuationDate] datetime, [Account Title] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R02_fitchRatings ', N'U') is null begin create table history_support_R02_fitchRatings ([valuationDate] datetime, [ID] int
    , [CUSIP] nvarchar(255)
    , [Fitch Rating Lookup URL] nvarchar(255)
    , [Fitch Rating] nvarchar(255), j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R03_participations ', N'U') is null begin create table history_support_R03_participations ([valuationDate] datetime, [ID1] int
    , [multifamily] float
    , [ID] nvarchar(255)
    , [multiline] float
    , [premiumCapture] float
    , [﻿reinsurer name] nvarchar(255)
    , [FEIN] nvarchar(255)
    , [LEI] nvarchar(255)
    , [deal name] nvarchar(255)
    , [deal limit] float
    , [aon deal?] float
    , [effective date] datetime
    , [reinsurer participation pct] float
    , [reinsurer participation] float
    , [collateral requirement pct] float
    , [collateral requirement] float
    , [i] float
    , [eDealLimit_current] float
    , [eGridSampleEffectiveDate] datetime
    , [eReinsurerParticipation_current] float
    , [multiline|multifamily] nvarchar(255)
    , [multiline|multifamily|eGridSampleEffectiveDate] nvarchar(255)
    , [eGridSampleIndex] float
    , [eSp_rating_gridlookup] nvarchar(255)
    , [eAmbest_rating_gridlookup] nvarchar(255)
    , [eCollateralFactor_current] float
    , [eGridSampleIndex|eSp_rating_gridlookup|eAmbest_rating_gridlookup] nvarchar(255)
    , [eGridSampleMatch] float
    , [eReinsurerMatch] float
    , [eReinsurerAltName] nvarchar(255)
    , [eReductionFactor] float
    , [eReinsurerAltName|deal name] nvarchar(255)
    , [eReinsurerAndDealMatch] nvarchar(255)
    , [eDealAge] float
    , [ePipeiineLoss] float
    , [eDealAge_SeasoningLookup] float
    , [eSeasoningFactor] float
    , [eNetCollateralFactor] float
    , [eCollateralRequirement] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R03_stepdown_A ', N'U') is null begin create table history_support_R03_stepdown_A ([valuationDate] datetime, [Deal Cancellation Date] datetime
    , [Deal Name] nvarchar(255)
    , [Activity Period] datetime
    , [Stepdown Occurred?] nvarchar(255)
    , [Stepdown Test?] nvarchar(255)
    , [Measure Names] nvarchar(255)
    , [eCurrentRemainingLiabilityLimitFlag] float
    , [Measure Values] float
    , [eCurrentRemainingLiabilityLimitDeal] nvarchar(255)
    , [ePipelineLossDeal] nvarchar(255)
    , [ePipelineLossFlag] float
    , [dealName_last2monthsOnly] nvarchar(255)
    , [eActivityPeriodExCurrent] datetime
    , [activityPeriod_exMostRecent] datetime
    , [activityPeriod_last2monthsOnly] nvarchar(255)
    , [firstInstanceOfDeal] float
    , [momFlag] nvarchar(255)
    , [tally] float
    , [ID] int
    , [tallyNoRepeats] float, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R10_MoM_AssetChangeDetail ', N'U') is null begin create table history_support_R10_MoM_AssetChangeDetail ([valuationDate] datetime, [Account] nvarchar(255)
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
    , [i] bigint, j bigint identity(1,1)) end;


    if object_id(N'dbo.history_support_R11_AMBest_Ratings ', N'U') is null begin create table history_support_R11_AMBest_Ratings ([valuationDate] datetime, [ID] int
    , [AMB#] float
    , [NAIC#] float
    , [Company Name] nvarchar(255)
    , [Best's Financial Strength Rating - Current] nvarchar(255)
    , [Best's Long-Term Issuer Credit Rating - Current] nvarchar(255)
    , [Field6] nvarchar(255)
    , [Field7] nvarchar(255)
    , [Field10] nvarchar(255)
    , [Field8] float
    , [Field9] float
    , [Field11] nvarchar(255)
    , [Field12] nvarchar(255), j bigint identity(1,1)) end;
END
