@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Job Sheet Release Report Root view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_REPORT03_RV as select from ZPP_APPS06_RE as _hdr
left outer join ZPP_APPS06_IRV as _item on _item.Vrno = _hdr.Vrno
left outer join ZPP_APPS05_RV as js on js.Vrno = _hdr.Vrno 
{
    
     key _hdr.Vrno as Vrno,
     key _hdr.Sectmat,
    key _item.Sno as Sno,
    _hdr.Project,
    _hdr.Projectname,
    _hdr.Purno,
    _hdr.Secdesc,
    _item.Orderno as Orderno,
    _item.Plant as Plant,
    _item.Matnr as Matnr,
    _item.Maktx as Maktx,
    @Semantics.quantity.unitOfMeasure: 'uom'
    _item.Plnqty as Plnqty,
     @Semantics.quantity.unitOfMeasure: 'uom'
    _item.Reqty as Reqty,
    _item.Uom as Uom,
    _item.Vbeln as Vbeln,
    _item.Length as Length,
    _item.Width as Width,
    _item.Wetpc as Wetpc,
    _item.Netwt as Netwt,
    _item.Jobsht as Jobsht,
    _item.Operation as Operation,
     _item.OrderIsReleasedc,
     _item.OrderIsReleased,
     js.Plndt,
     js.Contr,
     js.Contrname
}
