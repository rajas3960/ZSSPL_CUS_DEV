@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for LC'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP02_VH as select from ZLC_APP02_VH
{
    key Lnum,
    Valto,
    Stp,
    @Semantics.amount.currencyCode: 'LcCurr'
    TotBalance,
    LcCurr,
    Ldd
}
