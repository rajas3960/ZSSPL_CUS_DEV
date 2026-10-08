@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS01_IRV02 as select from zpp_apps01_itb01
association to parent ZPP_APPS01_RE as _hdr on _hdr.Uuid = $projection.Uuid
                                            
{
    key uuid as Uuid,
    key srno as Srno,
    key productionorder as Productionorder,
    productionorderitem as Productionorderitem,
    jcnum,
    saleorder as Saleorder,
    saleorderitem as Saleorderitem,
    pcs as Pcs,
    customer as customer,
    process,
    party,
    @Semantics.quantity.unitOfMeasure: 'Meins'
    menge as Menge,
    meins as Meins,
    matnr as Matnr,
    maktx as Maktx,
    mark,
    rawmatnr,
    batch,
    duedate as Duedate,
    unitwt as Unitwt,
    _hdr
}
