@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Root Entity View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_LC_RE as select from zlc_tb1
{
    key lnum as Lnum,
    valfrm as Valfrm,
    valto as Valto,
    lcissdt as Lcissdt,
    banknam as Banknam,
    bank_branch as Bank_Branch,
    stp as Stp,
    stp_name as Stp_Name,
    lc_expdt as Lc_Expdt,
    @Semantics.amount.currencyCode: 'lc_curr'
    lc_amt as Lc_Amt,
    @Semantics.amount.currencyCode: 'lc_curr'
    lc_utilz as Lc_Utilz,
    @Semantics.amount.currencyCode: 'lc_curr'
    tot_balance as Tot_Balance,
    lc_curr as Lc_Curr,
    @Semantics.user.createdBy: true
    createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    @Semantics.user.lastChangedBy: true
    lastchangedby as Lastchangedby,
    @Semantics.systemDateTime.lastChangedAt: true
    lastchangedon as Lastchangedon,
    status as status
}
