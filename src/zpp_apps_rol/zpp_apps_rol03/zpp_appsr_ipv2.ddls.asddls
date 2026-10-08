@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Item Projection View 2'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APPSR_IPV2 as projection on ZPP_APPSR_IRV2
{
    key Uuid,
    key Purchaseorder,
    key Purchaseitm,
    Prioritypo,
    Recplt,
    Length,
    Width,
    Pcs,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    Menge,
    Meins,
    Matnr,
    Maktx,
    Mark,
    @EndUserText.label: 'Planned order'
    Plannedorder,
    Unitwt,
    /* Associations */
    _hdr : redirected to parent ZPP_APPSR_PV
}
