@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View On Header level'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_PURREQ_HPV provider contract transactional_query as projection on ZMM_PURREQ_HRV
{
    key indentno,
    Header_dec,
    Req_type,
    LastChangeDateTime,
    dept,
    Costname,
    indentdate,
    IMAGES,
    /* Associations */
    _image,
    Name,
    Plant,
              @Semantics.largeObject:{
      mimeType: 'minetype',
      fileName: 'filename',
      contentDispositionPreference: #INLINE
      }
    attachment,
    minetype,
    filename,

    _item :  redirected to composition child zmm_purreq_ipv
 
}
