@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Item Custom Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_REPORT_ICE as select from ZPP_REP_IRV
composition[0..*] of ZPP_REPORT_ICE2  as item1
{
    key Material,
    key Structure,
//    key Tower_type,
    ProductName,
    item1
   
}
