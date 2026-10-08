@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mass Gm Post - Root Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMAT_DOC_RV
  as select from zmat_doc_grr
  composition [0..*] of ZMAT_DOC_IV1 as _Item
{
  key uuid          as Uuid,
      documentdate  as Documentdate,
      postingdate   as Postingdate,
      docno         as Docno,
      material      as Material,
      supplier      as Supplier,
      companycode   as CompanyCode,
      pono          as Pono,
      mdesc         as Mdesc,
      status        as Status,
      itmcnt        as Itmcnt,
      mark          as Mark,
      //      @EndUserText.label: 'Attachments'
      //      @Semantics.largeObject:{fileName: 'Filename',mimeType: 'Minetype',contentDispositionPreference: #INLINE}
      //      zattachment   as Zattachment,
      //      @Semantics.mimeType: true
      //      minetype      as Minetype,
      //      filename      as Filename,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat     as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat as Lastchangedat,
      _Item
}
