@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Proj Source View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_IPV6 as projection on ZPP_APPS05_IRV6
{
    key Uuid,
    key Srcid,
    Vrno,
    Srclent,
    Srcpcs,
    Lengthstr,
    Actlent,
    Wast,
    Rtnlent,
    Wastepr,
    Trmwste,
    Totlen,
    /* Associations */
    _citem : redirected to composition child zpp_apps05_ipv7,
    _hdr : redirected to parent ZPP_APPS05_PV
}
