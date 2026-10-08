@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'iTEM vIEW'
@Metadata.ignorePropagatedAnnotations: true



/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root  view entity ZPP_APPS05_ITMS as select from zpp_apps05_grp03
association[1..1] to zpp_apps05_htb as _hdr on _hdr.vrno = $projection.Vrno
composition [1..*] of ZPP_APPS05_SUITEMV as _ITEM

{

   key vrno as Vrno,
  key  jobsht as Jobsht,
   uuid as Uuid,
//  key sno as Sno,
//  orderno as Orderno,
 
  plant as Plant,
//  matnr as Matnr,
//  maktx as Maktx,
  _hdr.project,
  _hdr.projectname,
  _hdr.purno,
  _hdr.werks,
  _hdr.sectmat,
  _hdr.unitwet,

 
  operation as Operation,
  _ITEM,
  _hdr
  
}
group by
vrno,
  jobsht,
uuid,
// orderno,
 plant,
//  matnr,
//   maktx,
  _hdr.project,
  _hdr.projectname,
  _hdr.purno,
  _hdr.werks,
  _hdr.sectmat,
  _hdr.unitwet,
  operation

