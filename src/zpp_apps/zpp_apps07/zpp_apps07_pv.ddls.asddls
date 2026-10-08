@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Order - Projection View GI & GR'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZPP_APPS07_PV provider contract transactional_query as projection on ZPP_APPS07_RV
{
    key Vrno,
    Werks,
    Uuid,
    Vbeln,
    Prod,
    Project,
    Projectname,
    Sectmat,
    Unitwet,
    Purno,
    Delmark,
    Status,
    Statusr,
    Relusr,
    Chckmrk,
    Gengt,
    Matno,
    Contr,
    Contrname,
    Plndt,
    Remark,
    Statusgi,
    Statusgr,
    Pgiusr,
    Pgrusr,
    Goodsisudesc,
    Goodsrctsdec,
    Vrcuting,
    Totlentq,
    Totwithst,
    Totwithmk,
    Createdby,
    Createdon,
    Lastchangedby,
    Lastchangedon,
    /* Associations */
    _Item : redirected to composition child ZPP_APPS07_IPV,
    _Rawitm : redirected to composition child ZPP_APPS07_IPV2
}
