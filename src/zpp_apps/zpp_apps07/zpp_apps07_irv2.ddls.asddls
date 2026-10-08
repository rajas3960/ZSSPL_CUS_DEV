@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Raw Material'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS07_IRV2 as select from zpp_apps05_itb8
association to parent ZPP_APPS07_RV as _hdr on _hdr.Vrno = $projection.Vrno
{
    key vrno as Vrno,
    key sno as Sno,
    uuid as Uuid,
    length as Length,
    apcs as Apcs,
    used as Used,
    rqty as Rqty,
    uqty as Uqty,
    wasper as Wasper,
    rtrn as Rtrn,
    netwst as Netwst,
    quanwt as Quanwt,
    irno as Irno,
    matnr as Matnr,
    batch as Batch,
    plant as Plant,
    storagelocation as Storagelocation,
    _hdr
}
