@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Master Maintainence Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZLC_APP02_RPV
  provider contract transactional_query
  as projection on ZLC_APP02_RV
{
@EndUserText.label: 'LC Number'
  key Lnum,
      Valfrm,
      Valto,
      Banknam,
      BankBranch,
      @EndUserText.label: 'Customer No'
      Stp,
      @EndUserText.label: 'Customer Name'
      StpName,
      @Semantics.amount.currencyCode: 'LcCurr'
      TlcAmt,
      @Semantics.amount.currencyCode: 'LcCurr'
      TlcUtilz,
      @Semantics.amount.currencyCode: 'LcCurr'
      TotBalance,
      LcCurr,
      @Semantics.user.createdBy: true
      Createdby,
      @Semantics.systemDateTime.createdAt: true
      Createdon,
      @Semantics.user.lastChangedBy: true
      Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      Lastchangedon,
      Project,
      Applicant,
      Ldd,
      Mark,
      Beneficiary,
        Incoterm,
    Remark,
  @Semantics.quantity.unitOfMeasure : 'unit'
  Totalqty,
    Unit,
    Popi,
    IMAGES,
   @Semantics.amount.currencyCode : 'LcCurr'
   Aclcamt,
   @Semantics.amount.currencyCode : 'LcCurr'
    Planlcamt,
  @Semantics.amount.currencyCode : 'LcCurr'
  Totboeamt,     
  @Semantics.amount.currencyCode : 'LcCurr'
   Totavamt,
   Torlce,
    
      /* Associations */
      _Line : redirected to composition child ZLC_APP02_IPV1,
      _Lineboi : redirected to composition child ZLC_APP02_IPV2
}
