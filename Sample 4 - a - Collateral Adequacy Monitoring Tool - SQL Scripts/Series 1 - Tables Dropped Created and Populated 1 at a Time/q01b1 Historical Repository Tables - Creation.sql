use Collateral_View_202603;
go

drop table historyTableBuilds_tableAndColumnNames;
go

create table historyTableBuilds_tableAndColumnNames (
  TABLE_NAME nvarchar(128)
, COLUMN_NAME nvarchar(128)
, ORDINAL_POSITION bigint
, DATA_TYPE nvarchar(128)
, CHARACTER_MAXIMUM_LENGTH bigint
, startingRow bigint
, finalRow bigint
, sqlCode_dropTable nvarchar(255)
, sqlCode_createTable nvarchar(255)
, sqlCode_insertInto nvarchar(255)
, sqlCode_select nvarchar(255)
, i bigint identity(1,1)
);
go

insert into historyTableBuilds_tableAndColumnNames (
  TABLE_NAME
, COLUMN_NAME
, ORDINAL_POSITION
, DATA_TYPE
, CHARACTER_MAXIMUM_LENGTH
)
select
  TABLE_NAME, COLUMN_NAME, ORDINAL_POSITION, DATA_TYPE
, isnull(CHARACTER_MAXIMUM_LENGTH, 0) CHARACTER_MAXIMUM_LENGTH
from INFORMATION_SCHEMA.COLUMNS
where '|bkp_priorMonth_support_R02_DL_A|bkp_support_R01_cvMasterEntityIDMap|bkp_support_R02_Dataload_A'
  + '|competingBrokerTrustAccounts|corporateBondFlags|corporateBondHaircutFactors|fitchBondRatingLookup'
  + '|individualAssetsFailingTests|industryOverridesByCUSIP|moodysBondRatingLookup|priorMonth_support_R01_spGlobal'
  + '|priorMonth_support_R02_Dataload_A|priorMonth_Support_R11_AMBest_R|R01_reinsCollateralByAccount'
  + '|R02_Coll_Held_1_Reinsurer|R03_Re_Collateral_by_Reinsurer|R04_Coll_Req_by_Reins_All_Deals'
  + '|R05_Coll_Required_1_Reinsurer|R06_Global_Credit_Check|R07_Rating_Exception|R08_Maturity_Exceptions'
  + '|R09_Individual_Weight_Check|R10_MoM_Asset_Changes|R11_MoM_Fin_Strength_Rtg_Changes|R12_Limit_Stepdowns'
  + '|reinsurerSelection|spBondRatingLookup|stepdownReportvaluationDates|support_R01_cvMasterEntityIDMap'
  + '|support_R01_spGlobalFSRs|support_R01_unsortedReportDa_B|support_R02_Dataload_A'
  + '|support_R02_fitchRatings|support_R03_participations|support_R03_stepdown_A|support_R10_MoM_AssetChangeDetail'
  + '|support_R10_MoM_AssetChangeDetail|support_R11_AMBest_Ratings'
  + '|historyTableBuilds_tableAndColumnNames|'
  like '%|' + TABLE_NAME + '|%'
order by TABLE_NAME, ORDINAL_POSITION;
go

update TCN
set TCN.finalRow=1
from historyTableBuilds_tableAndColumnNames TCN, (
  select TABLE_NAME, max(i) finalRow
  From historyTableBuilds_tableAndColumnNames
  group by TABLE_NAME
) F
where TCN.i=F.finalRow
go

update historyTableBuilds_tableAndColumnNames
set finalRow=0
where finalRow is null;
go

update TCN
set TCN.startingRow=1
from historyTableBuilds_tableAndColumnNames TCN, (
  select TABLE_NAME, min(i) startingRow
  From historyTableBuilds_tableAndColumnNames
  group by TABLE_NAME
) F
where TCN.i=F.startingRow
go

update historyTableBuilds_tableAndColumnNames
set startingRow=0
where startingRow is null;
go

update historyTableBuilds_tableAndColumnNames
set
  sqlCode_dropTable
  = case when startingRow=1 then 'drop table history_' + [TABLE_NAME] + ';' else '' end
, sqlCode_createTable
  = case when startingRow=1 then 'create table history_' + [TABLE_NAME] + ' ([valuationDate] datetime' else '' end
  + replace(replace(replace(replace(', [[CN]] [DT]([CML])'
    , '[CN]', [COLUMN_NAME])
    , '[DT]', [DATA_TYPE])
    , '[CML]', convert(nvarchar(32), [CHARACTER_MAXIMUM_LENGTH]))
    , '(0)', '')
  + case when finalRow=1 then ', j bigint identity(1,1));' else '' end
, sqlCode_insertInto
  = case when startingRow=1 then 'insert into history_' + [TABLE_NAME] + ' ([valuationDate], ' else ', ' end
  + replace('[[CN]]', '[CN]', [COLUMN_NAME])
  + case when finalRow=1 then ')' else '' end
, sqlCode_select
  = case when startingRow=1 then 'select RVD.[reportValuationDate], T.' else ', T.' end
  + replace('[[CN]]', '[CN]', [COLUMN_NAME])
  + case when finalRow=1 then replace(' from reportValuationDate RVD, [TN] T;', '[TN]', TABLE_NAME) else '' end
;
go

/*
select *
From historyTableBuilds_tableAndColumnNames;
go
*/

drop table historyTableBuilds_allSqlCode;
go

create table historyTableBuilds_allSqlCode (
  TABLE_NAME nvarchar(128)
, n bigint
, i bigint
, sqlCode nvarchar(255)
, k bigint identity(1,1)
);
go

insert into historyTableBuilds_allSqlCode (TABLE_NAME, n, i, sqlCode)
select *
from (
    select TABLE_NAME, 1 n, i, sqlCode_dropTable
	from historyTableBuilds_tableAndColumnNames
	where sqlCode_dropTable<>''
  union
    select TABLE_NAME, 2 n, i, 'go' sqlCode_dropTable
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
  union
    select TABLE_NAME, 3 n, i, '' sqlCode_dropTable
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
) U
order by TABLE_NAME, n, i;
go

insert into historyTableBuilds_allSqlCode (TABLE_NAME, n, i, sqlCode)
select *
from (
    select TABLE_NAME, 1 n, i, sqlCode_createTable sqlCode
	from historyTableBuilds_tableAndColumnNames
  union
    select TABLE_NAME, 2 n, i, 'go' sqlCode
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
  union
    select TABLE_NAME, 3 n, i, '' sqlCode
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
) U
order by TABLE_NAME, n, i;
go

insert into historyTableBuilds_allSqlCode (TABLE_NAME, n, i, sqlCode)
select *
from (
    select TABLE_NAME, 1 n, i, sqlCode_insertInto sqlCode
	from historyTableBuilds_tableAndColumnNames
  union
    select TABLE_NAME, 2 n, i, sqlCode_select sqlCode
	from historyTableBuilds_tableAndColumnNames
  union
    select TABLE_NAME, 3 n, i, 'go' sqlCode
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
  union
    select TABLE_NAME, 4 n, i, '' sqlCode
	from historyTableBuilds_tableAndColumnNames
	where startingRow=1
) U
order by TABLE_NAME, n, i;
go


select * from historyTableBuilds_allSqlCode
go
