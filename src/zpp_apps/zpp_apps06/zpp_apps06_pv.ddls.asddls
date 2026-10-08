@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Orders - Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS06_PV provider contract transactional_query as projection on ZPP_APPS06_RE
{
    key Vrno,
    Werks,
    Uuid,
    Vbeln,
    Prod,
    Project,
    Projectname,
    Sectmat,
    Secdesc,
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
    stuscrt,
    Vrcuting,
    Totlentq,
    Totwithst,
    Totwithmk,
    Createdby,
    Createdon,
    Lastchangedby,
    Lastchangedon,
   
    /* Associations */
    _item : redirected to composition child ZPP_APPS06_IPV,
    Text
}
