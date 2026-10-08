@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mass Transfar Posting GI Projection Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZMM_UAPPS01_PV provider contract transactional_query as projection on ZMM_UAPPS01_RV
{
    key Uuid,
    Documentdate,
    Postingdate,
    Docno,
    Hdrdesc,
    Status,
    Itmcnt,
    Mark,
     @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
      Attachment,
Filename,
Mimetype,
Goodsmomty,
    @Semantics.user.createdBy: true
      Createdby,
      @Semantics.systemDateTime.createdAt: true
      Createdat,
      @Semantics.user.lastChangedBy: true
      Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      Lastchangedat,
    /* Associations */
    _Item : redirected to composition child ZMM_UAPPS01_IPV
}
