@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Number Of days of LC'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZLC_REP_01 
  as select from zlc_app02_tb2 as a
    left outer join zlc_app02_tb2 as b
      on a.lnum = b.lnum
{
    key a.lnum as LCNO,

    max( a.lcline ) as lcline,

    max( cast(b.noofdays as abap.numc(10)) ) as NOOFDAYS,

     ' 'as INTREST
}
where b.noofdays is not initial 
group by
    a.lnum
