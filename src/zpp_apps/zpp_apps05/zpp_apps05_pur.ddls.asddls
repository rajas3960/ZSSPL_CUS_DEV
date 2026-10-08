@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true 
define view entity ZPP_APPS05_PUR as select from I_PurchaseOrderAPI01 as _poh
inner join I_PurchaseOrderItemAPI01 as _poi on _poi.PurchaseOrder = _poh.PurchaseOrder
left outer join I_Product as prt on prt.Product = _poi.Material
left outer join I_ProductText as Ptx on Ptx.Product = prt.Product 

{
@UI.hidden: true
key _poh.PurchaseOrder,
@UI.hidden: true
key _poi.PurchaseOrderItem,
@EndUserText.label: 'Purchase Lot No.'
@Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
_poh.YY1_PriorityPONO_PDH as Pono,
@EndUserText.label: 'Product Code'
@ObjectModel.text.element: [ 'ProductName' ]
@Search.defaultSearchElement: true
// @Search.fuzzinessThreshold: 0.3
//      @Search.ranking: #HIGH
_poi.Material as Material,
@Search.defaultSearchElement: true
// @Search.fuzzinessThreshold: 0.3
//      @Search.ranking: #HIGH
@EndUserText.label: 'Material Dec.'
Ptx.ProductName,
@Semantics.quantity.unitOfMeasure: 'YY1_UNIT_WGT_PRDU'
prt.YY1_UNIT_WGT_PRD as Unitwt,
@UI.hidden: true
prt.YY1_UNIT_WGT_PRDU



    
} where _poh.YY1_PriorityPONO_PDH is not initial
