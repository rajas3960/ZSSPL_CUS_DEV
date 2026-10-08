@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root_Projection_View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZMAT_DOC_RPV
  provider contract transactional_query
  as projection on ZMAT_DOC_RV
{
  key Uuid,
      Documentdate,
      Postingdate,
      Docno,
      @Consumption.valueHelpDefinition: [{ entity:{name: 'I_ProductVH_2', element: 'Product'},useForValidation: true}]
      Material,
      @Consumption.valueHelpDefinition: [{ entity:{name: 'I_Supplier', element: 'Supplier'},useForValidation: true}]
      Supplier,
      CompanyCode,
      Pono,
      Mdesc,
      Status,
      Itmcnt,
      Mark,
      //      @EndUserText.label: 'Attachments'
      //      @Semantics.largeObject:{fileName: 'Filename',mimeType: 'Minetype',contentDispositionPreference: #INLINE}
      //      Zattachment,
      //      @Semantics.mimeType: true
      //      Minetype,
      //      Filename,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _Item : redirected to composition child ZMAT_DOC_IPV1
}
