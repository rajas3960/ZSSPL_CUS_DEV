@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPS01_PV01 provider contract transactional_query as projection on ZPP_APPS01_RE
{
    key Uuid,
    machine,
    Material,
    makts,
    Plant,
    Plantdesc,
    Jcseries,
    Jcnum,
    Batch,
    grnno,
    suppliername,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Totqty,
    Uom,
    length,
    checkstatus,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Unitwt,
    remark,
    Createdby,
    Createdon,
    @Semantics.largeObject:{
      mimeType: 'mimetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
      Attachment,
      Filename,
      Mimetype,
    /* Associations */
    _item : redirected to composition child ZPP_APPS01_IPV,
    _item1 : redirected to composition child ZPP_APPS01_Ipv02,
    _mat : redirected to composition child ZPP_MATERIAL_PV,
    _op  : redirected to composition child ZPP_OPERATION_PV
}
