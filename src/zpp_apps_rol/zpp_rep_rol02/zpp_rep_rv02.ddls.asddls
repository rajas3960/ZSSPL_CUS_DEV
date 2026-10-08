@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production report for 1010 and 1020'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPP_REP_RV02
  as select from  ZR_BILLET_HDR as hdr
//    on hdr.productionorder = pdp.ManufacturingOrder
//    and hdr.status = 'Completed'

left outer join ZR_BILLET_101 as item
    on item.id = hdr.id

left outer join ZR_BILLET_531 as rsp
    on rsp.id = hdr.id
   and rsp.material = 'RSP'

left outer join ZR_BILLET_531 as ws
    on ws.id = hdr.id
   and ws.material = 'WASTEANDSCRAPS'

left outer join ZR_BILLET_261 as billet
    on billet.id = hdr.id

left outer join I_ManufacturingOrder as pdp
    on pdp.ManufacturingOrder = hdr.productionorder
//inner join ZPP_APPSR_IRV2 as poi
//    on poi.Purchaseorder = item.purchaseorder
//    and poi.Purchaseitm = item.purchaseitm

{

key hdr.id,
key item.purchaseorder,
key item.prioritypo,
key hdr.productionorder,
key item.batch,
key item.length,
key item.pcs,

hdr.postingdate,
hdr.material,
hdr.referenceid,
hdr.plant,
hdr.density,
hdr.uom,
@Semantics.quantity.unitOfMeasure: 'Uom'
item.lengthmtr,
item.piece,
@Semantics.quantity.unitOfMeasure: 'Uom'
item.quantity,
item.storagelocation,
cast(
     cast( item.pcs as abap.int4 )
   - cast( item.piece as abap.int4 )
as abap.int4 ) as asqty,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.orderquantity,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.billetquantity,
hdr.noofbatches,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.heatquantity,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.totalpostquantity,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.shortqty,
@Semantics.quantity.unitOfMeasure: 'Uom'
hdr.byproductquantity,
hdr.yieldpercentage,
@Semantics.quantity.unitOfMeasure: 'Uom'
rsp.quantity as rspqty,
rsp.storagelocation as rsploc,
@Semantics.quantity.unitOfMeasure: 'Uom'
ws.quantity as wsqty,
ws.storagelocation as wsloc,
@Semantics.quantity.unitOfMeasure: 'buom'
billet.Qtybur,
billet.heatnumber,
billet.uom as buom,
pdp.PlannedOrder

//poi.Recplt,
//poi.Length as pplength,
//poi.Width,
//poi.Pcs as ppieces,
//@Semantics.quantity.unitOfMeasure: 'uom'
//poi.Menge
}where hdr.status = 'Completed'
