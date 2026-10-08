@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolling Production Report scarp'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_561
  as select from    ZR_BILLET_HDR as hd
    left outer join ZR_BILLET_531 as sc on  sc.id    = hd.id
                                        and sc.plant = hd.plant
{
  key hd.postingdate,
  key hd.plant,
      sc.material,
      sc.materialdescription,
      @Semantics.quantity.unitOfMeasure: 'uom'
      sum(sc.quantity) as Scrapqty,
      sc.uom,
      sc.storagelocation
      //      @Semantics.quantity.unitOfMeasure: 'uom'
      //      sum( sc1.quantity) as mScrapqty

}
where
  hd.status = 'Completed'
group by
  hd.postingdate,
  hd.plant,
  sc.material,
  sc.materialdescription,
  sc.uom,
  sc.storagelocation
