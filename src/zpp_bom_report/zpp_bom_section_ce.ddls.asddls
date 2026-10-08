@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity Of Section Item'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_BOM_SECTION_CE
  as select from ZPP_BOM_IRV1
{
  key    Uuid,
  key    bomnum as bomnum,
  key    Matnr as BillOfMaterialComponent,
         Maktx as markdesc,
         @Semantics.quantity.unitOfMeasure: 'Meins'
         Unitwt,
         Meins,
         @Semantics.quantity.unitOfMeasure: 'Meins'
         Totalqty as total_weight

}
