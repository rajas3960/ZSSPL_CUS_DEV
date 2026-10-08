@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planning And Optimizing app Projection Voew'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS03_PV provider contract transactional_query as projection on ZPP_APPS03_RV
{
    key Uuid,
    @EndUserText.label: 'Vr Series'
    Vrcuting,
    Werks,
    Vrno,
    Vbeln,
    
    Prod,
     @EndUserText.label: 'Project'
    Project,
     @EndUserText.label: 'Project Name'
    Projectname,
    Sectmat,
    Unitwet,
    Purno,
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
    
    Vrcutnam,
    Createdby,
    Createdon,
    Lastchangedby,
    Lastchangedon,
    /* Associations */
    _Item : redirected to composition child ZPP_APPS03_IPV,
    _Item2 : redirected to composition child ZPP_APPS03_IPV2,
    _Item3 : redirected to composition child ZPP_APPS03_IPV3
}
