@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order F4 help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_POV4 as select from I_PurchaseOrderAPI01 as _poh
inner join I_PurchaseOrderItemAPI01 as _poi on _poi.PurchaseOrder = _poh.PurchaseOrder
left outer join I_Product as prt on prt.Product = _poi.Material

{
@UI.hidden: true
key _poh.PurchaseOrder,
@UI.hidden: true
key _poi.PurchaseOrderItem,
@EndUserText.label: 'Purchase Lot No.'
_poh.YY1_PriorityPONO_PDH as Pono,
@EndUserText.label: 'Product Code'
_poi.Material as Material,
@Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
prt.YY1_UNIT_WGT_PRD as Unitwt,
@UI.hidden: true
prt.YY1_UNIT_WGT_PRDU


    
} where _poh.YY1_PriorityPONO_PDH is not initial
