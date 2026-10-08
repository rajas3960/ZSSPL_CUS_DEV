@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Actual and Balance View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_ROL02cv as select from ZPP_APPS_PRV as hdr
left outer join ZPP_APPS_ROLBALV as bal on bal.purchaseitm = hdr.PurchaseOrderItem and bal.purchaseorder = hdr.PurchaseOrder
{
    key hdr.PurchaseOrder,
    key hdr.PurchaseOrderItem,
    hdr.SupplyingPlant,
    cast(hdr.YY1_Pieces_PDI as abap.dec( 10, 0 ) ) as YY1_Pieces_PDI,
    case when bal.Piecs is not initial then
    hdr.YY1_Pieces_PDI - bal.Piecs
    else
     hdr.YY1_Pieces_PDI
     end
    
     as bal
    
    
} where hdr.PurchaseOrder is not initial
group by
   hdr.PurchaseOrder,
    hdr.PurchaseOrderItem,
    hdr.SupplyingPlant,
    hdr.YY1_Pieces_PDI,
    bal.Piecs
