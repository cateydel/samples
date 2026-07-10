use Collateral_View_202605
go

/*
exec dbo.FannieMaeCollateralCalc_A_SetUpHistoryTables
go
*/

exec dbo.FannieMaeCollateralCalc_B_DropTables
go

exec dbo.FannieMaeCollateralCalc_C_CreateTables
go

exec dbo.FannieMaeCollateralCalc_D_PopulateTables
go

/*
exec dbo.FannieMaeCollateralCalc_E_AppendToHistoryTables
go
*/
