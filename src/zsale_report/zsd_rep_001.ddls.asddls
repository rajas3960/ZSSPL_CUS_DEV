@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HT MS TOTAL WEIGHT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_REP_001 as select from ZSD_REPORT
{
    key SalesDocument,
   LastTwoChar,
   sum( TotalWeight) as Totalweight ,
    sum(TotalPrice) as Totalprice
    
}
group by 
SalesDocument,
LastTwoChar
