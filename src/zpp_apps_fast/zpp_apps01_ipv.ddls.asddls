@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APPS01_IPV as projection on ZPP_APPS01_IRV
{
    key  Uuid,
   key  Productionorder,
   key Productionorderitem as Productionorderitem,
   material,
   rawmaterial,
   batch,
    Saleorder,
    Saleorderitem,
    Palnpc,
   @Semantics.quantity.unitOfMeasure: 'Meins'
    Menge,
    Meins,
    Unitwt,
    
    /* Associations */
    _hdr : redirected to parent ZPP_APPS01_PV01
}
