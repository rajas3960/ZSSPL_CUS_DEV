@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS01_RV
  as select from zpp_apps01_htb1
  composition [0..*] of ZPP_APPS01_IRV1 as _Item
  composition [0..*] of ZPP_APPS01_IRV3 as _Item2
{

  key uuid          as Uuid,
      werks         as Werks,
      jobsheetno    as Jobsheetno,
      jobdesc       as Jobdesc,
      vrno          as Vrno,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdon     as Createdon,
      @Semantics.user.localInstanceLastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedon as Lastchangedon,
      delmark       as Delmark,
      status        as Status,
      gengt         as Gengt,
           filenameul            as Filenameul,
      attachmentsul         as Attachmentsul,
      mimetypeul            as Mimetypeul,
      _Item,
      _Item2
}
