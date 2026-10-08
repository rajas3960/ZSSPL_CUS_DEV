@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Apps GI&&GR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS07_RV
  as select from zpp_apps05_htb
association[1..1] to ZPP_APPS07_DGI as Dgi on Dgi.name = $projection.Statusgi
association[1..1] to ZPP_APPS07_DGR as Dgr on Dgr.name = $projection.Statusgr
composition[1..*] of ZPP_APPS07_IRV as _Item
composition[1..*] of ZPP_APPS07_IRV2 as _Rawitm 
{

  key vrno as Vrno,
    werks as Werks,
    uuid as Uuid,
    vbeln as Vbeln,
    prod as Prod,
    project as Project,
    projectname as Projectname,
    sectmat as Sectmat,
    unitwet as Unitwet,
    purno as Purno,
    delmark as Delmark,
    status as Status,
   statusr as Statusr,
    relusr as Relusr,
    chckmrk as Chckmrk,
    gengt as Gengt,
    matno as Matno,
    contr as Contr,
    contrname as Contrname,
    plndt as Plndt,
    remark as Remark,
//      statusr     as Statusr,
      statusgi    as Statusgi,
      statusgr    as Statusgr,
//      relusr      as Relusr,
      pgiusr      as Pgiusr,
      pgrusr      as Pgrusr,
      Dgi.text    as Goodsisudesc,
      Dgr.text as Goodsrctsdec,
       vrcuting as Vrcuting,
    totlentq as Totlentq,
    totwithst as Totwithst,
    totwithmk as Totwithmk,
    createdby as Createdby,
    createdon as Createdon,
    lastchangedby as Lastchangedby,
    lastchangedon as Lastchangedon,
      _Item,
      _Rawitm
       

}
