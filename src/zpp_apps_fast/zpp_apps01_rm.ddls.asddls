@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Raw Material Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS01_RM as select from ZPP_APPS01_IRV02 as hdr
//left outer join I_ProductionOrderComponent as pc on pc.Material = hdr.Product
//left outer join I_ProductionOrderComponent as pc1 on pc1.ProductionOrder = hdr.ProductionOrder    
//                                                 and pc1.MaterialGroup = 'WIRE ROD'                                            
{
    key hdr.rawmatnr,
    hdr.batch,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    sum(hdr.Menge ) as totalqty,
    hdr.Meins
    
}
group by
hdr.rawmatnr,
hdr.batch,
hdr.Meins
