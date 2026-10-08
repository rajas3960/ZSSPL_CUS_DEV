@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for LC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZLC_APP02_VH as select from ZLC_APP02_RV
{


 @EndUserText.label: 'LC Number'
    key Lnum,
 @EndUserText.label: 'Lc Expiry Date'
    Valto,
 @EndUserText.label: 'Customer No'
    Stp,
    @Semantics.amount.currencyCode: 'LcCurr'
 @EndUserText.label: 'Total LC Balance'
    TotBalance,
    @UI.hidden: true
    LcCurr,
 @EndUserText.label: 'Last Date Of Dispatch'
    Ldd
}
where TotBalance > 0.0 and Ldd >= $session.system_date
