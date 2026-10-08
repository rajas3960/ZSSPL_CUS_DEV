@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS01_pv
  provider contract transactional_query
  as projection on ZPP_APPS01_RV
{
  key Uuid,
      Werks,
      Jobsheetno,
      @EndUserText.label: 'Remarks :'
      Jobdesc,
       Vrno,
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
        @Semantics.largeObject:{
          mimeType: 'MimetypeUl',
          fileName: 'FilenameUl',
          contentDispositionPreference: #INLINE
          }    
    Attachmentsul,
    Mimetypeul,
      /* Associations */
      _Item  : redirected to composition child ZPP_APPS01_iPV1,
      _Item2 : redirected to composition child ZPP_APPS01_IPV3
}
