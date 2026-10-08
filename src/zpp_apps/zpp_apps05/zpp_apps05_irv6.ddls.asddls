@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Source View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IRV6 as select from zpp_apps05_itb6
association to parent ZPP_APPS05_RV as _hdr on _hdr.Uuid = $projection.Uuid
composition[0..*] of ZPP_APPS05_IRV7 as _citem
{
    key uuid as Uuid,
    key srcid as Srcid,
    vrno as Vrno,
    srclent as Srclent,
    srcpcs as Srcpcs,
    lengthstr as Lengthstr,
    actlent as Actlent,
    wast as Wast,
    rtnlent as Rtnlent,
    wastepr as Wastepr,
    trmwste as Trmwste,
    totlen as Totlen,
    _hdr,
    _citem
}
