@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Root Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZPP_APPS02_PV
  provider contract transactional_query
  as projection on ZPP_APPS02_RV
{
  key Uuid,
     @EndUserText.label: 'Vr Series'
      Vrcuting,
      Vrno,
      Vbeln,
      Prod,
      @EndUserText.label: 'Plant'
      Werks,
        @EndUserText.label: 'Project'
      Project,
       @EndUserText.label: 'Project Name'
      Projectname,
      
      Sectmat,
      Unitwet,
      Purno,
      //   @ObjectModel.text.element: [ 'Vrcutnam' ]
    
      Vrcutnam,
      @Semantics.user.createdBy: true
      Createdby,
      @Semantics.systemDateTime.createdAt: true
      Createdon,
      @Semantics.user.localInstanceLastChangedBy: true
      Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Lastchangedon,
      Delmark,
      Status,
      Gengt,
      Filenameul,
      Attachmentsul,
      Mimetypeul,
      /* Associations */
      _Item1 : redirected to composition child ZPP_APPS02_IPV,
      _Item2 : redirected to composition child ZPP_APPS02_IPV2,
      _lengt : redirected to composition child ZPP_APPS02_IPV3,
      _stock : redirected to composition child ZPP_APPS02_IPV4,
      _stocksec : redirected to composition child ZPP_APPS02_IPV5
}
