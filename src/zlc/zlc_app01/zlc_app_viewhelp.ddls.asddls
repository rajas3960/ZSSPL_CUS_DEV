@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for LC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZLC_APP_VIEWHELP as select from ZLC_APP_RV
{
@EndUserText.label: 'LC Number'
   key Lnum,
@EndUserText.label: 'LC Expdt'
   Lc_Expdt,
   @EndUserText.label: 'LC Amount'
   @Semantics.amount.currencyCode: 'Lc_Curr'
   Lc_Amt,
   @EndUserText.label: 'LC Utliz Amount'
   @Semantics.amount.currencyCode: 'Lc_Curr'
   Lc_Utilz,
   @EndUserText.label: 'Balance'
   @Semantics.amount.currencyCode: 'Lc_Curr'
   Tot_Balance,
   @UI.hidden: true
   Lc_Curr
   
} 
where  Tot_Balance > 0.0 and Lc_Expdt >= $session.system_date
