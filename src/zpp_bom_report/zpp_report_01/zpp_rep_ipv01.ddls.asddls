@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Item Details'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_REP_IPV01 as projection on ZPP_REP_IRV
{
    key Material,
    key Structure,
    ProductName,
    /* Associations */
//     Item1: redirected to composition child ZPP_REP_IPV02,
    _hdr: redirected to parent ZPP_REPORT_Hpv,
    Item1: redirected to composition child ZPP_REP_IPV02
}
