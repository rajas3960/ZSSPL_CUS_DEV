@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of Structure Of BOM'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPV_REP provider contract transactional_query as projection on ZPP_STRUCTURE_REP01
{
    key Material,
    BillOfMaterial,
    Total_weight
}
