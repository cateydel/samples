
drop table history_bkp_priorMonth_support_R02_DL_A;
go

drop table history_bkp_support_R01_cvMasterEntityIDMap;
go

drop table history_bkp_support_R02_Dataload_A;
go

drop table history_competingBrokerTrustAccounts;
go

drop table history_corporateBondFlags;
go

drop table history_corporateBondHaircutFactors;
go

drop table history_fitchBondRatingLookup;
go

drop table history_historyTableBuilds_tableAndColumnNames;
go

drop table history_individualAssetsFailingTests;
go

drop table history_industryOverridesByCUSIP;
go

drop table history_moodysBondRatingLookup;
go

drop table history_priorMonth_support_R01_spGlobal;
go

drop table history_priorMonth_support_R02_Dataload_A;
go

drop table history_priorMonth_Support_R11_AMBest_R;
go

drop table history_R01_reinsCollateralByAccount;
go

drop table history_R02_Coll_Held_1_Reinsurer;
go

drop table history_R03_Re_Collateral_by_Reinsurer;
go

drop table history_R04_Coll_Req_by_Reins_All_Deals;
go

drop table history_R05_Coll_Required_1_Reinsurer;
go

drop table history_R06_Global_Credit_Check;
go

drop table history_R07_Rating_Exception;
go

drop table history_R08_Maturity_Exceptions;
go

drop table history_R09_Individual_Weight_Check;
go

drop table history_R10_MoM_Asset_Changes;
go

drop table history_R11_MoM_Fin_Strength_Rtg_Changes;
go

drop table history_R12_Limit_Stepdowns;
go

drop table history_reinsurerSelection;
go

drop table history_spBondRatingLookup;
go

drop table history_support_R01_cvMasterEntityIDMap;
go

drop table history_support_R01_spGlobalFSRs;
go

drop table history_support_R01_unsortedReportDa_B;
go

drop table history_support_R02_Dataload_A;
go

drop table history_support_R02_fitchRatings;
go

drop table history_support_R03_participations;
go

drop table history_support_R03_stepdown_A;
go

drop table history_support_R10_MoM_AssetChangeDetail;
go

drop table history_support_R11_AMBest_Ratings;
go

create table history_bkp_priorMonth_support_R02_DL_A ([valuationDate] datetime, [ID] int
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
, [Market Value (Post-CBMV-Haircut)] float, j bigint identity(1,1));
go

create table history_bkp_support_R01_cvMasterEntityIDMap ([valuationDate] datetime, [ID1] int
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
, [eReinsurerName_ReductionFactorLookup] nvarchar(255), j bigint identity(1,1));
go

create table history_bkp_support_R02_Dataload_A ([valuationDate] datetime, [ID] int
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
, [Market Value (Post-CBMV-Haircut)] float, j bigint identity(1,1));
go

create table history_competingBrokerTrustAccounts ([valuationDate] datetime, [Account] nvarchar(255)
, [reinsurerName] nvarchar(255)
, [Description] nvarchar(255), j bigint identity(1,1));
go

create table history_corporateBondFlags ([valuationDate] datetime, [ID] int
, [Industry] nvarchar(255), j bigint identity(1,1));
go

create table history_corporateBondHaircutFactors ([valuationDate] datetime, [ID] int
, [Account Title] nvarchar(255)
, [Account Title|Industry] nvarchar(255)
, [Total Corporates] float
, [Total Credit Check] nvarchar(255)
, [Haircut Factor] float, j bigint identity(1,1));
go

create table history_fitchBondRatingLookup ([valuationDate] datetime, [A or Higher] float
, [Rating] nvarchar(255)
, [ID] int
, [Lower than A-] float, j bigint identity(1,1));
go

