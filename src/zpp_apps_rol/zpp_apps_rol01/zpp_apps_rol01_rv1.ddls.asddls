@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View Entity 2 Production Planning'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_ROL01_RV1 as select from I_PurchaseOrderAPI01 as _Poh
inner join I_PurchaseOrderItemAPI01 as _Poi on _Poi.PurchaseOrder = _Poh.PurchaseOrder
left outer join ZPP_APPSR_PSCHV as _pos on _pos.PurchaseOrder = _Poi.PurchaseOrder and _pos.PurchaseOrderItem = _Poi.PurchaseOrderItem
//association[1..*] to ZPP_APPS_PRV as itm on itm.PurchaseOrder = _Poi.PurchaseOrder and itm.PurchaseOrderItem = _Poi.PurchaseOrderItem  and itm.Mark2 = 'P'
{
  key _Poh.PurchaseOrder,
  key _Poi.PurchaseOrderItem,
  _Poh.YY1_PriorityPONO_PDH,
  _Poh.SupplyingPlant  as SupplyingPlant,
  cast(_Poi.Plant as abap.char(10) ) as Plant ,
  _Poi.YY1_Length_PDI,
  _Poi.YY1_Width_PDI,
  _Poi.YY1_Pieces_PDI,
  @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
  _Poi.OrderQuantity,
  _Poi.PurchaseOrderQuantityUnit,
   _Poi.Material,
  _Poi.PurchaseOrderItemText,
  _pos.SchedLineStscDeliveryDate
//  itm.Plannedorder,
//  @Semantics.quantity.unitOfMeasure: 'meins'
//  itm.OrderQuantity as menge,
//  itm.PurchaseOrderQuantityUnit as meins
  
  
} where (_Poh.SupplyingPlant = '1020' or _Poh.SupplyingPlant = '1010') and _Poi.PurchasingDocumentDeletionCode <> 'L' and _Poi.IsCompletelyDelivered <> 'X'

union all select from I_SalesDocument as _SOH
inner join I_SalesDocumentItem as _sOI on _sOI.SalesDocument = _SOH.SalesDocument 
left outer join ZPP_APPSR_SSCHV as _sos on _sos.SalesDocument =  _sOI.SalesDocument and _sos.SalesDocumentItem = _sOI.SalesDocumentItem
//association[1..*] to ZPP_APPS_PRV as sitm on sitm.PurchaseOrder = _sOI.SalesDocument and sitm.PurchaseOrderItem =  _sOI.SalesDocumentItem ,  and sitm.Mark2 = 'P' 
{
key _SOH.SalesDocument as PurchaseOrder,
key cast(
  substring( _sOI.SalesDocumentItem, 2, 5 )
  as abap.numc( 5 )
) as  PurchaseOrderItem,
_SOH.YY1_PriorityPONos_SDH as YY1_PriorityPONO_PDH,
_sOI.Plant as SupplyingPlant,
cast(_SOH.SoldToParty as abap.char(10)) as Plant,
_sOI.YY1_length_S_SDI as YY1_Length_PDI,
_sOI.YY1_Width_S_SDI as YY1_Width_PDI,
_sOI.YY1_Pieces_S_SDI as YY1_Pieces_PDI,
cast(_sOI.OrderQuantity as abap.quan( 13, 3 ) ) as OrderQuantity ,
_sOI.OrderQuantityUnit as PurchaseOrderQuantityUnit,
_sOI.Material,
_sOI.SalesDocumentItemText as PurchaseOrderItemText,
_sos.DeliveryDate as SchedLineStscDeliveryDate
//sitm.Plannedorder,
//  sitm.OrderQuantity as menge,
//  sitm.PurchaseOrderQuantityUnit as meins
  


}where _sOI.Plant = '1020' or _sOI.Plant = '1010' and _sOI.TotalDeliveryStatus <> 'C'
