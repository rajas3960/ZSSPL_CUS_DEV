@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Root View 2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP02_RV2 as select from zbom_app02_ht2
//association to parent ZBOM_APP02_RV as _HDR on _HDR.Suid = $projection.Suid
//                                           and _HDR.materialnumber = $projection.materialnumber
//                                           and _HDR.plant = $projection.plant
//                                           and _HDR.bomusage = $projection.bomusage
//                                           and _HDR.alternativebom = $projection.alternativebom
{
  key suid                   as Suid,

  key materialnumber         as materialnumber,
  key plant                  as plant,
  key bomusage               as bomusage,
  key alternativebom         as alternativebom,
  validfromdate              as validfromdate,
  bomstatus                  as bomstatus,
  changenumber               as changenumber,
  uom                        as uom,
  @Semantics.quantity.unitOfMeasure : 'uom'
  basequantity               as basequantity,
  bomdescription             as bomdescription, 
//  attachitem                 as AttachmentItem,                                                    
  attachment                 as Attachment,
  @Semantics.mimeType: true
  minetype                   as Minetype,
  filename                   as Filename
}
