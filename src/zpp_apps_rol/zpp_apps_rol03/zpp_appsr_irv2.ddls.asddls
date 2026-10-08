@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Item View Entity 2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPSR_IRV2 as select from zpp_appsr_itb2
association to parent ZPP_APPSR_RV as _hdr on _hdr.Uuid = $projection.Uuid
{
    key uuid as Uuid,
    key purchaseorder as Purchaseorder,
    key purchaseitm as Purchaseitm,
    prioritypo as Prioritypo,
    recplt as Recplt,
    length as Length,
    width as Width,
    pcs as Pcs,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    menge as Menge,
    meins as Meins,
    matnr as Matnr,
    maktx as Maktx,
    mark as Mark,
    plannedorder as Plannedorder,
    unitwt as Unitwt,
    _hdr
} //where _hdr.Status <> 'D'
