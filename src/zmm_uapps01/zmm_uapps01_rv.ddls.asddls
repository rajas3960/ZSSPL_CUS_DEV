@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mass Transfar Posting GI'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMM_UAPPS01_RV
  as select from zmm_uapps01_tb1
  composition [0..*] of ZMM_UAPPS01_IRV as _Item
{
  key uuid          as Uuid,
      documentdate  as Documentdate,
      postingdate   as Postingdate,
      docno         as Docno,
      hdrdesc       as Hdrdesc,
      status        as Status,
      itmcnt        as Itmcnt,
      mark          as Mark,
      attachment    as Attachment,
      mimetype      as Mimetype,
      filename      as Filename,
      goodsmomty    as Goodsmomty,
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
