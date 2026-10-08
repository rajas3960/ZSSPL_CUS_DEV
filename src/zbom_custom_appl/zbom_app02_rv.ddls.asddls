@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Root View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZBOM_APP02_RV as select from zbom_app02_htb1
//composition[0..*] of ZBOM_APP02_RV2 as _HRD
composition[0..*] of ZBOM_APP02_IRV as _ITEM

{
    key suid             as Suid,
     @EndUserText.label: 'Attachments'
      @Semantics.largeObject:{fileName: 'Filename' ,
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
                                } 
                                                    
    attachment           as Attachment,
         @UI.identification: [
    { position: 12, value: 'errorcount' }
  ]
    errorcount           as errorcount,
    @Semantics.mimeType: true
    minetype             as Minetype,
    filename             as Filename,
    status               as Status,
    @Semantics.user.createdBy: true
    createdby            as Createdby,
    @Semantics.systemDateTime.createdAt: true
    createdon            as Createdon,
   _ITEM
//   _HRD
     
}





