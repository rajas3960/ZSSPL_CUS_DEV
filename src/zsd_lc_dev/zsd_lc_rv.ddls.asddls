@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zsd_lc_rv
  as select from zlc_tb_1
 
{
  key lcnum       as Lcnum,
      valfrm      as Valfrm,
      valto       as Valto,
      lcissdt     as Lcissdt,
      banknam     as Banknam,
      bank_branch as Bank_Branch,
      stp         as Stp,
      stp_name    as Stp_Name,
      lc_expdt    as Lc_Expdt,
      @Semantics.amount.currencyCode: 'lc_curr'
      lc_amt      as Lc_Amt,
      @Semantics.amount.currencyCode: 'lc_curr'
      lc_utilz    as Lc_Utilz,
      @Semantics.amount.currencyCode: 'lc_curr'
      tot_balance as Tot_Balance,
      lc_curr     as Lc_Curr,
       @Semantics.user.createdBy: true
      createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon,
      @Semantics.user.lastChangedBy: true
      lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedon
}
