@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Balance View Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS_ROLBALV as select from ZR_BILLET_101 as Itm
left outer join ZR_BILLET_HDR as hdr on hdr.id = Itm.id
{
 key  Itm.purchaseorder,
 key  Itm.purchaseitm,
      sum( cast(Itm.piece as abap.dec( 10, 0 ) ) ) as Piecs
      
       

}where hdr.status = 'Completed' and Itm.purchaseorder is not initial
group by
Itm.purchaseorder,
  Itm.purchaseitm
