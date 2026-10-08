@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Job Sheet Release Report Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_TLT_REPORT_PV03 provider contract transactional_query as projection on ZPP_REPORT03_RV
{
    key Vrno,
    key Sectmat,
    key Sno,
    Project,
    Projectname,
    Purno,
    Secdesc,
    Orderno,
    Plant,
    Matnr,
    Maktx,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Plnqty,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Reqty,
    Uom,
    Vbeln,
    Length,
    Width,
    Wetpc,
    Netwt,
    Jobsht,
    Operation,
    OrderIsReleasedc,
    OrderIsReleased,
    Plndt,
    Contr,
    Contrname
}
