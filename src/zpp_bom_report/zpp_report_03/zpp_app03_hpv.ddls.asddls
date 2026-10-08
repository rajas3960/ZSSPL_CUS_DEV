@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document PV'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APP03_Hpv provider contract transactional_query as projection on ZPP_APP03_HRE
{
    key Uuid,
    key Matnr,
    reldocs,
    Maktx,
    Reldocno,
    Project,
    Contractor,
    Realeasdt,
    Preparedby,
    @Semantics.user.createdBy: true
    Createby,
    @Semantics.systemDateTime.createdAt: true
    Createon,
    @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
    Attachment,
    Filename,
    Mimetype,
    /* Associations */
    item : redirected to composition child ZPP_APP03_IPV,
    item2 : redirected to composition child zpp_app03_ipv02
}
