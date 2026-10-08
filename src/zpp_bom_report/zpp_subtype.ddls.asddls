@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Details Of Subtype'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@UI.presentationVariant: [
  {
    sortOrder: [
      { by: 'mat_type', direction: #ASC }
    ]
  }
]
define root view entity ZPP_SUBTYPE 
as select from ZPP_BOM_IRV1 as sub
//left outer join ZPP_RP01_RV as _item on _item.Material = hd.Structure
//left outer join ZPP_RP01_RV as _item1 on _item1.Material = _item.BillOfMaterialComponent
//left outer join ZPP_BOM_IRE as _mainitem on _mainitem.bomnumber = hd.Bomnumber
//                                        and _mainitem.Markno = _item1.BillOfMaterialComponent
//{
//key hd.Bomnumber,
//@EndUserText.label: 'Sub Type'
// key _item.Material,
// @EndUserText.label: 'Tower Type'
// key _item1.Material as MarkNumber,
// 
// sum( cast( _mainitem.totalwt as abap.dec(15,3) ) ) as total_weight,
// 
//@EndUserText.label: 'Material Suffix'
//substring( _item1.Material, length(_item1.Material) - 1, 2 ) as material_suffix
//}
//group by 
//hd.Bomnumber,
//_item.Material,
//_item1.Material;
{
key Uuid,
key bomnum,
key mat_type,
Meins,
@Semantics.quantity.unitOfMeasure: 'Meins'
sum(cast(Totalqty as abap.dec( 15, 3 ))) as total_weight
}
group by 
Uuid,
bomnum,
Meins,
mat_type
