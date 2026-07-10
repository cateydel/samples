use Collateral_View_202604;
go

/*
Re-create support_R01_unsortedReportDa_B
*/

drop table if exists support_R01_unsortedReportDa_B;
go

/*
Query the activity periods (APs) (i.e., valuation dates) from the Fannie Mae Data Dynamics Stepdown Report.
Index the APs so that index 1 denotes the most recent AP and index 2 denotes the second most recent AP.3
*/

drop table if exists stepdownReportActivityPeriods;
go

/*
Create a table that sets the Protecdiv collateral calculation's valuation date
one month after the most recent activity period in the Fannie Mae Data Dynamics Stepdown Report.
*/

drop table if exists reportValuationDate;
go

/*
Create the support_R02_Dataload_A table
*/

drop table if exists bkp_priorMonth_support_R02_DL_A;
go

drop table if exists priorMonth_support_R01_spGlobal;
go

drop table if exists priorMonth_Support_R11_AMBest_R;
go



drop table if exists support_R02_Dataload_A;
go

/*
drop table if exists support_R03_stepdown_A;
go
*/

/*
Create the priorMonth_support_R02_Dataload_A table
*/

drop table if exists priorMonth_support_R02_Dataload_A;
go

drop table if exists support_R02_Dataload_History;
go

drop table support_R10_MoM_AssetChangeDetail;
go

drop table if exists support_R11_spGlobalFSR_history;
go

drop table if exists support_R11_amBestFSR_history;
go

/*
Create the R01_reinsCollateralByAccount
*/

drop table if exists R01_reinsCollateralByAccount;
go

drop table if exists corporateBondHaircutFactors;
go



/*
Create single-reinsurer collateral-held table
*/

drop table if exists R02_Coll_Held_1_Reinsurer;
go

/*
Create R03_Re_Collateral_by_Reinsurer
*/

drop table if exists R03_Re_Collateral_by_Reinsurer;
go

drop table if exists R04_Coll_Req_by_Reins_All_Deals;
go

drop table if exists R05_Coll_Required_1_Reinsurer;
go

drop table if exists R06_Global_Credit_Check;
go

drop table if exists R07_Rating_Exception;
go

drop table if exists R08_Maturity_Exceptions;
go

drop table if exists R09_Individual_Weight_Check;
go

drop table if exists individualAssetsFailingTests;
go

drop table if exists R10_MoM_Asset_Changes;
go

drop table if exists R11_MoM_Fin_Strength_Rtg_Changes;
go

drop table if exists R12_Limit_Stepdowns;
go