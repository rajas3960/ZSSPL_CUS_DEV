@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interst Of LC'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZLC_REP_02 as select from zlc_app02_tb2 as a
{
    key a.lnum as LCNo,
   max( a.lcline ) as lcLINE,
   a.inst as Interest
}where a.inst is not initial
group by
a.lnum,
a.inst
