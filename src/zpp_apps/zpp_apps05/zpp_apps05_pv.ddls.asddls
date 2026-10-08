@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_APPS05_PV
  provider contract transactional_query
  as projection on ZPP_APPS05_RV
{
  key Uuid,
      Werks,
      Vrno,
      Vbeln,
      Prod,
      @ObjectModel.text.element: [ 'Projectname' ]
      Project,
      Projectname,
      Sectmat,
      Unitwet,
      Purno,
      Delmark,
      Status,
      Statusr,
      Statusgi,
      Statusgr,
      Relusr,
      Pgiusr,
      Pgrusr,
      Gengt,
      Vrcuting,
      Totlentq,
      Totwithst,
      Totwithmk,
      @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
      Attachment,
      Filename,
      Mimetype,
      Chckmrk,
      Plndt,
      Contr,
      Contrname,
      Matno,
      Remark,
      @Semantics.user.createdBy: true
      Createdby,
      @Semantics.systemDateTime.createdAt: true
      Createdon,
      @Semantics.user.localInstanceLastChangedBy: true
      Lastchangedby,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Lastchangedon,
      @EndUserText.label: 'Used Quantity'
      qty,
      @EndUserText.label: 'Waste Quantity'
      waste,

      /* Associations */
      _itemgtmark  : redirected to composition child ZPP_APPS05_IPV1,
      _itemftmark  : redirected to composition child ZPP_APPS05_IPV2,
      _itemgtlet   : redirected to composition child ZPP_APPS05_IPV3,
      _itemgtstock : redirected to composition child ZPP_APPS05_IPV4,
      _itemftstock : redirected to composition child ZPP_APPS05_IPV5,
      _itemrsult   : redirected to composition child ZPP_APPS05_IPV6,
      _itemsumry   : redirected to composition child ZPP_APPS05_IPV8,
      _text





}
