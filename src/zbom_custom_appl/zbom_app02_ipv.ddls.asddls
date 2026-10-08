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
define view entity ZBOM_APP02_IPV as projection on ZBOM_APP02_IRV
{
    key suid,
    key materialNumber,
    key plant,
    key bomusage,
    key alternativebom, 
    key itemid,

      Internalitemidentification,
  validfromdate,
  bomstatus,
  changenumber,
  @Semantics.quantity.unitOfMeasure : 'uom'
  basequantity,
  baseunitofmeasureforbom,
  bomdescription,
//  itemid,
//  Internalitemidentification,
  bomitemnumber,
  itemcategory,
  bomcomponent,
  uom,
    @Semantics.quantity.unitOfMeasure : 'uom'
  componentquantity,
  componentunitofmeasure,
  indicatorrelevancytocosting,
  productionrelevant,
  indicatoritemrelevanttosales,
  itemrelevanttoengineering,
  operationscrap,
  componentscrapinpercent,
  indicatornetscrap,
  alternativeitemgroup,
  alternativeitemrankingorder,
  alternativeitemstrategy,
  alternativeitemusageprobabilit,
  storageLocation,
    _HDR :redirected to parent ZBOM_APP02_PV2
}