create table history_historyTableBuilds_tableAndColumnNames ([valuationDate] datetime, [TABLE_NAME] nvarchar(128)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_individualAssetsFailingTests ([valuationDate] datetime, [ID] int
, [Index] float
, [CUSIP] nvarchar(255), j bigint identity(1,1));
go

create table history_industryOverridesByCUSIP ([valuationDate] datetime, [CUSIP] nvarchar(255)
, [ID] int
, [Industry Override] nvarchar(255), j bigint identity(1,1));
go

create table history_moodysBondRatingLookup ([valuationDate] datetime, [A or Higher] float
, [Rating] nvarchar(255)
, [ID] int
, [Lower than A3] float, j bigint identity(1,1));
go

create table history_priorMonth_support_R01_spGlobal ([valuationDate] datetime, [SP_ENTITY_ID] float
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
, [SP_FITCH_INSURER_FSR] nvarchar(255), j bigint identity(1,1));
go

create table history_priorMonth_support_R02_Dataload_A ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_priorMonth_Support_R11_AMBest_R ([valuationDate] datetime, [ID] int
, [AMB#] float
, [NAIC#] float
, [Company Name] nvarchar(255)
, [Best's Financial Strength Rating - Current] nvarchar(255)
, [Best's Long-Term Issuer Credit Rating - Current] nvarchar(255), j bigint identity(1,1));
go

create table history_R01_reinsCollateralByAccount ([valuationDate] datetime, [reinsurerName] nvarchar(127)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R02_Coll_Held_1_Reinsurer ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R03_Re_Collateral_by_Reinsurer ([valuationDate] datetime, [Reinsurer Name] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R04_Coll_Req_by_Reins_All_Deals ([valuationDate] datetime, [reinsurerName] nvarchar(255)
, [dealName] nvarchar(255)
, [reinsurerParticipation_initial] float
, [effectiveDate] datetime
, [reinsurerParticipation] float
, [collateralFactor] float
, [reductionFactor] float
, [seasoningFactor] float
, [netCollateralFactor] float
, [collateralRequirement] float
, [i] bigint, j bigint identity(1,1));
go

create table history_R05_Coll_Required_1_Reinsurer ([valuationDate] datetime, [reinsurerName] nvarchar(255)
, [dealName] nvarchar(255)
, [reinsurerParticipation_initial] float
, [effectiveDate] datetime
, [reinsurerParticipation] float
, [collateralFactor] float
, [reductionFactor] float
, [seasoningFactor] float
, [netCollateralFactor] float
, [collateralRequirement] float
, [i] bigint, j bigint identity(1,1));
go

create table history_R06_Global_Credit_Check ([valuationDate] datetime, [reinsurerName] nvarchar(127)
, [Total Corporates] float
, [Total Credit Check] varchar(4)
, [Haircut Factor] float
, [i] bigint, j bigint identity(1,1));
go

create table history_R07_Rating_Exception ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R08_Maturity_Exceptions ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R09_Individual_Weight_Check ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R10_MoM_Asset_Changes ([valuationDate] datetime, [Account] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R11_MoM_Fin_Strength_Rtg_Changes ([valuationDate] datetime, [reinsurerName] nvarchar(127)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_R12_Limit_Stepdowns ([valuationDate] datetime, [deal] nvarchar(31)
, [remainingLimitOfLiability_Prior] float
, [remainingLimitOfLiability_Current] float
, [change] float
, [i] bigint, j bigint identity(1,1));
go

create table history_reinsurerSelection ([valuationDate] datetime, [reinsurerSelection] varchar(34), j bigint identity(1,1));
go

create table history_spBondRatingLookup ([valuationDate] datetime, [A or Higher] float
, [Rating] nvarchar(255)
, [ID] int
, [Lower than A-] float, j bigint identity(1,1));
go

create table history_support_R01_cvMasterEntityIDMap ([valuationDate] datetime, [ID1] int
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
, [eReinsurerName_ReductionFactorLookup] nvarchar(255), j bigint identity(1,1));
go

create table history_support_R01_spGlobalFSRs ([valuationDate] datetime, [SP_ENTITY_ID] nvarchar(255)
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
, [SP_FITCH_INSURER_FSR] nvarchar(255), j bigint identity(1,1));
go

create table history_support_R01_unsortedReportDa_B ([valuationDate] datetime, [ID1] bigint
, [Reinsurer Name] nvarchar(255)
, [FEIN] nvarchar(255)
, [LEI] nvarchar(255)
, [Bank] nvarchar(255)
, [Name] nvarchar(255)
, [ID] nvarchar(255)
, [All Securities] float
, [Security Tests] float
, [Level Tests] float, j bigint identity(1,1));
go

create table history_support_R02_Dataload_A ([valuationDate] datetime, [Account Title] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_support_R02_fitchRatings ([valuationDate] datetime, [ID] int
, [CUSIP] nvarchar(255)
, [Fitch Rating Lookup URL] nvarchar(255)
, [Fitch Rating] nvarchar(255), j bigint identity(1,1));
go

create table history_support_R03_participations ([valuationDate] datetime, [ID1] int
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
, [eCollateralRequirement] float, j bigint identity(1,1));
go

create table history_support_R03_stepdown_A ([valuationDate] datetime, [Deal Cancellation Date] datetime
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
, [tallyNoRepeats] float, j bigint identity(1,1));
go

create table history_support_R10_MoM_AssetChangeDetail ([valuationDate] datetime, [Account] nvarchar(255)
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
, [i] bigint, j bigint identity(1,1));
go

create table history_support_R11_AMBest_Ratings ([valuationDate] datetime, [ID] int
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
, [Field12] nvarchar(255), j bigint identity(1,1));
go

insert into history_bkp_priorMonth_support_R02_DL_A ([valuationDate], [ID]
, [Account Title]
, [Account]
, [Description]
, [Portfolio Type]
, [Security Type]
, [Industry (Original)]
, [S&P Rating]
, [Market Value (Pre-Test)]
, [Maturity Date]
, [Years to Maturity]
, [Moody's Rating]
, [MV % of Total]
, [As of Date]
, [CUSIP]
, [Corporate Bond Flag (CB)]
, [CUSIP_noSpaces]
, [Industry]
, [3yr Maturity Flag (M3)]
, [Flag for 10%+ MV of Total (MV10)]
, [Valid S&P Bond Rating Flag (SPBR)]
, [Valid Moody's Bond Rating Flag (MBR)]
, [Flag for S&P Bond Rating A or Higher (SPBRA)]
, [Flag for Moody's Bond Rating A or Higher (MBRA)]
, [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, [Fitch Check Flag (FC)]
, [Fitch Rating]
, [CB*M3]
, [Flag for Fitch Bond Rating A or Higher (FBRA)]
, [Impermissible Corporate Bond due to Ratings (ICBR)]
, [CB*MV10]
, [At Least 1 Exception pre-Fitch Check]
, [At Least 1 Exception post-Fitch Check]
, [Market Value (Corporates)]
, [Market Value (Corporates >= 3yrs)]
, [accountChangeFlag]
, [Market Value (Post-Individual-Test)]
, [Market Value (Post-CBMV-Haircut)])
select RVD.[reportValuationDate], T.[ID]
, T.[Account Title]
, T.[Account]
, T.[Description]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Industry (Original)]
, T.[S&P Rating]
, T.[Market Value (Pre-Test)]
, T.[Maturity Date]
, T.[Years to Maturity]
, T.[Moody's Rating]
, T.[MV % of Total]
, T.[As of Date]
, T.[CUSIP]
, T.[Corporate Bond Flag (CB)]
, T.[CUSIP_noSpaces]
, T.[Industry]
, T.[3yr Maturity Flag (M3)]
, T.[Flag for 10%+ MV of Total (MV10)]
, T.[Valid S&P Bond Rating Flag (SPBR)]
, T.[Valid Moody's Bond Rating Flag (MBR)]
, T.[Flag for S&P Bond Rating A or Higher (SPBRA)]
, T.[Flag for Moody's Bond Rating A or Higher (MBRA)]
, T.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, T.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, T.[Fitch Check Flag (FC)]
, T.[Fitch Rating]
, T.[CB*M3]
, T.[Flag for Fitch Bond Rating A or Higher (FBRA)]
, T.[Impermissible Corporate Bond due to Ratings (ICBR)]
, T.[CB*MV10]
, T.[At Least 1 Exception pre-Fitch Check]
, T.[At Least 1 Exception post-Fitch Check]
, T.[Market Value (Corporates)]
, T.[Market Value (Corporates >= 3yrs)]
, T.[accountChangeFlag]
, T.[Market Value (Post-Individual-Test)]
, T.[Market Value (Post-CBMV-Haircut)] from reportValuationDate RVD, bkp_priorMonth_support_R02_DL_A T;
go

insert into history_bkp_support_R01_cvMasterEntityIDMap ([valuationDate], [ID1]
, [ID]
, [FEIN]
, [Reinsurer_Name]
, [Reinsurer_Name_AonVersion]
, [LEI]
, [rating_SPCIQ_ID]
, [rating_AM_Best_Number]
, [trustAccount1]
, [fitch_rating_raw]
, [trustAccount2]
, [trustAccount3]
, [sp_rating_raw]
, [ambest_rating_raw]
, [sp_rating_gridlookup]
, [ambest_rating_gridlookup]
, [eRatingPairing_gridLookup]
, [eActiveReinsurer]
, [eMultifamily]
, [eMultiline]
, [ePremiumCapture]
, [eReinsurerName_ReductionFactorLookup])
select RVD.[reportValuationDate], T.[ID1]
, T.[ID]
, T.[FEIN]
, T.[Reinsurer_Name]
, T.[Reinsurer_Name_AonVersion]
, T.[LEI]
, T.[rating_SPCIQ_ID]
, T.[rating_AM_Best_Number]
, T.[trustAccount1]
, T.[fitch_rating_raw]
, T.[trustAccount2]
, T.[trustAccount3]
, T.[sp_rating_raw]
, T.[ambest_rating_raw]
, T.[sp_rating_gridlookup]
, T.[ambest_rating_gridlookup]
, T.[eRatingPairing_gridLookup]
, T.[eActiveReinsurer]
, T.[eMultifamily]
, T.[eMultiline]
, T.[ePremiumCapture]
, T.[eReinsurerName_ReductionFactorLookup] from reportValuationDate RVD, bkp_support_R01_cvMasterEntityIDMap T;
go

insert into history_bkp_support_R02_Dataload_A ([valuationDate], [ID]
, [Account Title]
, [Account]
, [Description]
, [Portfolio Type]
, [Security Type]
, [Industry (Original)]
, [S&P Rating]
, [Market Value (Pre-Test)]
, [Maturity Date]
, [Years to Maturity]
, [Moody's Rating]
, [MV % of Total]
, [As of Date]
, [CUSIP]
, [Corporate Bond Flag (CB)]
, [CUSIP_noSpaces]
, [Industry]
, [3yr Maturity Flag (M3)]
, [Flag for 10%+ MV of Total (MV10)]
, [Valid S&P Bond Rating Flag (SPBR)]
, [Valid Moody's Bond Rating Flag (MBR)]
, [Flag for S&P Bond Rating A or Higher (SPBRA)]
, [Flag for Moody's Bond Rating A or Higher (MBRA)]
, [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, [Fitch Check Flag (FC)]
, [Fitch Rating]
, [CB*M3]
, [Flag for Fitch Bond Rating A or Higher (FBRA)]
, [Impermissible Corporate Bond due to Ratings (ICBR)]
, [CB*MV10]
, [At Least 1 Exception pre-Fitch Check]
, [At Least 1 Exception post-Fitch Check]
, [Market Value (Corporates)]
, [Market Value (Corporates >= 3yrs)]
, [accountChangeFlag]
, [Market Value (Post-Individual-Test)]
, [Market Value (Post-CBMV-Haircut)])
select RVD.[reportValuationDate], T.[ID]
, T.[Account Title]
, T.[Account]
, T.[Description]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Industry (Original)]
, T.[S&P Rating]
, T.[Market Value (Pre-Test)]
, T.[Maturity Date]
, T.[Years to Maturity]
, T.[Moody's Rating]
, T.[MV % of Total]
, T.[As of Date]
, T.[CUSIP]
, T.[Corporate Bond Flag (CB)]
, T.[CUSIP_noSpaces]
, T.[Industry]
, T.[3yr Maturity Flag (M3)]
, T.[Flag for 10%+ MV of Total (MV10)]
, T.[Valid S&P Bond Rating Flag (SPBR)]
, T.[Valid Moody's Bond Rating Flag (MBR)]
, T.[Flag for S&P Bond Rating A or Higher (SPBRA)]
, T.[Flag for Moody's Bond Rating A or Higher (MBRA)]
, T.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, T.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, T.[Fitch Check Flag (FC)]
, T.[Fitch Rating]
, T.[CB*M3]
, T.[Flag for Fitch Bond Rating A or Higher (FBRA)]
, T.[Impermissible Corporate Bond due to Ratings (ICBR)]
, T.[CB*MV10]
, T.[At Least 1 Exception pre-Fitch Check]
, T.[At Least 1 Exception post-Fitch Check]
, T.[Market Value (Corporates)]
, T.[Market Value (Corporates >= 3yrs)]
, T.[accountChangeFlag]
, T.[Market Value (Post-Individual-Test)]
, T.[Market Value (Post-CBMV-Haircut)] from reportValuationDate RVD, bkp_support_R02_Dataload_A T;
go

insert into history_competingBrokerTrustAccounts ([valuationDate], [Account]
, [reinsurerName]
, [Description])
select RVD.[reportValuationDate], T.[Account]
, T.[reinsurerName]
, T.[Description] from reportValuationDate RVD, competingBrokerTrustAccounts T;
go

insert into history_corporateBondFlags ([valuationDate], [ID]
, [Industry])
select RVD.[reportValuationDate], T.[ID]
, T.[Industry] from reportValuationDate RVD, corporateBondFlags T;
go

insert into history_corporateBondHaircutFactors ([valuationDate], [ID]
, [Account Title]
, [Account Title|Industry]
, [Total Corporates]
, [Total Credit Check]
, [Haircut Factor])
select RVD.[reportValuationDate], T.[ID]
, T.[Account Title]
, T.[Account Title|Industry]
, T.[Total Corporates]
, T.[Total Credit Check]
, T.[Haircut Factor] from reportValuationDate RVD, corporateBondHaircutFactors T;
go

insert into history_fitchBondRatingLookup ([valuationDate], [A or Higher]
, [Rating]
, [ID]
, [Lower than A-])
select RVD.[reportValuationDate], T.[A or Higher]
, T.[Rating]
, T.[ID]
, T.[Lower than A-] from reportValuationDate RVD, fitchBondRatingLookup T;
go

insert into history_historyTableBuilds_tableAndColumnNames ([valuationDate], [TABLE_NAME]
, [COLUMN_NAME]
, [ORDINAL_POSITION]
, [DATA_TYPE]
, [CHARACTER_MAXIMUM_LENGTH]
, [startingRow]
, [finalRow]
, [sqlCode_dropTable]
, [sqlCode_createTable]
, [sqlCode_insertInto]
, [sqlCode_select]
, [i])
select RVD.[reportValuationDate], T.[TABLE_NAME]
, T.[COLUMN_NAME]
, T.[ORDINAL_POSITION]
, T.[DATA_TYPE]
, T.[CHARACTER_MAXIMUM_LENGTH]
, T.[startingRow]
, T.[finalRow]
, T.[sqlCode_dropTable]
, T.[sqlCode_createTable]
, T.[sqlCode_insertInto]
, T.[sqlCode_select]
, T.[i] from reportValuationDate RVD, historyTableBuilds_tableAndColumnNames T;
go

insert into history_individualAssetsFailingTests ([valuationDate], [ID]
, [Index]
, [CUSIP])
select RVD.[reportValuationDate], T.[ID]
, T.[Index]
, T.[CUSIP] from reportValuationDate RVD, individualAssetsFailingTests T;
go

insert into history_industryOverridesByCUSIP ([valuationDate], [CUSIP]
, [ID]
, [Industry Override])
select RVD.[reportValuationDate], T.[CUSIP]
, T.[ID]
, T.[Industry Override] from reportValuationDate RVD, industryOverridesByCUSIP T;
go

insert into history_moodysBondRatingLookup ([valuationDate], [A or Higher]
, [Rating]
, [ID]
, [Lower than A3])
select RVD.[reportValuationDate], T.[A or Higher]
, T.[Rating]
, T.[ID]
, T.[Lower than A3] from reportValuationDate RVD, moodysBondRatingLookup T;
go

insert into history_priorMonth_support_R01_spGlobal ([valuationDate], [SP_ENTITY_ID]
, [SP_ENTITY_NAME]
, [SP_COMPANY_NAME_ABBR]
, [SP_CIQ_ID]
, [SP_COMPANY_NAME_SHORT]
, [SP_LEI]
, [RD_CREDIT_RATING_GLOBAL]
, [SP_TAX_ID]
, [RD_CWOL_GLOBAL]
, [RD_LAST_REVIEW_DATE_GLOBAL]
, [RD_RATING_ACTION_GLOBAL]
, [ID]
, [SP_FITCH_INSURER_FSR])
select RVD.[reportValuationDate], T.[SP_ENTITY_ID]
, T.[SP_ENTITY_NAME]
, T.[SP_COMPANY_NAME_ABBR]
, T.[SP_CIQ_ID]
, T.[SP_COMPANY_NAME_SHORT]
, T.[SP_LEI]
, T.[RD_CREDIT_RATING_GLOBAL]
, T.[SP_TAX_ID]
, T.[RD_CWOL_GLOBAL]
, T.[RD_LAST_REVIEW_DATE_GLOBAL]
, T.[RD_RATING_ACTION_GLOBAL]
, T.[ID]
, T.[SP_FITCH_INSURER_FSR] from reportValuationDate RVD, priorMonth_support_R01_spGlobal T;
go

insert into history_priorMonth_support_R02_Dataload_A ([valuationDate], [Account Title]
, [Account]
, [Description]
, [Portfolio Type]
, [Security Type]
, [Industry (Original)]
, [S&P Rating]
, [Market Value (Pre-Test)]
, [Maturity Date]
, [Years to Maturity]
, [Moody's Rating]
, [MV % of Total]
, [As of Date]
, [CUSIP]
, [Corporate Bond Flag (CB)]
, [CUSIP_noSpaces]
, [Industry]
, [3yr Maturity Flag (M3)]
, [Flag for 10%+ MV of Total (MV10)]
, [Valid S&P Bond Rating Flag (SPBR)]
, [Valid Moody's Bond Rating Flag (MBR)]
, [Flag for S&P Bond Rating A or Higher (SPBRA)]
, [Flag for Moody's Bond Rating A or Higher (MBRA)]
, [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, [Fitch Check Flag (FC)]
, [Fitch Rating]
, [CB*M3]
, [Flag for Fitch Bond Rating A or Higher (FBRA)]
, [Impermissible Corporate Bond due to Ratings (ICBR)]
, [CB*MV10]
, [At Least 1 Exception pre-Fitch Check]
, [At Least 1 Exception post-Fitch Check]
, [Market Value (Corporates)]
, [Market Value (Corporates >= 3yrs)]
, [accountChangeFlag]
, [Market Value (Post-Individual-Test)]
, [Market Value (Post-CBMV-Haircut)]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Description]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Industry (Original)]
, T.[S&P Rating]
, T.[Market Value (Pre-Test)]
, T.[Maturity Date]
, T.[Years to Maturity]
, T.[Moody's Rating]
, T.[MV % of Total]
, T.[As of Date]
, T.[CUSIP]
, T.[Corporate Bond Flag (CB)]
, T.[CUSIP_noSpaces]
, T.[Industry]
, T.[3yr Maturity Flag (M3)]
, T.[Flag for 10%+ MV of Total (MV10)]
, T.[Valid S&P Bond Rating Flag (SPBR)]
, T.[Valid Moody's Bond Rating Flag (MBR)]
, T.[Flag for S&P Bond Rating A or Higher (SPBRA)]
, T.[Flag for Moody's Bond Rating A or Higher (MBRA)]
, T.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, T.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, T.[Fitch Check Flag (FC)]
, T.[Fitch Rating]
, T.[CB*M3]
, T.[Flag for Fitch Bond Rating A or Higher (FBRA)]
, T.[Impermissible Corporate Bond due to Ratings (ICBR)]
, T.[CB*MV10]
, T.[At Least 1 Exception pre-Fitch Check]
, T.[At Least 1 Exception post-Fitch Check]
, T.[Market Value (Corporates)]
, T.[Market Value (Corporates >= 3yrs)]
, T.[accountChangeFlag]
, T.[Market Value (Post-Individual-Test)]
, T.[Market Value (Post-CBMV-Haircut)]
, T.[i] from reportValuationDate RVD, priorMonth_support_R02_Dataload_A T;
go

insert into history_priorMonth_Support_R11_AMBest_R ([valuationDate], [ID]
, [AMB#]
, [NAIC#]
, [Company Name]
, [Best's Financial Strength Rating - Current]
, [Best's Long-Term Issuer Credit Rating - Current])
select RVD.[reportValuationDate], T.[ID]
, T.[AMB#]
, T.[NAIC#]
, T.[Company Name]
, T.[Best's Financial Strength Rating - Current]
, T.[Best's Long-Term Issuer Credit Rating - Current] from reportValuationDate RVD, priorMonth_Support_R11_AMBest_R T;
go

insert into history_R01_reinsCollateralByAccount ([valuationDate], [reinsurerName]
, [FEIN]
, [LEI]
, [trustAccountBank]
, [trustAccountName]
, [trustAccountID]
, [mv_collHeld_cashAndSec_combined]
, [mv_collHeld_cashAndSec_passingIndivTests]
, [mv_collHeld_cashAndSec_passingPortTests]
, [mv_collHeld_corpBonds_all_nominal]
, [mv_collHeld_corpBonds_all_pctOfCombined]
, [mv_collHeld_corpBonds_3yr_nominal]
, [mv_collHeld_corpBonds_3yr_pctOfCombined]
, [i])
select RVD.[reportValuationDate], T.[reinsurerName]
, T.[FEIN]
, T.[LEI]
, T.[trustAccountBank]
, T.[trustAccountName]
, T.[trustAccountID]
, T.[mv_collHeld_cashAndSec_combined]
, T.[mv_collHeld_cashAndSec_passingIndivTests]
, T.[mv_collHeld_cashAndSec_passingPortTests]
, T.[mv_collHeld_corpBonds_all_nominal]
, T.[mv_collHeld_corpBonds_all_pctOfCombined]
, T.[mv_collHeld_corpBonds_3yr_nominal]
, T.[mv_collHeld_corpBonds_3yr_pctOfCombined]
, T.[i] from reportValuationDate RVD, R01_reinsCollateralByAccount T;
go

insert into history_R02_Coll_Held_1_Reinsurer ([valuationDate], [Account Title]
, [Account]
, [Portfolio Type]
, [Security Type]
, [Description]
, [Industry]
, [CUSIP]
, [Maturity Date]
, [Years to Maturity]
, [As of Date]
, [S&P Rating]
, [Moody's Rating]
, [Market Value (Pre-Test)]
, [MV % of Total]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Description]
, T.[Industry]
, T.[CUSIP]
, T.[Maturity Date]
, T.[Years to Maturity]
, T.[As of Date]
, T.[S&P Rating]
, T.[Moody's Rating]
, T.[Market Value (Pre-Test)]
, T.[MV % of Total]
, T.[i] from reportValuationDate RVD, R02_Coll_Held_1_Reinsurer T;
go

insert into history_R03_Re_Collateral_by_Reinsurer ([valuationDate], [Reinsurer Name]
, [FEIN]
, [LEI]
, [Trust Account 1]
, [Trust Account 2]
, [Trust Account 3]
, [Market Value of Collateral]
, [100pct of Collateral Required]
, [102pct of Collateral Required]
, [Ratio of Collateral Held to Collateral Required]
, [Collateral Shortfall]
, [Excess Collateral]
, [Combined Collateral Variance]
, [i])
select RVD.[reportValuationDate], T.[Reinsurer Name]
, T.[FEIN]
, T.[LEI]
, T.[Trust Account 1]
, T.[Trust Account 2]
, T.[Trust Account 3]
, T.[Market Value of Collateral]
, T.[100pct of Collateral Required]
, T.[102pct of Collateral Required]
, T.[Ratio of Collateral Held to Collateral Required]
, T.[Collateral Shortfall]
, T.[Excess Collateral]
, T.[Combined Collateral Variance]
, T.[i] from reportValuationDate RVD, R03_Re_Collateral_by_Reinsurer T;
go

insert into history_R04_Coll_Req_by_Reins_All_Deals ([valuationDate], [reinsurerName]
, [dealName]
, [reinsurerParticipation_initial]
, [effectiveDate]
, [reinsurerParticipation]
, [collateralFactor]
, [reductionFactor]
, [seasoningFactor]
, [netCollateralFactor]
, [collateralRequirement]
, [i])
select RVD.[reportValuationDate], T.[reinsurerName]
, T.[dealName]
, T.[reinsurerParticipation_initial]
, T.[effectiveDate]
, T.[reinsurerParticipation]
, T.[collateralFactor]
, T.[reductionFactor]
, T.[seasoningFactor]
, T.[netCollateralFactor]
, T.[collateralRequirement]
, T.[i] from reportValuationDate RVD, R04_Coll_Req_by_Reins_All_Deals T;
go

insert into history_R05_Coll_Required_1_Reinsurer ([valuationDate], [reinsurerName]
, [dealName]
, [reinsurerParticipation_initial]
, [effectiveDate]
, [reinsurerParticipation]
, [collateralFactor]
, [reductionFactor]
, [seasoningFactor]
, [netCollateralFactor]
, [collateralRequirement]
, [i])
select RVD.[reportValuationDate], T.[reinsurerName]
, T.[dealName]
, T.[reinsurerParticipation_initial]
, T.[effectiveDate]
, T.[reinsurerParticipation]
, T.[collateralFactor]
, T.[reductionFactor]
, T.[seasoningFactor]
, T.[netCollateralFactor]
, T.[collateralRequirement]
, T.[i] from reportValuationDate RVD, R05_Coll_Required_1_Reinsurer T;
go

insert into history_R06_Global_Credit_Check ([valuationDate], [reinsurerName]
, [Total Corporates]
, [Total Credit Check]
, [Haircut Factor]
, [i])
select RVD.[reportValuationDate], T.[reinsurerName]
, T.[Total Corporates]
, T.[Total Credit Check]
, T.[Haircut Factor]
, T.[i] from reportValuationDate RVD, R06_Global_Credit_Check T;
go

insert into history_R07_Rating_Exception ([valuationDate], [Account Title]
, [Account]
, [Portfolio Type]
, [Security Type]
, [Description]
, [Industry]
, [CUSIP]
, [Maturity Date]
, [Market Value]
, [MV % of Total]
, [Years to Maturity]
, [As of Date]
, [S&P Rating]
, [Moody's Rating]
, [Fitch Rating]
, [Rating Check]
, [Maturity Check]
, [Individual Weight Check]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Description]
, T.[Industry]
, T.[CUSIP]
, T.[Maturity Date]
, T.[Market Value]
, T.[MV % of Total]
, T.[Years to Maturity]
, T.[As of Date]
, T.[S&P Rating]
, T.[Moody's Rating]
, T.[Fitch Rating]
, T.[Rating Check]
, T.[Maturity Check]
, T.[Individual Weight Check]
, T.[i] from reportValuationDate RVD, R07_Rating_Exception T;
go

insert into history_R08_Maturity_Exceptions ([valuationDate], [Account Title]
, [Account]
, [Portfolio Type]
, [Security Type]
, [Description]
, [Industry]
, [CUSIP]
, [Maturity Date]
, [Market Value]
, [MV % of Total]
, [Years to Maturity]
, [As of Date]
, [S&P Rating]
, [Moody's Rating]
, [Fitch Rating]
, [Rating Check]
, [Maturity Check]
, [Individual Weight Check]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Description]
, T.[Industry]
, T.[CUSIP]
, T.[Maturity Date]
, T.[Market Value]
, T.[MV % of Total]
, T.[Years to Maturity]
, T.[As of Date]
, T.[S&P Rating]
, T.[Moody's Rating]
, T.[Fitch Rating]
, T.[Rating Check]
, T.[Maturity Check]
, T.[Individual Weight Check]
, T.[i] from reportValuationDate RVD, R08_Maturity_Exceptions T;
go

insert into history_R09_Individual_Weight_Check ([valuationDate], [Account Title]
, [Account]
, [Portfolio Type]
, [Security Type]
, [Description]
, [Industry]
, [CUSIP]
, [Maturity Date]
, [Market Value]
, [MV % of Total]
, [Years to Maturity]
, [As of Date]
, [S&P Rating]
, [Moody's Rating]
, [Fitch Rating]
, [Rating Check]
, [Maturity Check]
, [Individual Weight Check]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Description]
, T.[Industry]
, T.[CUSIP]
, T.[Maturity Date]
, T.[Market Value]
, T.[MV % of Total]
, T.[Years to Maturity]
, T.[As of Date]
, T.[S&P Rating]
, T.[Moody's Rating]
, T.[Fitch Rating]
, T.[Rating Check]
, T.[Maturity Check]
, T.[Individual Weight Check]
, T.[i] from reportValuationDate RVD, R09_Individual_Weight_Check T;
go

insert into history_R10_MoM_Asset_Changes ([valuationDate], [Account]
, [Description]
, [reinsurerName]
, [marketValue_runoff]
, [marketValue_new]
, [marketValue_continuing_prior]
, [marketValue_continuing_current]
, [marketValue_continuing_change]
, [marketValue_combined_prior]
, [marketValue_combined_current]
, [marketValue_combined_change]
, [i])
select RVD.[reportValuationDate], T.[Account]
, T.[Description]
, T.[reinsurerName]
, T.[marketValue_runoff]
, T.[marketValue_new]
, T.[marketValue_continuing_prior]
, T.[marketValue_continuing_current]
, T.[marketValue_continuing_change]
, T.[marketValue_combined_prior]
, T.[marketValue_combined_current]
, T.[marketValue_combined_change]
, T.[i] from reportValuationDate RVD, R10_MoM_Asset_Changes T;
go

insert into history_R11_MoM_Fin_Strength_Rtg_Changes ([valuationDate], [reinsurerName]
, [rating_SPCIQ_ID]
, [rating_SPCIQ_Prior]
, [rating_SPCIQ_Current]
, [rating_SPCIQ_Change]
, [rating_Fitch_Prior]
, [rating_Fitch_Current]
, [rating_Fitch_Change]
, [rating_AM_Best_Number]
, [rating_AM_Best_Prior]
, [rating_AM_Best_Current]
, [rating_AM_Best_Change]
, [i])
select RVD.[reportValuationDate], T.[reinsurerName]
, T.[rating_SPCIQ_ID]
, T.[rating_SPCIQ_Prior]
, T.[rating_SPCIQ_Current]
, T.[rating_SPCIQ_Change]
, T.[rating_Fitch_Prior]
, T.[rating_Fitch_Current]
, T.[rating_Fitch_Change]
, T.[rating_AM_Best_Number]
, T.[rating_AM_Best_Prior]
, T.[rating_AM_Best_Current]
, T.[rating_AM_Best_Change]
, T.[i] from reportValuationDate RVD, R11_MoM_Fin_Strength_Rtg_Changes T;
go

insert into history_R12_Limit_Stepdowns ([valuationDate], [deal]
, [remainingLimitOfLiability_Prior]
, [remainingLimitOfLiability_Current]
, [change]
, [i])
select RVD.[reportValuationDate], T.[deal]
, T.[remainingLimitOfLiability_Prior]
, T.[remainingLimitOfLiability_Current]
, T.[change]
, T.[i] from reportValuationDate RVD, R12_Limit_Stepdowns T;
go

insert into history_reinsurerSelection ([valuationDate], [reinsurerSelection])
select RVD.[reportValuationDate], T.[reinsurerSelection] from reportValuationDate RVD, reinsurerSelection T;
go

insert into history_spBondRatingLookup ([valuationDate], [A or Higher]
, [Rating]
, [ID]
, [Lower than A-])
select RVD.[reportValuationDate], T.[A or Higher]
, T.[Rating]
, T.[ID]
, T.[Lower than A-] from reportValuationDate RVD, spBondRatingLookup T;
go

insert into history_support_R01_cvMasterEntityIDMap ([valuationDate], [ID1]
, [ID]
, [FEIN]
, [Reinsurer_Name]
, [Reinsurer_Name_AonVersion]
, [LEI]
, [rating_SPCIQ_ID]
, [rating_AM_Best_Number]
, [trustAccount1]
, [fitch_rating_raw]
, [trustAccount2]
, [trustAccount3]
, [sp_rating_raw]
, [ambest_rating_raw]
, [sp_rating_gridlookup]
, [ambest_rating_gridlookup]
, [eRatingPairing_gridLookup]
, [eActiveReinsurer]
, [eMultifamily]
, [eMultiline]
, [ePremiumCapture]
, [eReinsurerName_ReductionFactorLookup])
select RVD.[reportValuationDate], T.[ID1]
, T.[ID]
, T.[FEIN]
, T.[Reinsurer_Name]
, T.[Reinsurer_Name_AonVersion]
, T.[LEI]
, T.[rating_SPCIQ_ID]
, T.[rating_AM_Best_Number]
, T.[trustAccount1]
, T.[fitch_rating_raw]
, T.[trustAccount2]
, T.[trustAccount3]
, T.[sp_rating_raw]
, T.[ambest_rating_raw]
, T.[sp_rating_gridlookup]
, T.[ambest_rating_gridlookup]
, T.[eRatingPairing_gridLookup]
, T.[eActiveReinsurer]
, T.[eMultifamily]
, T.[eMultiline]
, T.[ePremiumCapture]
, T.[eReinsurerName_ReductionFactorLookup] from reportValuationDate RVD, support_R01_cvMasterEntityIDMap T;
go

insert into history_support_R01_spGlobalFSRs ([valuationDate], [SP_ENTITY_ID]
, [SP_ENTITY_NAME]
, [SP_COMPANY_NAME_ABBR]
, [SP_CIQ_ID]
, [SP_COMPANY_NAME_SHORT]
, [SP_LEI]
, [RD_CREDIT_RATING_GLOBAL]
, [SP_TAX_ID]
, [RD_CWOL_GLOBAL]
, [RD_LAST_REVIEW_DATE_GLOBAL]
, [RD_RATING_ACTION_GLOBAL]
, [ID]
, [SP_FITCH_INSURER_FSR])
select RVD.[reportValuationDate], T.[SP_ENTITY_ID]
, T.[SP_ENTITY_NAME]
, T.[SP_COMPANY_NAME_ABBR]
, T.[SP_CIQ_ID]
, T.[SP_COMPANY_NAME_SHORT]
, T.[SP_LEI]
, T.[RD_CREDIT_RATING_GLOBAL]
, T.[SP_TAX_ID]
, T.[RD_CWOL_GLOBAL]
, T.[RD_LAST_REVIEW_DATE_GLOBAL]
, T.[RD_RATING_ACTION_GLOBAL]
, T.[ID]
, T.[SP_FITCH_INSURER_FSR] from reportValuationDate RVD, support_R01_spGlobalFSRs T;
go

insert into history_support_R01_unsortedReportDa_B ([valuationDate], [ID1]
, [Reinsurer Name]
, [FEIN]
, [LEI]
, [Bank]
, [Name]
, [ID]
, [All Securities]
, [Security Tests]
, [Level Tests])
select RVD.[reportValuationDate], T.[ID1]
, T.[Reinsurer Name]
, T.[FEIN]
, T.[LEI]
, T.[Bank]
, T.[Name]
, T.[ID]
, T.[All Securities]
, T.[Security Tests]
, T.[Level Tests] from reportValuationDate RVD, support_R01_unsortedReportDa_B T;
go

insert into history_support_R02_Dataload_A ([valuationDate], [Account Title]
, [Account]
, [Description]
, [Portfolio Type]
, [Security Type]
, [Industry (Original)]
, [S&P Rating]
, [Market Value (Pre-Test)]
, [Maturity Date]
, [Years to Maturity]
, [Moody's Rating]
, [MV % of Total]
, [As of Date]
, [CUSIP]
, [Corporate Bond Flag (CB)]
, [CUSIP_noSpaces]
, [Industry]
, [3yr Maturity Flag (M3)]
, [Flag for 10%+ MV of Total (MV10)]
, [Valid S&P Bond Rating Flag (SPBR)]
, [Valid Moody's Bond Rating Flag (MBR)]
, [Flag for S&P Bond Rating A or Higher (SPBRA)]
, [Flag for Moody's Bond Rating A or Higher (MBRA)]
, [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, [Fitch Check Flag (FC)]
, [Fitch Rating]
, [CB*M3]
, [Flag for Fitch Bond Rating A or Higher (FBRA)]
, [Impermissible Corporate Bond due to Ratings (ICBR)]
, [CB*MV10]
, [At Least 1 Exception pre-Fitch Check]
, [At Least 1 Exception post-Fitch Check]
, [Market Value (Corporates)]
, [Market Value (Corporates >= 3yrs)]
, [accountChangeFlag]
, [Market Value (Post-Individual-Test)]
, [Market Value (Post-CBMV-Haircut)]
, [i])
select RVD.[reportValuationDate], T.[Account Title]
, T.[Account]
, T.[Description]
, T.[Portfolio Type]
, T.[Security Type]
, T.[Industry (Original)]
, T.[S&P Rating]
, T.[Market Value (Pre-Test)]
, T.[Maturity Date]
, T.[Years to Maturity]
, T.[Moody's Rating]
, T.[MV % of Total]
, T.[As of Date]
, T.[CUSIP]
, T.[Corporate Bond Flag (CB)]
, T.[CUSIP_noSpaces]
, T.[Industry]
, T.[3yr Maturity Flag (M3)]
, T.[Flag for 10%+ MV of Total (MV10)]
, T.[Valid S&P Bond Rating Flag (SPBR)]
, T.[Valid Moody's Bond Rating Flag (MBR)]
, T.[Flag for S&P Bond Rating A or Higher (SPBRA)]
, T.[Flag for Moody's Bond Rating A or Higher (MBRA)]
, T.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
, T.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
, T.[Fitch Check Flag (FC)]
, T.[Fitch Rating]
, T.[CB*M3]
, T.[Flag for Fitch Bond Rating A or Higher (FBRA)]
, T.[Impermissible Corporate Bond due to Ratings (ICBR)]
, T.[CB*MV10]
, T.[At Least 1 Exception pre-Fitch Check]
, T.[At Least 1 Exception post-Fitch Check]
, T.[Market Value (Corporates)]
, T.[Market Value (Corporates >= 3yrs)]
, T.[accountChangeFlag]
, T.[Market Value (Post-Individual-Test)]
, T.[Market Value (Post-CBMV-Haircut)]
, T.[i] from reportValuationDate RVD, support_R02_Dataload_A T;
go

insert into history_support_R02_fitchRatings ([valuationDate], [ID]
, [CUSIP]
, [Fitch Rating Lookup URL]
, [Fitch Rating])
select RVD.[reportValuationDate], T.[ID]
, T.[CUSIP]
, T.[Fitch Rating Lookup URL]
, T.[Fitch Rating] from reportValuationDate RVD, support_R02_fitchRatings T;
go

insert into history_support_R03_participations ([valuationDate], [ID1]
, [multifamily]
, [ID]
, [multiline]
, [premiumCapture]
, [﻿reinsurer name]
, [FEIN]
, [LEI]
, [deal name]
, [deal limit]
, [aon deal?]
, [effective date]
, [reinsurer participation pct]
, [reinsurer participation]
, [collateral requirement pct]
, [collateral requirement]
, [i]
, [eDealLimit_current]
, [eGridSampleEffectiveDate]
, [eReinsurerParticipation_current]
, [multiline|multifamily]
, [multiline|multifamily|eGridSampleEffectiveDate]
, [eGridSampleIndex]
, [eSp_rating_gridlookup]
, [eAmbest_rating_gridlookup]
, [eCollateralFactor_current]
, [eGridSampleIndex|eSp_rating_gridlookup|eAmbest_rating_gridlookup]
, [eGridSampleMatch]
, [eReinsurerMatch]
, [eReinsurerAltName]
, [eReductionFactor]
, [eReinsurerAltName|deal name]
, [eReinsurerAndDealMatch]
, [eDealAge]
, [ePipeiineLoss]
, [eDealAge_SeasoningLookup]
, [eSeasoningFactor]
, [eNetCollateralFactor]
, [eCollateralRequirement])
select RVD.[reportValuationDate], T.[ID1]
, T.[multifamily]
, T.[ID]
, T.[multiline]
, T.[premiumCapture]
, T.[﻿reinsurer name]
, T.[FEIN]
, T.[LEI]
, T.[deal name]
, T.[deal limit]
, T.[aon deal?]
, T.[effective date]
, T.[reinsurer participation pct]
, T.[reinsurer participation]
, T.[collateral requirement pct]
, T.[collateral requirement]
, T.[i]
, T.[eDealLimit_current]
, T.[eGridSampleEffectiveDate]
, T.[eReinsurerParticipation_current]
, T.[multiline|multifamily]
, T.[multiline|multifamily|eGridSampleEffectiveDate]
, T.[eGridSampleIndex]
, T.[eSp_rating_gridlookup]
, T.[eAmbest_rating_gridlookup]
, T.[eCollateralFactor_current]
, T.[eGridSampleIndex|eSp_rating_gridlookup|eAmbest_rating_gridlookup]
, T.[eGridSampleMatch]
, T.[eReinsurerMatch]
, T.[eReinsurerAltName]
, T.[eReductionFactor]
, T.[eReinsurerAltName|deal name]
, T.[eReinsurerAndDealMatch]
, T.[eDealAge]
, T.[ePipeiineLoss]
, T.[eDealAge_SeasoningLookup]
, T.[eSeasoningFactor]
, T.[eNetCollateralFactor]
, T.[eCollateralRequirement] from reportValuationDate RVD, support_R03_participations T;
go

insert into history_support_R03_stepdown_A ([valuationDate], [Deal Cancellation Date]
, [Deal Name]
, [Activity Period]
, [Stepdown Occurred?]
, [Stepdown Test?]
, [Measure Names]
, [eCurrentRemainingLiabilityLimitFlag]
, [Measure Values]
, [eCurrentRemainingLiabilityLimitDeal]
, [ePipelineLossDeal]
, [ePipelineLossFlag]
, [dealName_last2monthsOnly]
, [eActivityPeriodExCurrent]
, [activityPeriod_exMostRecent]
, [activityPeriod_last2monthsOnly]
, [firstInstanceOfDeal]
, [momFlag]
, [tally]
, [ID]
, [tallyNoRepeats])
select RVD.[reportValuationDate], T.[Deal Cancellation Date]
, T.[Deal Name]
, T.[Activity Period]
, T.[Stepdown Occurred?]
, T.[Stepdown Test?]
, T.[Measure Names]
, T.[eCurrentRemainingLiabilityLimitFlag]
, T.[Measure Values]
, T.[eCurrentRemainingLiabilityLimitDeal]
, T.[ePipelineLossDeal]
, T.[ePipelineLossFlag]
, T.[dealName_last2monthsOnly]
, T.[eActivityPeriodExCurrent]
, T.[activityPeriod_exMostRecent]
, T.[activityPeriod_last2monthsOnly]
, T.[firstInstanceOfDeal]
, T.[momFlag]
, T.[tally]
, T.[ID]
, T.[tallyNoRepeats] from reportValuationDate RVD, support_R03_stepdown_A T;
go

insert into history_support_R10_MoM_AssetChangeDetail ([valuationDate], [Account]
, [Portfolio Type]
, [CUSIP_noSpaces]
, [Description]
, [reinsurerName]
, [marketValue_prior]
, [marketValue_current]
, [changeCohort]
, [marketValue_runoff]
, [marketValue_new]
, [marketValue_continuing_prior]
, [marketValue_continuing_current]
, [i])
select RVD.[reportValuationDate], T.[Account]
, T.[Portfolio Type]
, T.[CUSIP_noSpaces]
, T.[Description]
, T.[reinsurerName]
, T.[marketValue_prior]
, T.[marketValue_current]
, T.[changeCohort]
, T.[marketValue_runoff]
, T.[marketValue_new]
, T.[marketValue_continuing_prior]
, T.[marketValue_continuing_current]
, T.[i] from reportValuationDate RVD, support_R10_MoM_AssetChangeDetail T;
go

insert into history_support_R11_AMBest_Ratings ([valuationDate], [ID]
, [AMB#]
, [NAIC#]
, [Company Name]
, [Best's Financial Strength Rating - Current]
, [Best's Long-Term Issuer Credit Rating - Current]
, [Field6]
, [Field7]
, [Field10]
, [Field8]
, [Field9]
, [Field11]
, [Field12])
select RVD.[reportValuationDate], T.[ID]
, T.[AMB#]
, T.[NAIC#]
, T.[Company Name]
, T.[Best's Financial Strength Rating - Current]
, T.[Best's Long-Term Issuer Credit Rating - Current]
, T.[Field6]
, T.[Field7]
, T.[Field10]
, T.[Field8]
, T.[Field9]
, T.[Field11]
, T.[Field12] from reportValuationDate RVD, support_R11_AMBest_Ratings T;
go
