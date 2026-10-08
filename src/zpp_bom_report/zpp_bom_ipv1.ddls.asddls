@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection Section Summary'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_BOM_IpV1 as projection on ZPP_BOM_IRV1
{
    key Uuid,
    key bomnum,
    key Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    Unitwt,
    Meins,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    Totalqty,
    _hdr :  redirected to parent ZPP_BOM_HDPV
}
