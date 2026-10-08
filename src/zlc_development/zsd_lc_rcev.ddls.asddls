@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Projection View -ZSD_LC_RCE'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_LC_RCEV provider contract transactional_query
  as projection on ZSD_LC_RCE
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
    @Semantics.amount.currencyCode: 'lc_curr'
    @EndUserText.label: 'LC Amount'
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
