@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'jobsheet projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zpp_jobsheet_pv as projection on zpp_jobsheet_REV
{
    key Jobnsheetno,
    key Orderno,
    MaterialSFG,
    Orderitemno,
    Reservationo,
    @Semantics.quantity.unitOfMeasure: 'uom'
    Plannedqty,
    @Semantics.quantity.unitOfMeasure: 'uom'
    Requestedqty,
    uom,
    Status,
    Deletionmark,
    Createdby,
    Createdon
}
