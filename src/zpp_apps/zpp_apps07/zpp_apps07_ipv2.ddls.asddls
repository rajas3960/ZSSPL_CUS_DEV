@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Raw Material Proj'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_APPS07_IPV2 as projection on ZPP_APPS07_IRV2
{
    key Vrno,
    key Sno,
    Uuid,
    Length,
    Apcs,
    Used,
    Rqty,
    Uqty,
    Wasper,
    Rtrn,
    Netwst,
    Quanwt,
    Irno,
    Matnr,
    Batch,
    Plant,
    Storagelocation,
    _hdr : redirected to parent ZPP_APPS07_PV
}
