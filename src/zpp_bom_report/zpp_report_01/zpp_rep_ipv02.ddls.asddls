@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Sub item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_REP_IPV02 as projection on ZPP_REP_IRV2
{
    key Material,
    key Structure,
    key Tower_Type,
    BOM_HT,
    BOM_MS,
    BOM_BN,
    HT_Weight,
    MS_Weight,
    BN_Weight,
    Mark_No,
    /* Associations */
//    item :redirected to parent ZPP_REP_IPV01,
    _hdr : redirected to ZPP_REPORT_Hpv ,
    item: redirected to parent ZPP_REP_IPV01
}
