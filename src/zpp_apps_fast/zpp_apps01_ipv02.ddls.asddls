@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APPS01_Ipv02 as projection on ZPP_APPS01_IRV02
{
   key Uuid,
    key Srno,
    key Productionorder,
     Productionorderitem,
    jcnum,
    Saleorder,
    Saleorderitem,
    Pcs,
    customer,
    party,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    Menge,
    Meins,
    Matnr,
    Maktx,
    rawmatnr,
    batch,
    Duedate,
    Unitwt,
    process,
    /* Associations */
    _hdr : redirected to parent ZPP_APPS01_PV01
}
