@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolling Production Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_01
  as select from    ZR_BILLET_HDR as hdr
    left outer join ZR_BILLET_101 as item  on  item.id       = hdr.id
                                           and item.material = hdr.material
//    left outer join ZPP_REP_02    as mtd   on  mtd.postingdate = hdr.postingdate
//                                           and mtd.plant       = hdr.plant
//    left outer join ZR_BILLET_531 as scrap on scrap.id = hdr.id
{
  key hdr.postingdate,
      hdr.plant,
      @Semantics.quantity.unitOfMeasure: 'uom'
      sum( item.quantity)   as actqty,
      hdr.uom,
      item.storagelocation
//      @Semantics.quantity.unitOfMeasure: 'uom'
//      mtd.mactqty,
//      scrap.material        as matnr,
//      scrap.materialdescription,
//      @Semantics.quantity.unitOfMeasure: 'uom'
//      scrap.quantity,
//      scrap.storagelocation as scraplocation


}
where hdr.status = 'Completed'
group by
  hdr.plant,
  hdr.postingdate,
  hdr.uom,
  item.storagelocation
//  mtd.mactqty,
//  scrap.material,
//  scrap.materialdescription,
//  scrap.quantity,
//  scrap.storagelocation
