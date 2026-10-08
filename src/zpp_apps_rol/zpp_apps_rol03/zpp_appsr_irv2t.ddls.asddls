@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pruduciton Order Item View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPSR_IRV2T as select from ZPP_APPSR_IRV2
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
    Plannedorder,
    Unitwt,
    /* Associations */
    _hdr
    
}where  _hdr.Status <> 'D'
