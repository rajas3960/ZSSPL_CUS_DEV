@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity For Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS01_ICE as select from ZPP_APPS01_IRV02
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
    process,
    party,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    Menge,
    Meins,
    Matnr,
    Maktx,
    rawmatnr,
    batch,
    Duedate,
    Unitwt
}
