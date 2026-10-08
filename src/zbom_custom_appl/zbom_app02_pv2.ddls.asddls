@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP02_PV2
 provider contract transactional_query 
 as projection on ZBOM_APP02_RV
{
     key Suid,
     @EndUserText.label: 'Attachments'
     @Semantics.largeObject:{fileName: 'Filename' ,
     acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
      
      
                                 }                         
    Attachment,
         @UI.identification: [
    { position: 12, value: 'errorcount' }
  ]
    errorcount           as errorcount,
//    AttachmentItem,
        @Semantics.mimeType: true
    Minetype,
    Filename,
    Status,
    @Semantics.user.createdBy: true
    Createdby,
     @Semantics.systemDateTime.createdAt: true
    Createdon,
   _ITEM : redirected to composition child  ZBOM_APP02_IPV
//   _HRD : redirected to composition child ZBOM_APP02_HPV2
}






