@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bill Of Material Report PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPP_BOM_REPV as select from zpp_Bom_report
{
    key Uuid,
    key Srno,
    Proj,
    BillOfMaterialComponent,
    BOM,
    mark
}
