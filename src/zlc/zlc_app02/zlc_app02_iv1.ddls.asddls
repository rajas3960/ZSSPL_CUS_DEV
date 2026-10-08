@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LC Master Maintainence Line items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZLC_APP02_IV1
  as select from zlc_app02_tb2
  association to parent ZLC_APP02_RV as _Hdr on $projection.Lnum = _Hdr.Lnum
{
  key lnum      as Lnum,
  key lcline    as Lcline,
      valfrm    as Valfrm,
      valto     as Valto,
      boeno     as Boeno,
      boedt     as Boedt,
      dudt      as Dudt,
 @Semantics.quantity.unitOfMeasure:'Unit'
  boeqty     as Boeqty,
  unit       as Unit,
  @Semantics.amount.currencyCode : 'Boecurr'
  instdebt   as Instdebt,
  @Semantics.amount.currencyCode : 'Boecurr'
  fright     as Fright,
  @Semantics.amount.currencyCode : 'Boecurr'
  tboeamt     as Tboeamt,
  @Semantics.amount.currencyCode : 'Boecurr'
  tlcamt    as Tlcamt,
  torlce    as Torlce,
  amtno      as Amtno,
  amtdt     as Amtdt,
      @Semantics.amount.currencyCode: 'Boecurr'
      boeamt    as Boeamt,
      boecurr   as Boecurr,
      noofdays  as Noofdays,
      accbstus  as Accbstus,
      @Semantics.amount.currencyCode: 'LcCurr'
      lcamt     as LcAmt,
      lccurr    as LcCurr,
      remark    as Remark,
      mark      as Mark,
      @Semantics.user.createdBy: true
      createdby as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon as Createdon,
      inst     as Inst,
      _Hdr
}
