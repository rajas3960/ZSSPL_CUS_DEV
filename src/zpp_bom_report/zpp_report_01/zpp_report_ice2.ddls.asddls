@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary  Sub Item Custom Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REPORT_ICE2 as select from ZPP_REP_IRV2
association to parent ZPP_REPORT_ICE as item on item.Material = $projection.Material
                                             and item.Structure = $projection.Structure
//                                             and item.Tower_type = $projection.Tower_type
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
//    /* Associations */
    item
//    _hdr
}
