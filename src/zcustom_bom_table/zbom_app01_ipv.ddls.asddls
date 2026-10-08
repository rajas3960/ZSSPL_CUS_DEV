@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBOM_APP01_IPV
  as projection on ZBOM_APP01_IRV
{
  key suid,
  key materialnumber,
  key plant,
  key bomusage,
  key alternativebom,
  key itemid,
      bomitemnumber,
      itemcategory,
      bomcomponent,
      uom,
      @Semantics.quantity.unitOfMeasure : 'uom'
      componentquantity,
      componentunitofmeasure,
      wtpcinkg,
      productwidthinmm,
      totalweightinkg,
      unitweightinkgm,
      productlengthinmm,
      attachment,
      @Semantics.mimeType: true
      minetype,
      filename,
      status,
      createdby,
      createdon,
      _HDR : redirected to parent ZBOM_APP01_PV
}
