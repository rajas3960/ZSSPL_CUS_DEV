@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS02_RV
  as select from zpp_apps02_htb1
  composition [0..*] of ZPP_APPS02_IRV as _Item1
  composition [0..*] of ZPP_APPS02_IRV2 as _Item2
  composition [0..*] of ZPP_APPS02_IRV3 as _lengt
  composition [0..*] of ZPP_APPS02_IRV4 as _stock
  composition [0..*] of ZPP_APPS02_IRV5 as _stocksec
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
       vrcuting     as Vrcuting,
       vrcutnam     as Vrcutnam ,
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
      filenameul    as Filenameul,
      attachmentsul as Attachmentsul,
      mimetypeul    as Mimetypeul,
      _Item1,
      _Item2,
      _lengt,
      _stock,
      _stocksec
}
