@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Orders - Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZPP_APPS06_RE as select from zpp_apps05_htb 
association[1..1] to I_ProductDescription as _prd on _prd.Product = $projection.Project and _prd.Language = 'E'
association[1..1] to I_ProductDescription as _prd2 on _prd2.Product = $projection.Sectmat and _prd2.Language = 'E'
association[1..1] to ZPP_APPS06_DVE as _stus on  _stus.name = $projection.Statusr
composition[1..*] of ZPP_APPS06_IRV as _item

{
   key  vrno as Vrno,
    werks as Werks,
    uuid as Uuid,
    vbeln as Vbeln,
    prod as Prod,
    project as Project,
    _prd.ProductDescription as Projectname,
    sectmat as Sectmat,
    _prd2.ProductDescription as Secdesc,
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
    case _stus.name 
    when 'R'
    then 3
    else 1 end as stuscrt,
    vrcuting as Vrcuting,
    totlentq as Totlentq,
    totwithst as Totwithst,
    totwithmk as Totwithmk,
    createdby as Createdby,
    createdon as Createdon,
    lastchangedby as Lastchangedby,
    lastchangedon as Lastchangedon,
    _stus.text as Text,
    _item
}
