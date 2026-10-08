@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS01_IRV as select from zpp_apps01_itb
association to parent ZPP_APPS01_RE as _hdr on _hdr.Uuid = $projection.Uuid
{
   key uuid as Uuid,
   key productionorder as Productionorder,
   key productionorderitem as Productionorderitem,
   material,
   rawmaterial,
   batch,
   saleorder as Saleorder,
   saleorderitem as Saleorderitem,
   palnpc as Palnpc,
   mark,
   @Semantics.quantity.unitOfMeasure: 'Meins'
   menge as Menge,
   meins as Meins,
   unitwt as Unitwt,
   _hdr
   
   
}
