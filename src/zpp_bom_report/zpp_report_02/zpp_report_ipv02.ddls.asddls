@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Report Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_REPORT_IPV02 as projection on ZPP_REPORT_IRV02
{
    key Project,
    key Towertype,
    key Towersubtype,
    key Structure,
    key MarkNumber,
    Componet,
    Comp,
    /* Associations */
    _hdr: redirected to parent zpp_report_PV
}
