@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Overall Sales Order Amount View enetity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP02_VH_LC as select from ZSD_APP02_IRV
{
   
    key Lnum,
//    @Semantics.amount.currencyCode: 'Lcurr'
    sum(cast(Lcamount as abap.dec(15,2) )) as Lcamount
//    Lcurr
   
} group by

  Lnum
// Lcurr
