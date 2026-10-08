@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolling Production Report RM'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_RM as select from ZR_BILLET_HDR as hd
left outer join ZR_BILLET_261 as rm on rm.id = hd.id
{
    key hd.postingdate,
    key hd.plant,
    @Semantics.quantity.unitOfMeasure:'uom'
    sum( rm.quantity) as rmqty,
    hd.uom,
    rm.storagelocation
}where hd.status = 'Completed'
group by
hd.postingdate,
hd.plant,
hd.uom,
rm.storagelocation
