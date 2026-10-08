@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Root View Entity - ZSD_LC_RE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_LC_RCE as select from ZSD_LC_RE
{
@EndUserText.label: 'LC Number'
    key Lnum,
    Valfrm,
    Valto,
    Lcissdt,
    Banknam,
    Bank_Branch,
    @EndUserText.label: 'Sold to Party'
    Stp,
    @EndUserText.label: 'Customer Name'
    Stp_Name,
    Lc_Expdt,
    @EndUserText.label: 'LC Amount'
    @Semantics.amount.currencyCode: 'lc_curr'
    Lc_Amt,
    @Semantics.amount.currencyCode: 'lc_curr'
    Lc_Utilz,
    @Semantics.amount.currencyCode: 'lc_curr'
    Tot_Balance,
    Lc_Curr,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    @Semantics.user.lastChangedBy: true
    Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    Lastchangedon,
    status
}
