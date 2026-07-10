use Collateral_View_202604;
go

CREATE PROCEDURE dbo.FannieMaeCollateralCalc_D_PopulateTables
AS
BEGIN
    SET NOCOUNT ON
  
    insert into stepdownReportActivityPeriods ([Activity Period])
    select [Activity Period]
    from support_R03_stepdown_A
    group by [Activity Period]
    order by [Activity Period] desc;


    select
      datefromparts(y+floor(1.0*m/12), (m % 12)+1, d) reportValuationDate
    , priorReportValuationDate
    into reportValuationDate
    from (
      select 
        year(max([Activity Period])) y
      , month(max([Activity Period])) m
      , day(max([Activity Period])) d
      , max([Activity Period]) priorReportValuationDate
      from stepdownReportActivityPeriods
      where i=1
    ) U;


    select T.*
    into bkp_priorMonth_support_R02_DL_A
    from history_bkp_support_R02_Dataload_A T, (
      select min(reportValuationDate) reportValuationDate, min(priorReportValuationDate) priorReportValuationDate
      from (  select reportValuationDate, priorReportValuationDate from reportValuationDate 
        union select datefromparts(9999, 12, 31) reportValuationDate, max(valuationDate) priorReportValuationDate from history_bkp_support_R02_Dataload_A
      ) U
    ) RVD
    where T.valuationDate=RVD.priorReportValuationDate;
    


    select T.*
    into priorMonth_support_R01_spGlobal
    from history_support_R01_spGlobalFSRs T, (
      select min(reportValuationDate) reportValuationDate, min(priorReportValuationDate) priorReportValuationDate
      from (  select reportValuationDate, priorReportValuationDate from reportValuationDate 
        union select datefromparts(9999, 12, 31) reportValuationDate, max(valuationDate) priorReportValuationDate from history_bkp_support_R02_Dataload_A
      ) U
    ) RVD
    where T.valuationDate=RVD.priorReportValuationDate;



    select T.*
    into priorMonth_Support_R11_AMBest_R
    from history_support_R11_AMBest_Ratings T, (
      select min(reportValuationDate) reportValuationDate, min(priorReportValuationDate) priorReportValuationDate
      from (  select reportValuationDate, priorReportValuationDate from reportValuationDate 
        union select datefromparts(9999, 12, 31) reportValuationDate, max(valuationDate) priorReportValuationDate from history_bkp_support_R02_Dataload_A
      ) U
    ) RVD
    where T.valuationDate=RVD.priorReportValuationDate;



    insert into support_R02_Dataload_A (
      [Account Title]
    , [Account]
    , [Portfolio Type]
    , [Security Type]
    , [Description]
    , [Industry (Original)]
    , [S&P Rating]
    , [Market Value (Pre-Test)]
    , [Maturity Date]
    , [Years to Maturity]
    , [Moody's Rating]
    , [MV % of Total]
    , [As of Date]
    , [CUSIP]
    , [CUSIP_noSpaces]
    , [Industry]
    , [Corporate Bond Flag (CB)]
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
    , [Flag for Fitch Bond Rating A or Higher (FBRA)]
    , [Impermissible Corporate Bond due to Ratings (ICBR)]
    , [CB*M3]
    , [CB*MV10]
    , [At Least 1 Exception pre-Fitch Check]
    , [At Least 1 Exception post-Fitch Check]
    , [Market Value (Corporates)]
    , [Market Value (Corporates >= 3yrs)]
    , [accountChangeFlag]
    , [Market Value (Post-Individual-Test)]
    , [Market Value (Post-CBMV-Haircut)]
    )
    select Y.*
    , sign(
        [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)] + [CB*M3] + [CB*MV10]
      ) [At Least 1 Exception pre-Fitch Check]
    , sign(
        [Impermissible Corporate Bond due to Ratings (ICBR)] + [CB*M3] + [CB*MV10]
      ) [At Least 1 Exception post-Fitch Check]
    , [Market Value (Pre-Test)]*[Corporate Bond Flag (CB)] [Market Value (Corporates)]
    , [Market Value (Pre-Test)]*[Corporate Bond Flag (CB)]*[3yr Maturity Flag (M3)] [Market Value (Corporates >= 3yrs)]
    , convert(bigint, 0) [accountChangeFlag]
    , [Market Value (Pre-Test)] * case when IAFT.CUSIP is null then 1 else 0 end [Market Value (Post-Individual-Test)]
    ,   [Market Value (Pre-Test)]
      * case when IAFT.CUSIP is null then 1 else 0 end
      * case when isnull(CBHF.[Total Corporates], 0.3)>=0.3 then convert(float, 1) else (power([Total Corporates], -1)-1)*3/7 end 
        [Market Value (Post-CBMV-Haircut)]
    from (
      select X.*
      , case when
          floor(1.0*[Flag for S&P Bond Rating A or Higher (SPBRA)]/10)
        + floor(1.0*[Flag for Moody's Bond Rating A or Higher (MBRA)]/10)
        + floor(1.0*[Flag for Fitch Bond Rating A or Higher (FBRA)]/10) < 1 or
          (convert(bigint, [Flag for S&P Bond Rating A or Higher (SPBRA)]) % 10)
        + (convert(bigint, [Flag for Moody's Bond Rating A or Higher (MBRA)]) % 10)
        + (convert(bigint, [Flag for Fitch Bond Rating A or Higher (FBRA)]) % 10) >= 1
        then [Corporate Bond Flag (CB)] else 0 end
        [Impermissible Corporate Bond due to Ratings (ICBR)]
      , [Corporate Bond Flag (CB)]*[3yr Maturity Flag (M3)] [CB*M3]
      , [Corporate Bond Flag (CB)]*[Flag for 10%+ MV of Total (MV10)] [CB*MV10]
      from (
        select W.*
        , 10*isnull(FBRL.[A or Higher], 0)+isnull(FBRL.[Lower than A-], 0) [Flag for Fitch Bond Rating A or Higher (FBRA)]
        from (
          select V.*
          , '.'
            [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
          , [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
            * case when ([Flag for S&P Bond Rating A or Higher (SPBRA)] % 10) + ([Flag for Moody's Bond Rating A or Higher (MBRA)] % 10) = 0 then 1 else 0 end
            [Fitch Check Flag (FC)]
          , isnull(FR.[Fitch Rating], '') [Fitch Rating]
          from (
            select U.*
            , [Corporate Bond Flag (CB)]
              * (1-floor([Flag for S&P Bond Rating A or Higher (SPBRA)]/10)*floor([Flag for Moody's Bond Rating A or Higher (MBRA)]/10))
              [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
            from (
              select
                DLB.[Account Title]
              , DLB.[Account]
              , DLB.[Portfolio Type]
              , DLB.[Security Type]
              , DLB.[Description]
              , DLB.[Industry (Original)]
              , DLB.[S&P Rating]
              , DLB.[Market Value (Pre-Test)]
              , DLB.[Maturity Date]
              , DLB.[Years to Maturity]
              , DLB.[Moody's Rating]
              , DLB.[MV % of Total]
              , DLB.[As of Date]
              , DLB.[CUSIP]
              , DLB.[CUSIP_noSpaces]
              , DLB.[Industry]
              , case when CBF.Industry is null then 0 else 1 end [Corporate Bond Flag (CB)]

              , case when DLB.[Years to Maturity]>=3 then 1 else 0 end [3yr Maturity Flag (M3)]

              , case when DLB.[MV % of Total]>=10 then 1 else 0 end [Flag for 10%+ MV of Total (MV10)]

              , case when SPBRL.Rating is null then 0 else 1 end [Valid S&P Bond Rating Flag (SPBR)]
              , case when MBRL.Rating is null then 0 else 1 end [Valid Moody's Bond Rating Flag (MBR)]
              , convert(bigint, 10*isnull(SPBRL.[A or Higher], 0)+isnull(SPBRL.[Lower than A-], 0)) [Flag for S&P Bond Rating A or Higher (SPBRA)]
              , convert(bigint, 10*isnull(MBRL.[A or Higher], 0)+isnull(MBRL.[Lower than A3], 0)) [Flag for Moody's Bond Rating A or Higher (MBRA)]
              from (
                select DL.*
                , case when IOC.[Industry Override] is null then DL.[Industry (Original)] else IOC.[Industry Override] end [Industry]
                from (
                  select
                    [Account Title], [Account], [Portfolio Type], [Security Type], [Description], Industry [Industry (Original)]
                  , [S&P Rating], [Market Value] [Market Value (Pre-Test)], [Maturity Date], [Years to Maturity], [Moody's Rating]
                  , [MV % of Total], [As of Date], [CUSIP]
                  , replace([CUSIP], ' ', '') [CUSIP_noSpaces], convert(nvarchar(255), '') [Fitch Rating]
                  from (
                          select
                            convert(nvarchar(255), [Account Title]) [Account Title]
                          , convert(nvarchar(255), [Account]) [Account]
                          , convert(nvarchar(255), [Portfolio Type]) [Portfolio Type]
                          , convert(nvarchar(255), [Security Type]) [Security Type]
                          , convert(nvarchar(255), [Description]) [Description]
                          , convert(nvarchar(255), [Industry]) [Industry]
                          , convert(nvarchar(255), [S&P Rating]) [S&P Rating]
                          , convert(float, [Market Value]) [Market Value]
                          , convert(nvarchar(255), [Maturity Date]) [Maturity Date]
                          , convert(float, [Years to Maturity]) [Years to Maturity]
                          , convert(nvarchar(255), [Moody's Rating]) [Moody's Rating]
                          , convert(float, [MV % of Total]) [MV % of Total]
                          , convert(datetime, [As of Date]) [As of Date]
                          , convert(nvarchar(255), [CUSIP]) [CUSIP]
                          from bkp_support_R02_Dataload_A
                    union select * from support_R02_Dataload_A_Addendum
                  ) DLC
                ) DL
                left outer join industryOverridesByCUSIP IOC on DL.CUSIP_noSpaces=IOC.CUSIP
              ) DLB
                left outer join corporateBondFlags CBF on DLB.Industry=CBF.Industry
                left outer join spBondRatingLookup SPBRL on DLB.[S&P Rating]=SPBRL.Rating
                left outer join moodysBondRatingLookup MBRL on DLB.[Moody's Rating]=MBRL.Rating
                left outer join fitchBondRatingLookup FBRL on DLB.[Fitch Rating]=FBRL.Rating
            ) U
          ) V
            left outer join support_R02_fitchRatings FR on V.CUSIP_noSpaces=FR.CUSIP
        ) W 
          left outer join fitchBondRatingLookup FBRL on W.[Fitch Rating]=FBRL.Rating
      ) X
    ) Y
      left outer join individualAssetsFailingTests IAFT on Y.CUSIP_noSpaces=IAFT.CUSIP
      left outer join corporateBondHaircutFactors CBHF
        on Y.[Description] + '|' + Y.[Industry (Original)]=CBHF.[Account Title|Industry]
    order by Account, CUSIP_noSpaces



    insert into support_R02_fitchRatings (CUSIP, [Fitch Rating Lookup URL])
    select S.CUSIP_noSpaces, replace(U.[Fitch Rating Lookup URL], U.CUSIP, S.CUSIP_noSpaces)
    from support_R02_fitchRatings U, (
      select * from support_R02_Dataload_A where [Fitch Check Flag (FC)]=1 and [Fitch Rating]=''
    ) S
    where U.ID=1;

    update support_R02_fitchRatings set ID=i where ID is null;

    select
      CUSIP
    , [Fitch Rating Lookup URL]
    , replace('update support_R02_fitchRatings set [Fitch Rating]='''' where CUSIP=''[C]''', '[C]', CUSIP) [Fitch Rating Update Query]
    from support_R02_fitchRatings where [Fitch Rating] is null;



    insert into priorMonth_support_R02_Dataload_A (
      [Account Title]
    , [Account]
    , [Portfolio Type]
    , [Security Type]
    , [Description]
    , [Industry (Original)]
    , [S&P Rating]
    , [Market Value (Pre-Test)]
    , [Maturity Date]
    , [Years to Maturity]
    , [Moody's Rating]
    , [MV % of Total]
    , [As of Date]
    , [CUSIP]
    , [CUSIP_noSpaces]
    , [Industry]
    , [Corporate Bond Flag (CB)]
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
    , [Flag for Fitch Bond Rating A or Higher (FBRA)]
    , [Impermissible Corporate Bond due to Ratings (ICBR)]
    , [CB*M3]
    , [CB*MV10]
    , [At Least 1 Exception pre-Fitch Check]
    , [At Least 1 Exception post-Fitch Check]
    , [Market Value (Corporates)]
    , [Market Value (Corporates >= 3yrs)]
    , [accountChangeFlag]
    , [Market Value (Post-Individual-Test)]
    , [Market Value (Post-CBMV-Haircut)]
    )
    select Y.*
    , sign(
        [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)] + [CB*M3] + [CB*MV10]
      ) [At Least 1 Exception pre-Fitch Check]
    , sign(
        [Impermissible Corporate Bond due to Ratings (ICBR)] + [CB*M3] + [CB*MV10]
      ) [At Least 1 Exception post-Fitch Check]
    , [Market Value (Pre-Test)]*[Corporate Bond Flag (CB)] [Market Value (Corporates)]
    , [Market Value (Pre-Test)]*[Corporate Bond Flag (CB)]*[3yr Maturity Flag (M3)] [Market Value (Corporates >= 3yrs)]
    , convert(bigint, 0) [accountChangeFlag]
    , [Market Value (Pre-Test)] * case when IAFT.CUSIP is null then 1 else 0 end [Market Value (Post-Individual-Test)]
    ,   [Market Value (Pre-Test)]
      * case when IAFT.CUSIP is null then 1 else 0 end
      * case when isnull(CBHF.[Total Corporates], 0.3)>=0.3 then convert(float, 1) else (power([Total Corporates], -1)-1)*3/7 end 
        [Market Value (Post-CBMV-Haircut)]
    from (
      select X.*
      , case when
          floor(1.0*[Flag for S&P Bond Rating A or Higher (SPBRA)]/10)
        + floor(1.0*[Flag for Moody's Bond Rating A or Higher (MBRA)]/10)
        + floor(1.0*[Flag for Fitch Bond Rating A or Higher (FBRA)]/10) < 1 or
          (convert(bigint, [Flag for S&P Bond Rating A or Higher (SPBRA)]) % 10)
        + (convert(bigint, [Flag for Moody's Bond Rating A or Higher (MBRA)]) % 10)
        + (convert(bigint, [Flag for Fitch Bond Rating A or Higher (FBRA)]) % 10) >= 1
        then [Corporate Bond Flag (CB)] else 0 end
        [Impermissible Corporate Bond due to Ratings (ICBR)]
      , [Corporate Bond Flag (CB)]*[3yr Maturity Flag (M3)] [CB*M3]
      , [Corporate Bond Flag (CB)]*[Flag for 10%+ MV of Total (MV10)] [CB*MV10]
      from (
        select W.*
        , 10*isnull(FBRL.[A or Higher], 0)+isnull(FBRL.[Lower than A-], 0) [Flag for Fitch Bond Rating A or Higher (FBRA)]
        from (
          select V.*
          , '.'
            [Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
          , [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
            * case when ([Flag for S&P Bond Rating A or Higher (SPBRA)] % 10) + ([Flag for Moody's Bond Rating A or Higher (MBRA)] % 10) = 0 then 1 else 0 end
            [Fitch Check Flag (FC)]
          , isnull(FR.[Fitch Rating], '') [Fitch Rating]
          from (
            select U.*
            , [Corporate Bond Flag (CB)]
              * (1-floor([Flag for S&P Bond Rating A or Higher (SPBRA)]/10)*(1-floor([Flag for Moody's Bond Rating A or Higher (MBRA)]/10)))
              [Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
            from (
              select
                DLB.[Account Title]
              , DLB.[Account]
              , DLB.[Portfolio Type]
              , DLB.[Security Type]
              , DLB.[Description]
              , DLB.[Industry (Original)]
              , DLB.[S&P Rating]
              , DLB.[Market Value (Pre-Test)]
              , DLB.[Maturity Date]
              , DLB.[Years to Maturity]
              , DLB.[Moody's Rating]
              , DLB.[MV % of Total]
              , DLB.[As of Date]
              , DLB.[CUSIP]
              , DLB.[CUSIP_noSpaces]
              , DLB.[Industry]
              , case when CBF.Industry is null then 0 else 1 end [Corporate Bond Flag (CB)]

              , case when DLB.[Years to Maturity]>=3 then 1 else 0 end [3yr Maturity Flag (M3)]

              , case when DLB.[MV % of Total]>=10 then 1 else 0 end [Flag for 10%+ MV of Total (MV10)]

              , case when SPBRL.Rating is null then 0 else 1 end [Valid S&P Bond Rating Flag (SPBR)]
              , case when MBRL.Rating is null then 0 else 1 end [Valid Moody's Bond Rating Flag (MBR)]
              , convert(bigint, 10*isnull(SPBRL.[A or Higher], 0)+isnull(SPBRL.[Lower than A-], 0)) [Flag for S&P Bond Rating A or Higher (SPBRA)]
              , convert(bigint, 10*isnull(MBRL.[A or Higher], 0)+isnull(MBRL.[Lower than A3], 0)) [Flag for Moody's Bond Rating A or Higher (MBRA)]
              from (
                select DL.*
                , case when IOC.[Industry Override] is null then DL.[Industry (Original)] else IOC.[Industry Override] end [Industry]
                from (
                  select
                    [Account Title], [Account], [Portfolio Type], [Security Type], [Description], [Industry (Original)]
                  , [S&P Rating], [Market Value (Pre-Test)], [Maturity Date], [Years to Maturity], [Moody's Rating]
                  , [MV % of Total], [As of Date], [CUSIP]
                  , replace([CUSIP], ' ', '') [CUSIP_noSpaces], [Fitch Rating]
                  from bkp_priorMonth_support_R02_DL_A
                ) DL
                left outer join industryOverridesByCUSIP IOC on DL.CUSIP_noSpaces=IOC.CUSIP
              ) DLB
                left outer join corporateBondFlags CBF on DLB.Industry=CBF.Industry
                left outer join spBondRatingLookup SPBRL on DLB.[S&P Rating]=SPBRL.Rating
                left outer join moodysBondRatingLookup MBRL on DLB.[Moody's Rating]=MBRL.Rating
                left outer join fitchBondRatingLookup FBRL on DLB.[Fitch Rating]=FBRL.Rating
            ) U
          ) V
            left outer join support_R02_fitchRatings FR on V.CUSIP_noSpaces=FR.CUSIP
        ) W 
          left outer join fitchBondRatingLookup FBRL on W.[Fitch Rating]=FBRL.Rating
      ) X
    ) Y
      left outer join individualAssetsFailingTests IAFT on Y.CUSIP_noSpaces=IAFT.CUSIP
      left outer join corporateBondHaircutFactors CBHF
        on Y.[Description] + '|' + Y.[Industry (Original)]=CBHF.[Account Title|Industry]
    order by Account, CUSIP_noSpaces



    insert into support_R02_Dataload_History (
      [Activity Period]
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
    , [Market Value (Post-CBMV-Haircut)]
    )
    select
      SRAP.[Activity Period]
    , DL.[Account Title]
    , DL.[Account]
    , DL.[Description]
    , DL.[Portfolio Type]
    , DL.[Security Type]
    , DL.[Industry (Original)]
    , DL.[S&P Rating]
    , DL.[Market Value (Pre-Test)]
    , DL.[Maturity Date]
    , DL.[Years to Maturity]
    , DL.[Moody's Rating]
    , DL.[MV % of Total]
    , DL.[As of Date]
    , DL.[CUSIP]
    , DL.[Corporate Bond Flag (CB)]
    , DL.[CUSIP_noSpaces]
    , DL.[Industry]
    , DL.[3yr Maturity Flag (M3)]
    , DL.[Flag for 10%+ MV of Total (MV10)]
    , DL.[Valid S&P Bond Rating Flag (SPBR)]
    , DL.[Valid Moody's Bond Rating Flag (MBR)]
    , DL.[Flag for S&P Bond Rating A or Higher (SPBRA)]
    , DL.[Flag for Moody's Bond Rating A or Higher (MBRA)]
    , DL.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
    , DL.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
    , DL.[Fitch Check Flag (FC)]
    , DL.[Fitch Rating]
    , DL.[CB*M3]
    , DL.[Flag for Fitch Bond Rating A or Higher (FBRA)]
    , DL.[Impermissible Corporate Bond due to Ratings (ICBR)]
    , DL.[CB*MV10]
    , DL.[At Least 1 Exception pre-Fitch Check]
    , DL.[At Least 1 Exception post-Fitch Check]
    , DL.[Market Value (Corporates)]
    , DL.[Market Value (Corporates >= 3yrs)]
    , DL.[accountChangeFlag]
    , DL.[Market Value (Post-Individual-Test)]
    , DL.[Market Value (Post-CBMV-Haircut)]
    from support_R02_Dataload_A DL, stepdownReportActivityPeriods SRAP
    where SRAP.i=1
    order by [Account Title], CUSIP_noSpaces;



    insert into support_R02_Dataload_History (
      [Activity Period]
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
    , [Market Value (Post-CBMV-Haircut)]
    )
    select
      SRAP.[Activity Period]
    , DL.[Account Title]
    , DL.[Account]
    , DL.[Description]
    , DL.[Portfolio Type]
    , DL.[Security Type]
    , DL.[Industry (Original)]
    , DL.[S&P Rating]
    , DL.[Market Value (Pre-Test)]
    , DL.[Maturity Date]
    , DL.[Years to Maturity]
    , DL.[Moody's Rating]
    , DL.[MV % of Total]
    , DL.[As of Date]
    , DL.[CUSIP]
    , DL.[Corporate Bond Flag (CB)]
    , DL.[CUSIP_noSpaces]
    , DL.[Industry]
    , DL.[3yr Maturity Flag (M3)]
    , DL.[Flag for 10%+ MV of Total (MV10)]
    , DL.[Valid S&P Bond Rating Flag (SPBR)]
    , DL.[Valid Moody's Bond Rating Flag (MBR)]
    , DL.[Flag for S&P Bond Rating A or Higher (SPBRA)]
    , DL.[Flag for Moody's Bond Rating A or Higher (MBRA)]
    , DL.[Corporate Bond with Low or Missing S&P or Moody's Rating (CBLMR)]
    , DL.[Comments for Low-Rated/Unrated Corporate Bonds, pre-Fitch Check]
    , DL.[Fitch Check Flag (FC)]
    , DL.[Fitch Rating]
    , DL.[CB*M3]
    , DL.[Flag for Fitch Bond Rating A or Higher (FBRA)]
    , DL.[Impermissible Corporate Bond due to Ratings (ICBR)]
    , DL.[CB*MV10]
    , DL.[At Least 1 Exception pre-Fitch Check]
    , DL.[At Least 1 Exception post-Fitch Check]
    , DL.[Market Value (Corporates)]
    , DL.[Market Value (Corporates >= 3yrs)]
    , DL.[accountChangeFlag]
    , DL.[Market Value (Post-Individual-Test)]
    , DL.[Market Value (Post-CBMV-Haircut)]
    from priorMonth_support_R02_Dataload_A DL, stepdownReportActivityPeriods SRAP
    where SRAP.i=2
    order by [Account Title], CUSIP_noSpaces;



    insert into support_R10_MoM_AssetChangeDetail (
      [Account]
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
    )
    SELECT
      DLH.Account, DLH.[Portfolio Type], DLH.CUSIP_noSpaces
    , max(DLH.[Description]) [Description]
    , max(RN.Reinsurer_Name) reinsurerName
    , sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end) marketValue_prior
    , sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end) marketValue_current
    ,    sign(abs(sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)))
      +2*sign(abs(sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end))) changeCohort
    , case when
         sign(abs(sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)))
      +2*sign(abs(sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)))=1 then
      sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)
      else convert(float, 0) end marketValue_runoff
    , case when
         sign(abs(sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)))
      +2*sign(abs(sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)))=2 then
      sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)
      else convert(float, 0) end marketValue_new
    , case when
         sign(abs(sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)))
      +2*sign(abs(sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)))=3 then
      sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)
      else convert(float, 0) end marketValue_continuing_prior
    , case when
         sign(abs(sum(case when SRAP.i=2 then DLH.[Market Value (Pre-Test)] else 0 end)))
      +2*sign(abs(sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)))=3then
      sum(case when SRAP.i=1 then DLH.[Market Value (Pre-Test)] else 0 end)
      else convert(float, 0) end marketValue_continuing_current
    FROM
      support_R02_Dataload_History DLH
    , stepdownReportActivityPeriods SRAP
    , (
            select trustAccount1 Account, Reinsurer_Name from support_R01_cvMasterEntityIDMap where trustAccount1<>''
      union select trustAccount2 Account, Reinsurer_Name from support_R01_cvMasterEntityIDMap where trustAccount2<>''
      union select trustAccount3 Account, Reinsurer_Name from support_R01_cvMasterEntityIDMap where trustAccount3<>''
    ) RN
    where SRAP.i<=2 and SRAP.[Activity Period]=DLH.[Activity Period] and DLH.Account=RN.Account
    group by DLH.Account, DLH.[Portfolio Type], DLH.CUSIP_noSpaces
    order by DLH.Account, DLH.[Portfolio Type], DLH.CUSIP_noSpaces



    insert into support_R11_spGlobalFSR_history (
      stepdownReportActivityPeriod
    , SP_ENTITY_NAME
    , SP_CIQ_ID
    , RD_CREDIT_RATING_GLOBAL
    , SP_FITCH_INSURER_FSR
    )
    select
      SRAP.[Activity Period]
    , SPFSR.SP_ENTITY_NAME
    , SPFSR.SP_CIQ_ID
    , SPFSR.RD_CREDIT_RATING_GLOBAL
    , SPFSR.SP_FITCH_INSURER_FSR
    from support_R01_spGlobalFSRs SPFSR, stepdownReportActivityPeriods SRAP
    where SRAP.i=1
    order by SPFSR.SP_ENTITY_NAME;



    insert into support_R11_spGlobalFSR_history (
      stepdownReportActivityPeriod
    , SP_ENTITY_NAME
    , SP_CIQ_ID
    , RD_CREDIT_RATING_GLOBAL
    , SP_FITCH_INSURER_FSR
    )
    select
      SRAP.[Activity Period]
    , SPFSR.SP_ENTITY_NAME
    , SPFSR.SP_CIQ_ID
    , SPFSR.RD_CREDIT_RATING_GLOBAL
    , SPFSR.SP_FITCH_INSURER_FSR
    from priorMonth_support_R01_spGlobal SPFSR, stepdownReportActivityPeriods SRAP
    where SRAP.i=2
    order by SPFSR.SP_ENTITY_NAME;



    insert into support_R11_amBestFSR_history (
      [Activity Period]
    , [reinsurerNameWOComments]
    , [amBestFSR]
    , [ID]
    , [AMB#]
    , [NAIC#]
    , [Company Name]
    , [Best's Financial Strength Rating - Current]
    , [Best's Long-Term Issuer Credit Rating - Current]
    )
    select *
    from (
        SELECT
          SRAP.[Activity Period]
        , left([Company Name], charindex('(', [Company Name] + '(')-1) reinsurerNameWOComments
        , case
            when lower(left([Best's Financial Strength Rating - Current], 1)) not between 'a' and 'z'
              then upper(replace([Best's Long-Term Issuer Credit Rating - Current], ' u', ''))
            else replace([Best's Financial Strength Rating - Current], ' u', '') end amBestFSR
        , [ID], [AMB#], [NAIC#]
        , [Company Name], [Best's Financial Strength Rating - Current]
        , [Best's Long-Term Issuer Credit Rating - Current]
        FROM [support_R11_AMBest_Ratings] AMBR, stepdownReportActivityPeriods SRAP
        where SRAP.i=1
      union
        SELECT
          SRAP.[Activity Period]
        , left([Company Name], charindex('(', [Company Name] + '(')-1) reinsurerNameWOComments
        , case
            when lower(left([Best's Financial Strength Rating - Current], 1)) not between 'a' and 'z'
              then upper(replace([Best's Long-Term Issuer Credit Rating - Current], ' u', ''))
            else replace([Best's Financial Strength Rating - Current], ' u', '') end amBestFSR
        , [ID], [AMB#], [NAIC#]
        , [Company Name], [Best's Financial Strength Rating - Current]
        , [Best's Long-Term Issuer Credit Rating - Current]
        FROM [priorMonth_Support_R11_AMBest_R] AMBR, stepdownReportActivityPeriods SRAP
        where SRAP.i=2
    ) U
    order by [Activity Period], reinsurerNameWOComments, [AMB#];



    insert into R01_reinsCollateralByAccount (
      [reinsurerName]
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
    )
    select
      RN.[reinsurerName]
    , max(RN.[FEIN])
    , max(RN.[LEI])
    , 'Wilmington Trust'
    , max(DL.[Description])
    , DL.Account
    , sum(DL.[Market Value (Pre-Test)])
    , sum(DL.[Market Value (Post-Individual-Test)])
    , sum(DL.[Market Value (Post-CBMV-Haircut)])
    , sum(DL.[Market Value (Corporates)])
    , case
        when sum(DL.[Market Value (Pre-Test)])=0 then convert(float, 0)
        else sum(DL.[Market Value (Corporates)])/sum(DL.[Market Value (Pre-Test)]) end
    , sum(DL.[Market Value (Corporates >= 3yrs)])
    , case
        when sum(DL.[Market Value (Pre-Test)])=0 then convert(float, 0)
        else sum(DL.[Market Value (Corporates >= 3yrs)])/sum(DL.[Market Value (Pre-Test)]) end
    from support_R02_Dataload_A DL, (
      select R.*
      from (
              select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount1
        union select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount2
        union select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount3
      ) R
        left outer join competingBrokerTrustAccounts CBTA on R.[Description]=CBTA.[Description]
        where CBTA.[Description] is null
    ) RN
    where DL.Account=RN.Account
    group by RN.[reinsurerName], DL.Account
    order by RN.[reinsurerName], DL.Account;



    insert into corporateBondHaircutFactors (
      [ID]
    , [Account Title]
    , [Account Title|Industry]
    , [Total Corporates]
    , [Total Credit Check]
    , [Haircut Factor]
    )
    select
      i
    , trustAccountName
    , trustAccountName + '|CORPORATE OBLIGATIONS'
    , mv_collHeld_corpBonds_all_pctOfCombined
    , case when mv_collHeld_corpBonds_all_pctOfCombined>0.3 then 'Fail' else 'Pass' end
    , case
        when mv_collHeld_corpBonds_all_pctOfCombined>0.3
          then (convert(float, 3)/7) * (convert(float, 1)/mv_collHeld_corpBonds_all_pctOfCombined-1)
        else convert(float, 1)
      end
    from R01_reinsCollateralByAccount
    where mv_collHeld_corpBonds_all_pctOfCombined>0



    insert into R03_Re_Collateral_by_Reinsurer (
      [Reinsurer Name]
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
    )
    select
      RCA.reinsurerName
    , RCA.FEIN
    , RCA.LEI
    , MEIM.trustAccount1
    , MEIM.trustAccount2
    , MEIM.trustAccount3
    , RCA.mv_collHeld_cashAndSec_passingIndivTests
    , CR.collateralRequirement
    , CR.collateralRequirement*1.02
    , case
        when RCA.mv_collHeld_cashAndSec_passingIndivTests=0 then convert(float,0)
        else RCA.mv_collHeld_cashAndSec_passingIndivTests/CR.collateralRequirement end
    , case
        when CR.collateralRequirement>RCA.mv_collHeld_cashAndSec_passingIndivTests
          then CR.collateralRequirement-RCA.mv_collHeld_cashAndSec_passingIndivTests
        else convert(float, 0) end
    , case
        when RCA.mv_collHeld_cashAndSec_passingIndivTests>CR.collateralRequirement*1.02
          then RCA.mv_collHeld_cashAndSec_passingIndivTests-CR.collateralRequirement*1.02
        else convert(float, 0) end
    , -case
        when CR.collateralRequirement>RCA.mv_collHeld_cashAndSec_passingIndivTests
          then CR.collateralRequirement-RCA.mv_collHeld_cashAndSec_passingIndivTests
        else convert(float, 0) end
      +case
        when RCA.mv_collHeld_cashAndSec_passingIndivTests>CR.collateralRequirement*1.02
          then RCA.mv_collHeld_cashAndSec_passingIndivTests-CR.collateralRequirement*1.02
        else convert(float, 0) end
    from (
      select reinsurerName, max(FEIN) FEIN, max(LEI) LEI
      , sum(mv_collHeld_cashAndSec_combined) mv_collHeld_cashAndSec_combined
      , sum(mv_collHeld_cashAndSec_passingIndivTests) mv_collHeld_cashAndSec_passingIndivTests
      , sum(mv_collHeld_cashAndSec_passingPortTests) mv_collHeld_cashAndSec_passingPortTests
      , sum(mv_collHeld_corpBonds_all_nominal) mv_collHeld_corpBonds_all_nominal
      , sum(mv_collHeld_corpBonds_all_pctOfCombined) mv_collHeld_corpBonds_all_pctOfCombined
      , sum(mv_collHeld_corpBonds_3yr_nominal) mv_collHeld_corpBonds_3yr_nominal
      , sum(mv_collHeld_corpBonds_3yr_pctOfCombined) mv_collHeld_corpBonds_3yr_pctOfCombined
      from R01_reinsCollateralByAccount
      group by reinsurerName
    ) RCA
    , support_R01_cvMasterEntityIDMap MEIM
    , (
      select RNM.originalReinsurerName, sum(P.eCollateralRequirement) collateralRequirement
      from support_R03_participations P, (
        select originalReinsurerName, alternativeReinsurerName
        from (
            select Reinsurer_Name originalReinsurerName, Reinsurer_Name alternativeReinsurerName
            from support_R01_cvMasterEntityIDMap
          union
            select Reinsurer_Name originalReinsurerName, Reinsurer_Name_AonVersion alternativeReinsurerName
            from support_R01_cvMasterEntityIDMap
          union
            select MEIM.Reinsurer_Name originalReinsurerName, ARNL.[Alternate Name] alternativeReinsurerName
            from support_R01_cvMasterEntityIDMap MEIM, alternateReinsurerNameLookup ARNL
            where MEIM.Reinsurer_Name=ARNL.[Primary Name]
        ) U
        group by originalReinsurerName, alternativeReinsurerName
      ) RNM
      where P.[﻿reinsurer name]=RNM.alternativeReinsurerName
      group by RNM.originalReinsurerName
    ) CR
    where RCA.reinsurerName=MEIM.Reinsurer_Name and RCA.reinsurerName=CR.originalReinsurerName
    order by RCA.reinsurerName



    insert into R02_Coll_Held_1_Reinsurer (
      [Account Title]
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
    )
    select
      DL.[Account Title]
    , DL.[Account]
    , DL.[Portfolio Type]
    , DL.[Security Type]
    , DL.[Description]
    , DL.[Industry]
    , DL.[CUSIP]
    , DL.[Maturity Date]
    , DL.[Years to Maturity]
    , DL.[As of Date]
    , DL.[S&P Rating]
    , DL.[Moody's Rating]
    , DL.[Market Value (Pre-Test)]
    , DL.[MV % of Total]
    from (
      SELECT CBR.[Trust Account 1] trustAccount
        from R03_Re_Collateral_by_Reinsurer CBR, reinsurerSelection RS
        where CBR.[Reinsurer Name]=RS.reinsurerSelection and CBR.[Trust Account 1]<>''
      union
        SELECT CBR.[Trust Account 2] trustAccount
        from R03_Re_Collateral_by_Reinsurer CBR, reinsurerSelection RS
        where CBR.[Reinsurer Name]=RS.reinsurerSelection and CBR.[Trust Account 2]<>''
      union
        SELECT CBR.[Trust Account 3] trustAccount
        from R03_Re_Collateral_by_Reinsurer CBR, reinsurerSelection RS
        where CBR.[Reinsurer Name]=RS.reinsurerSelection and CBR.[Trust Account 3]<>''
    ) A, support_R02_Dataload_A DL
    where A.trustAccount=DL.Account
    order by DL.i



    insert into R04_Coll_Req_by_Reins_All_Deals (
      [reinsurerName]
    , [dealName]
    , [reinsurerParticipation_initial]
    , [effectiveDate]
    , [reinsurerParticipation]
    , [collateralFactor]
    , [reductionFactor]
    , [seasoningFactor]
    , [netCollateralFactor]
    , [collateralRequirement]
    )
    select
      [﻿reinsurer name] reinsurerName
    , [deal name] dealName
    , [reinsurer participation] reinsurerParticipation_initial
    , [effective date] effectiveDate
    , [eReinsurerParticipation_current] reinsurerParticipation
    , [eCollateralFactor_current] collateralFactor
    , [eReductionFactor] reductionFactor
    , [eSeasoningFactor] seasoningFactor
    , [eCollateralFactor_current]*(-[eReductionFactor]+1)*[eSeasoningFactor] netCollateralFactor
    , [eCollateralRequirement] collateralRequirement
    from support_R03_participations
    where [﻿reinsurer name] is not null
    order by 
      [﻿reinsurer name]
    , [deal name]



    insert into R05_Coll_Required_1_Reinsurer (
      [reinsurerName]
    , [dealName]
    , [reinsurerParticipation_initial]
    , [effectiveDate]
    , [reinsurerParticipation]
    , [collateralFactor]
    , [reductionFactor]
    , [seasoningFactor]
    , [netCollateralFactor]
    , [collateralRequirement]
    )
    select
      CR.[reinsurerName]
    , CR.[dealName]
    , CR.[reinsurerParticipation_initial]
    , CR.[effectiveDate]
    , CR.[reinsurerParticipation]
    , CR.[collateralFactor]
    , CR.[reductionFactor]
    , CR.[seasoningFactor]
    , CR.[netCollateralFactor]
    , CR.[collateralRequirement]
    from R04_Coll_Req_by_Reins_All_Deals CR,  (
        select Reinsurer_Name originalReinsurerName, Reinsurer_Name alternativeReinsurerName
        from support_R01_cvMasterEntityIDMap
      union
        select Reinsurer_Name originalReinsurerName, Reinsurer_Name_AonVersion alternativeReinsurerName
        from support_R01_cvMasterEntityIDMap
      union
        select MEIM.Reinsurer_Name originalReinsurerName, ARNL.[Alternate Name] alternativeReinsurerName
        from support_R01_cvMasterEntityIDMap MEIM, alternateReinsurerNameLookup ARNL
        where MEIM.Reinsurer_Name=ARNL.[Primary Name]
    ) U, reinsurerSelection RS
    where CR.reinsurerName=U.alternativeReinsurerName and U.originalReinsurerName=RS.reinsurerSelection
    order by CR.effectiveDate, CR.dealName



    insert into R06_Global_Credit_Check (
      [reinsurerName]
    , [Total Corporates]
    , [Total Credit Check]
    , [Haircut Factor]
    )
    select reinsurerName
    , mv_collHeld_corpBonds_all_pctOfCombined
    , case when mv_collHeld_corpBonds_all_pctOfCombined >= 0.3 then 'Fail' else 'Pass' end
    , case
        when mv_collHeld_corpBonds_all_pctOfCombined >= 0.3 then (power(mv_collHeld_corpBonds_all_pctOfCombined, -1)-1)*3/7
        else convert(float, 1) end
    from R01_reinsCollateralByAccount
    where mv_collHeld_corpBonds_all_pctOfCombined>0



    insert into R07_Rating_Exception (
      [Account Title]
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
    )
    select
      [Account Title]
    , [Account]
    , [Portfolio Type]
    , [Security Type]
    , [Description]
    , [Industry]
    , [CUSIP]
    , [Maturity Date]
    , [Market Value (Pre-Test)] [Market Value]
    , [MV % of Total]
    , [Years to Maturity]
    , [As of Date]
    , [S&P Rating]
    , [Moody's Rating]
    , [Fitch Rating]
    , case when [Impermissible Corporate Bond due to Ratings (ICBR)]=1 then 'Fail' else 'Pass' end [Rating Check]
    , case when [CB*M3]=1 then 'Fail' else 'Pass' end [Maturity Check]
    , case when [CB*MV10]=1 then 'Fail' else 'Pass' end [Individual Weight Check]
    from support_R02_Dataload_A
    where [Impermissible Corporate Bond due to Ratings (ICBR)]=1 



    insert into R08_Maturity_Exceptions (
      [Account Title]
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
    )
    select
      [Account Title]
    , [Account]
    , [Portfolio Type]
    , [Security Type]
    , [Description]
    , [Industry]
    , [CUSIP]
    , [Maturity Date]
    , [Market Value (Pre-Test)] [Market Value]
    , [MV % of Total]
    , [Years to Maturity]
    , [As of Date]
    , [S&P Rating]
    , [Moody's Rating]
    , [Fitch Rating]
    , case when [Impermissible Corporate Bond due to Ratings (ICBR)]=1 then 'Fail' else 'Pass' end [Rating Check]
    , case when [CB*M3]=1 then 'Fail' else 'Pass' end [Maturity Check]
    , case when [CB*MV10]=1 then 'Fail' else 'Pass' end [Individual Weight Check]
    from support_R02_Dataload_A
    where [CB*M3]=1



    insert into R09_Individual_Weight_Check (
      [Account Title]
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
    )
    select
      DL.[Account Title]
    , DL.[Account]
    , DL.[Portfolio Type]
    , DL.[Security Type]
    , DL.[Description]
    , DL.[Industry]
    , DL.[CUSIP]
    , DL.[Maturity Date]
    , DL.[Market Value (Pre-Test)] [Market Value]
    , DL.[MV % of Total]
    , DL.[Years to Maturity]
    , DL.[As of Date]
    , DL.[S&P Rating]
    , DL.[Moody's Rating]
    , DL.[Fitch Rating]
    , case when DL.[Impermissible Corporate Bond due to Ratings (ICBR)]=1 then 'Fail' else 'Pass' end [Rating Check]
    , case when DL.[CB*M3]=1 then 'Fail' else 'Pass' end [Maturity Check]
    , case when DL.[CB*MV10]=1 then 'Fail' else 'Pass' end [Individual Weight Check]
    from support_R02_Dataload_A DL, (
      select R.*
      from (
              select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount1
        union select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount2
        union select DL.Account, MEIDM.Reinsurer_Name reinsurerName, DL.[Description], MEIDM.FEIN, MEIDM.LEI from (select Account, max([Description]) [Description] from support_R02_Dataload_A group by Account) DL, bkp_support_R01_cvMasterEntityIDMap MEIDM where DL.Account=MEIDM.trustAccount3
      ) R
        left outer join competingBrokerTrustAccounts CBTA on R.[Description]=CBTA.[Description]
        where CBTA.[Description] is null
    ) RN, R06_Global_Credit_Check R06
    where DL.Account=RN.Account and RN.reinsurerName=R06.reinsurerName
      and DL.[Corporate Bond Flag (CB)]=1
    order by DL.[Description], DL.CUSIP



    insert into individualAssetsFailingTests ([Index], CUSIP)
    select 0, CUSIP from (
            select CUSIP from R07_Rating_Exception where [Rating Check]='Fail'
      union select CUSIP from R08_Maturity_Exceptions where [Maturity Check]='Fail'
      union select CUSIP from R09_Individual_Weight_Check where [Individual Weight Check]='Fail'
    ) U
    group by CUSIP
    order by CUSIP;



    update individualAssetsFailingTests
    set [Index]=ID;



    insert into R10_MoM_Asset_Changes (
      [Account]
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
    )
    select
      Account
    , max([Description]) [Description]
    , max(reinsurerName) reinsurerName
    , sum(marketValue_runoff) marketValue_runoff
    , sum(marketValue_new) marketValue_new
    , sum(marketValue_continuing_prior) marketValue_continuing_prior
    , sum(marketValue_continuing_current) marketValue_continuing_current
    , case when sum(marketValue_continuing_prior)<>0 then sum(marketValue_continuing_current)/sum(marketValue_continuing_prior)-1
        else convert(float, 0) end marketValue_continuing_change
    , sum(marketValue_prior) marketValue_combined_prior
    , sum(marketValue_current) marketValue_combined_current
    , case when sum(marketValue_prior)<>0 then sum(marketValue_current)/sum(marketValue_prior)-1
        else convert(float, 0) end marketValue_combined_change
    From support_R10_MoM_AssetChangeDetail
    group by Account
    order by Account;



    insert into R11_MoM_Fin_Strength_Rtg_Changes (
      [reinsurerName]
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
    )
    select 
      SPFSR.SP_ENTITY_NAME [reinsurerName]
    , max(SPFSR.SP_CIQ_ID) [rating_SPCIQ_ID]
    , max(case when SRAP.i=2 then SPFSR.RD_CREDIT_RATING_GLOBAL else convert(nvarchar(31), '') end) [rating_SPCIQ_Prior]
    , max(case when SRAP.i=1 then SPFSR.RD_CREDIT_RATING_GLOBAL else convert(nvarchar(31), '') end) [rating_SPCIQ_Current]
    , case when
        max(case when SRAP.i=2 then SPFSR.RD_CREDIT_RATING_GLOBAL else convert(nvarchar(31), '') end)
      = max(case when SRAP.i=1 then SPFSR.RD_CREDIT_RATING_GLOBAL else convert(nvarchar(31), '') end)
      then 0 else 1 end [rating_SPCIQ_Change]
    , max(case when SRAP.i=2 then SPFSR.SP_FITCH_INSURER_FSR else convert(nvarchar(31), '') end) [rating_Fitch_Prior]
    , max(case when SRAP.i=1 then SPFSR.SP_FITCH_INSURER_FSR else convert(nvarchar(31), '') end) [rating_Fitch_Current]
    , case when
        max(case when SRAP.i=2 then SPFSR.SP_FITCH_INSURER_FSR else convert(nvarchar(31), '') end)
      = max(case when SRAP.i=1 then SPFSR.SP_FITCH_INSURER_FSR else convert(nvarchar(31), '') end)
      then 0 else 1 end [rating_Fitch_Change]
    , max(MEIDM.rating_AM_Best_Number) [rating_AM_Best_Number]
    , max(case when SRAP.i=2 then MEIDM.amBestFSR_fromHistory else convert(nvarchar(31), '') end) [rating_AMBest_Prior]
    , max(case when SRAP.i=1 then MEIDM.amBestFSR_fromHistory else convert(nvarchar(31), '') end) [rating_AMBest_Current]
    , case when
        max(case when SRAP.i=1 then MEIDM.amBestFSR_fromHistory else convert(nvarchar(31), '') end)
      = max(case when SRAP.i=2 then MEIDM.amBestFSR_fromHistory else convert(nvarchar(31), '') end)
      then 0 else 1 end [rating_AM_Best_Change]
    from
      support_R11_spGlobalFSR_history SPFSR
        left outer join (
          select
            H.[Activity Period] activityPeriod_fromHistory
          , M.rating_SPCIQ_ID, M.rating_AM_Best_Number
          , H.amBestFSR amBestFSR_fromHistory
          , [reinsurerNameWOComments], [AMB#], [NAIC#], [Company Name]
          , [Best's Financial Strength Rating - Current], [Best's Long-Term Issuer Credit Rating - Current]
          from support_R01_cvMasterEntityIDMap M, (
            select right(convert(nvarchar(15), convert(bigint, [AMB#]+1000000)), 6) ambNumber_6digit, *
            from support_R11_amBestFSR_history
          ) H
          where M.rating_AM_Best_Number=H.ambNumber_6digit
        ) MEIDM
        on SPFSR.SP_CIQ_ID=MEIDM.rating_SPCIQ_ID
    , stepdownReportActivityPeriods SRAP
    where SPFSR.stepdownReportActivityPeriod=SRAP.[Activity Period]
      and SRAP.[Activity Period]=MEIDM.activityPeriod_fromHistory
      and SRAP.i<=2
    group by SPFSR.SP_ENTITY_NAME



    insert into R12_Limit_Stepdowns (
      [deal]
    , [remainingLimitOfLiability_Prior]
    , [remainingLimitOfLiability_Current]
    , [change]
    )
    SELECT
      SDR.[Deal Name]
    , sum(case when SRAP.i=2 then convert(float, SDR.[Measure Values]) else 0 end)
    , sum(case when SRAP.i=1 then convert(float, SDR.[Measure Values]) else 0 end)
    , case when sum(case when SRAP.i=2 then convert(float, SDR.[Measure Values]) else 0 end)=0 then 0 else
      sum(case when SRAP.i=1 then convert(float, SDR.[Measure Values]) else 0 end)
     /sum(case when SRAP.i=2 then convert(float, SDR.[Measure Values]) else 0 end)-1 end
    from support_R03_stepdown_A SDR, stepdownReportActivityPeriods SRAP
    where SDR.[Measure Names]='Remaining Limit of Liability ($)'
      and SDR.[Activity Period]=SRAP.[Activity Period] and SRAP.i<=2
    group by SDR.[Deal Name]
    order by SDR.[Deal Name]
END

    
