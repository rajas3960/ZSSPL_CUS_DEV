@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Projection View Of BOM'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define root view entity ZPP_BOM_HDPV provider contract transactional_query as projection on ZPP_BOM_HRE
{
    key Uuid,
    Bomnumber,
    @EndUserText.label: 'PROJECT NO'
    Projectno,
    @EndUserText.label: 'PURCHASER'
    Purchaser,
    @EndUserText.label: 'REF.DOC.NO'
    Refdocno,
    @EndUserText.label: 'PROJECT NAME'
    Projectname,
    @EndUserText.label: 'DRAWING NO'
    Drawingno,
    @EndUserText.label: 'BOM NO'
    Bomno,
    @EndUserText.label: 'TOWER TYPE'
    Towertype,
    @EndUserText.label: 'TOWER TYPE DESC'
    towertypedesc,
    @EndUserText.label: 'STRUCTURE'
    Structure,
    @EndUserText.label: 'STRUCTURE DESC'
    structuredesc,
    @EndUserText.label: 'Alternative BOM'
    BOMVERSION,
    @EndUserText.label: 'BOM DATE'
    Bomdate,
    @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
      Attachment,
      Filename,
      Mimetype,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    /* Associations */
    _item : redirected to composition child ZPP_BOM_IDPV,
    _item1 : redirected to composition child ZPP_BOM_IPV1
}
