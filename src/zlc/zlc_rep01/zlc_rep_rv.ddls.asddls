@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Maintainence Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZLC_REP_RV as select from zlc_app02_tb1 as hdr
left outer join ZLC_REP_01 as LCD on LCD.LCNO = hdr.lnum
left outer join ZLC_REP_02 as lcd1 on lcd1.LCNo = hdr.lnum
composition[0..*] of ZLC_REP_IRV as _item 
{
     key hdr.lnum          as Lnum,
      hdr.valfrm        as Valfrm,
      hdr.valto         as Valto,
      hdr.banknam       as Banknam,
      hdr.bankbranch    as BankBranch,
      hdr.stp           as Stp,
      hdr.stpname       as StpName,
      @Semantics.amount.currencyCode: 'LcCurr'
      hdr.tlcamt        as TlcAmt,
      @Semantics.amount.currencyCode: 'LcCurr'
      hdr.tlcutilz      as TlcUtilz,
      @Semantics.amount.currencyCode: 'LcCurr'
      hdr.totbalance    as TotBalance,
      hdr.lccurr        as LcCurr,
      @Semantics.user.createdBy: true
      hdr.createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      hdr.createdon     as Createdon,
      @Semantics.user.lastChangedBy: true
      hdr.lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      hdr.lastchangedon as Lastchangedon,
      hdr.project       as Project,
      hdr.applicant     as Applicant,
      hdr.ldd           as Ldd,
      hdr.mark          as Mark,
      hdr.beneficiary   as Beneficiary,
      hdr.incoterm      as Incoterm,
      hdr.remark        as Remark,
  @Semantics.quantity.unitOfMeasure : 'unit'
      hdr.totalqty      as Totalqty,
      hdr.unit          as Unit,
      hdr.popi          as Popi,
      @Semantics.amount.currencyCode : 'LcCurr'
  hdr.aclcamt     as Aclcamt, // Actual LC Received(Total BOE Value)
   @Semantics.amount.currencyCode : 'LcCurr'
  hdr.planlcamt      as  Planlcamt, //Planned Balance
  @Semantics.amount.currencyCode : 'LcCurr'
  hdr.totboeamt  as  Totboeamt,     //Total BOE Value
  @Semantics.amount.currencyCode : 'LcCurr'
  hdr.totavamt    as Totavamt, 
 hdr.torlce     as Torlce,
 LCD.NOOFDAYS,
 lcd1.Interest as Intrest,
 _item
}
