@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Optimizing App Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS03_RV
  as select from zpp_apps03_htb
  composition[0..*] of ZPP_APPS03_IRV as _Item
  composition[0..*] of ZPP_APPS_IRV2 as _Item2
  composition[0..*] of ZPP_APPS03_IRV3 as _Item3
  
{
  key uuid          as Uuid,
      werks         as Werks,
      vrno          as Vrno,
      vbeln         as Vbeln,
      prod          as Prod,
      project       as Project,
      projectname   as Projectname,
      sectmat       as Sectmat,
      unitwet       as Unitwet,
      purno         as Purno,
      delmark       as Delmark,
      status        as Status,
      gengt         as Gengt,
      filenameul    as Filenameul,
      attachmentsul as Attachmentsul,
      mimetypeul    as Mimetypeul,
      vrcuting      as Vrcuting,
      vrcutnam      as Vrcutnam,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon     as Createdon,
      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedon as Lastchangedon,
      _Item,
      _Item2,
      _Item3
}
