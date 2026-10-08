@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_MATERIAL_PV  as projection on ZPP_MATERIAL_RV
{
   key Matnr,
   key uuid,
   Plant,
   Batch,
   @Semantics.quantity.unitOfMeasure: 'Uom'
   Qty,
   Uom,
   Createdon,
    _hdr : redirected to parent ZPP_APPS01_PV01
}
