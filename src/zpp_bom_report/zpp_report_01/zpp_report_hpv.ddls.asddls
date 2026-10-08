@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_REPORT_Hpv provider contract transactional_query as projection on ZPP_REPORT_HRV
{
    key Material,
//    Structure,
    Desc_name,
    @Semantics.largeObject:{
      mimeType: 'Mimetype',
      fileName: 'Filename',
      contentDispositionPreference: #INLINE
      }
    Attachment,
    Mimetype,
    Filename,
    /* Associations */
    Item : redirected to composition child ZPP_REP_IPV01
}
