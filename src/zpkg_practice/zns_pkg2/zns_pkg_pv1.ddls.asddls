@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZNS_PKG_PV1'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZNS_PKG_PV1 provider contract transactional_query as projection on ZNS_PKG_RV1
{
    key Uuid,
     @EndUserText.label: 'Attachments'
      @Semantics.largeObject:{fileName: 'Filename' ,
      acceptableMimeTypes: [ 'application/vnd.ms-excel', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' ],
                                mimeType: 'Minetype',
                                contentDispositionPreference: #INLINE
                                 }
    Attachment,
        @Semantics.mimeType: true
    Minetype,
    Filename,
    @Semantics.user.createdBy: true
    Createdby,
      @Semantics.systemDateTime.createdAt: true
    Createdon,
    @Semantics.user.lastChangedBy: true
    Lastchangedby,
     @Semantics.systemDateTime.lastChangedAt: true
    Lastchangedon,
    Status,
    Decs,
    /* Associations */
    _item : redirected to composition child ZNS_PKG_IPV2
}
