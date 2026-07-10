use Collateral_View_202604;
go

CREATE PROCEDURE dbo.FannieMaeCollateralCalc_B_DropTables
AS
BEGIN
    SET NOCOUNT ON

    drop table if exists support_R01_unsortedReportDa_B;
    drop table if exists stepdownReportActivityPeriods;
    drop table if exists reportValuationDate;
    drop table if exists bkp_priorMonth_support_R02_DL_A;
    drop table if exists priorMonth_support_R01_spGlobal;
    drop table if exists priorMonth_Support_R11_AMBest_R;
    drop table if exists support_R02_Dataload_A;
    drop table if exists priorMonth_support_R02_Dataload_A;
    drop table if exists support_R02_Dataload_History;
    drop table if exists support_R10_MoM_AssetChangeDetail;
    drop table if exists support_R11_spGlobalFSR_history;
    drop table if exists support_R11_amBestFSR_history;
    drop table if exists R01_reinsCollateralByAccount;
    drop table if exists corporateBondHaircutFactors;
    drop table if exists R02_Coll_Held_1_Reinsurer;
    drop table if exists R03_Re_Collateral_by_Reinsurer;
    drop table if exists R04_Coll_Req_by_Reins_All_Deals;
    drop table if exists R05_Coll_Required_1_Reinsurer;
    drop table if exists R06_Global_Credit_Check;
    drop table if exists R07_Rating_Exception;
    drop table if exists R08_Maturity_Exceptions;
    drop table if exists R09_Individual_Weight_Check;
    drop table if exists individualAssetsFailingTests;
    drop table if exists R10_MoM_Asset_Changes;
    drop table if exists R11_MoM_Fin_Strength_Rtg_Changes;
    drop table if exists R12_Limit_Stepdowns;
END
