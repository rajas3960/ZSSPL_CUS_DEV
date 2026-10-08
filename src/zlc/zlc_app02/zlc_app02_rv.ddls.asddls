@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Master Maintainence Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZLC_APP02_RV
  as select from zlc_app02_tb1
  composition [0..*] of ZLC_APP02_IV1 as _Line
  composition [0..*] of ZLC_APP02_IV2 as _Lineboi
  association[1..1] to zsd_image_dom as _image on 'Y' = _image.FIXED_VAL
{
  key lnum          as Lnum,
      valfrm        as Valfrm,
      valto         as Valto,
      banknam       as Banknam,
      bankbranch    as BankBranch,
      stp           as Stp,
      stpname       as StpName,
      @Semantics.amount.currencyCode: 'LcCurr'
      tlcamt        as TlcAmt,
      @Semantics.amount.currencyCode: 'LcCurr'
      tlcutilz      as TlcUtilz,
      @Semantics.amount.currencyCode: 'LcCurr'
      totbalance    as TotBalance,
      lccurr        as LcCurr,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon     as Createdon,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedon as Lastchangedon,
      project       as Project,
      applicant     as Applicant,
      ldd           as Ldd,
      mark          as Mark,
      beneficiary   as Beneficiary,
      incoterm      as Incoterm,
      remark        as Remark,
  @Semantics.quantity.unitOfMeasure : 'unit'
      totalqty      as Totalqty,
      unit          as Unit,
      popi          as Popi,
//      @Semantics.imageUrl: true
@Semantics.imageUrl: true
     _image.IMAGES as IMAGES,
      @Semantics.amount.currencyCode : 'LcCurr'
  aclcamt     as Aclcamt, // Actual LC Received(Total BOE Value)
   @Semantics.amount.currencyCode : 'LcCurr'
  planlcamt      as  Planlcamt, //Planned Balance
  @Semantics.amount.currencyCode : 'LcCurr'
  totboeamt  as  Totboeamt,     //Total BOE Value
  @Semantics.amount.currencyCode : 'LcCurr'
  totavamt    as Totavamt, 
 torlce     as Torlce,
      _Line,
      _Lineboi
}
