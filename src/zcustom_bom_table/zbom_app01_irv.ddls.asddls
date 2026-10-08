@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBOM_APP01_IRV
  as select from zbom_itb
  association to parent ZBOM_APP01_RV as _HDR on  _HDR.suid            = $projection.suid
                                              and _HDR.materialnumber = $projection.materialnumber
                                              and _HDR.plant          = $projection.plant
                                              and _HDR.bomusage       = $projection.bomusage
                                              and _HDR.alternativebom = $projection.alternativebom

{
  key suid                   as suid,
  key materialnumber         as materialnumber,
  key plant                  as plant,
  key bomusage               as bomusage,
  key alternativebom         as alternativebom,
  key itemid                 as itemid,
      bomitemnumber          as bomitemnumber,
      itemcategory           as itemcategory,
      bomcomponent           as bomcomponent,
      uom                    as uom,
      @Semantics.quantity.unitOfMeasure : 'uom'
      componentquantity      as componentquantity,
      componentunitofmeasure as componentunitofmeasure,
      wtpcinkg               as wtpcinkg,
      productwidthinmm       as productwidthinmm,
      totalweightinkg        as totalweightinkg,
      unitweightinkgm        as unitweightinkgm,
      productlengthinmm      as productlengthinmm,
      attachment             as attachment,
      @Semantics.mimeType: true
      minetype               as minetype,
      filename               as filename,
      status                 as status,
      createdby              as createdby,
      createdon              as createdon,
      _HDR

}
