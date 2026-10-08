@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBOM_APP02_IRV as select from zbom_app02_itb2
association to parent ZBOM_APP02_RV as _HDR on _HDR.Suid = $projection.suid
//                                           and _HDR.materialnumber = $projection.materialNumber
//                                           and _HDR.plant = $projection.plant
//                                           and _HDR.bomusage = $projection.bomusage
//                                           and _HDR.alternativebom = $projection.alternativebom
                                            
                                                                                     
{
  key suid                       as suid,
  key materialnumber             as materialNumber,
  key plant                      as plant,
  key bomusage                   as bomusage,
  key alternativebom             as alternativebom,
  key itemid                     as itemid,
  
   internalitemidentification     as Internalitemidentification,
  validfromdate                  as validfromdate,
  bomstatus                      as bomstatus,
  changenumber                   as changenumber,
  @Semantics.quantity.unitOfMeasure : 'uom'
  basequantity                   as basequantity,
  baseunitofmeasureforbom        as baseunitofmeasureforbom,
  bomdescription                 as bomdescription,
//  itemid                         as itemid,
//  internalitemidentification     as Internalitemidentification, 
  bomitemnumber                  as bomitemnumber,
  itemcategory                   as itemcategory,
  bomcomponent                   as bomcomponent,
  uom                            as uom,
   @Semantics.quantity.unitOfMeasure : 'uom'
  componentquantity              as componentquantity,
  componentunitofmeasure         as componentunitofmeasure,
  indicatorrelevancytocosting    as indicatorrelevancytocosting,
  productionrelevant             as productionrelevant,
  indicatoritemrelevanttosales   as  indicatoritemrelevanttosales,
  itemrelevanttoengineering      as itemrelevanttoengineering,
  operationscrap                 as operationscrap,
  componentscrapinpercent        as componentscrapinpercent,
  indicatornetscrap              as  indicatornetscrap,
  alternativeitemgroup           as  alternativeitemgroup,
  alternativeitemrankingorder    as  alternativeitemrankingorder,
  alternativeitemstrategy        as  alternativeitemstrategy,
  alternativeitemusageprobabilit as  alternativeitemusageprobabilit,
  storagelocation                as  storageLocation,
          
  _HDR
}



