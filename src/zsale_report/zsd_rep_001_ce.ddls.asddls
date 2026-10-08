@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'HS MS TOTAL WEIGHT Custom entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSD_REP_001_CE as select from ZSD_REP_001
{
    key SalesDocument,
    LastTwoChar,
    Totalweight,
    Totalprice
}
