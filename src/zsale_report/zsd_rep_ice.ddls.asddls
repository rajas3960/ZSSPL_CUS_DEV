@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity Of Sales Report Item'
@Metadata.ignorePropagatedAnnotations: true
//@UI.presentationVariant: [{ sortOrder: [{by: 'MainItemPricingRefProduct'  , direction: #ASC}] }]

define view entity ZSD_REP_ICE as select from zsd_apps_item
{
   key salesdocument,
   key billofmaterial,
   mainitempricingrefproduct,
   salesdocumentitemtext,
   consumptiontaxctrlcode,
   transactioncurrency,
   requestedquantityunit,
   @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
   requestedquantity,
   cgstrate,
   cgstvalue,
   sgstrate,
   sgstvalue,
   igstrate,
   igstvalue,
   zpr1rate,
   totalweight,
   totalprice
}
