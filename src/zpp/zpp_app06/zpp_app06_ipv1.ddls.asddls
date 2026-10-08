@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Item PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APP06_IPV1
  as projection on ZPP_APP06_IRV1
{

  key jobshtnum,
  key matnr,
      plant,
      maktx,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      totreqty,
      Uom,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      receiptqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      totopnqty,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      totreceiptqty,
      @Semantics.user.createdBy: true
      createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon,
      _hdr : redirected to parent ZPP_APP06_PV1

}
