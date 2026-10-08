@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Root View'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZPP_MATERIAL_RV as select from zpp_material_tb
association to parent ZPP_APPS01_RE as _hdr on _hdr.Uuid = $projection.uuid
{

    key matnr as Matnr,
    key uuid as uuid,
    plant as Plant,
    batch as Batch,
    @Semantics.quantity.unitOfMeasure : 'Uom'
    qty as Qty,
    uom as Uom,
    @Semantics.systemDateTime.createdAt: true
    createdon as Createdon,
    _hdr
}
