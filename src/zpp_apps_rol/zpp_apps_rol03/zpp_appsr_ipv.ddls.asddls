@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APPSR_IPV as projection on ZPP_APPSR_IRV
{
    key Uuid,
    key Purchaseorder,
    key Purchaseitm,
    Prioritypo,
    Recplt,
    Length,
    Width,
    Pcs,
    @Semantics.quantity.unitOfMeasure: 'meins'
    Menge,
    Meins,
    Matnr,
    Maktx,
    Mark,
    Unitwt,
    /* Associations */
    _hdr  : redirected to parent ZPP_APPSR_PV
}
