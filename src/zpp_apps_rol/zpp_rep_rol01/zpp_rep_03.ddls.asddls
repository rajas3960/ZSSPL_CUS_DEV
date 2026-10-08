@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Rolling Production Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REP_03 as select from ZPP_REP_01 as hdr
left outer join ZPP_REP_02 as item on item.postingdate = hdr.postingdate
                                   and item.plant = hdr.plant
left outer join ZPP_REP_561 as sc on sc.postingdate = hdr.postingdate
                                  and sc.plant  =   hdr.plant  
left outer join ZPP_REP_RM as rm on rm.postingdate = hdr.postingdate
                                    and rm.plant = hdr.plant                                                                   

{
     key hdr.postingdate,
     key hdr.plant,
        @Semantics.quantity.unitOfMeasure: 'uom'
        hdr.actqty,
        hdr.uom,
        hdr.storagelocation,
        @Semantics.quantity.unitOfMeasure: 'uom'
        item.mactqty,
        sc.material,
        sc.materialdescription,
        @Semantics.quantity.unitOfMeasure: 'uom'
        sc.Scrapqty,
        sc.storagelocation as ScarpLocation,
        @Semantics.quantity.unitOfMeasure: 'uom'
        rm.rmqty,
        rm.storagelocation as RawmaterialLocation
    
}
