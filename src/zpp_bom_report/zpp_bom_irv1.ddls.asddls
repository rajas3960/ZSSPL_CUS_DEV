@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Section Summary'
@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [{ sortOrder: [{by: 'mat_type' , direction: #ASC}] }]
define view entity ZPP_BOM_IRV1 as select from zpp_bom_itb1 as _item1
association to parent ZPP_BOM_HRE as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key bomnum,
    key matnr as Matnr,
    maktx as Maktx,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    unitwt as Unitwt,
    meins as Meins,
    mat_type,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    totalqty as Totalqty,
    _hdr
}
