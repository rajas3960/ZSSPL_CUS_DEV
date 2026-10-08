@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line item- Child Entity1'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZMAT_DOC_IV1
  as select from zmat_doc_gr association to parent ZMAT_DOC_RV as _Header on $projection.Uuid = _Header.Uuid
{
  key uuid          as Uuid,
  key itemno        as Itemno,
      gmtype        as Gmtype,
      matdoc        as Matdoc,
      material      as Material,
      mdesc         as Mdesc,
      plant         as Plant,
      sloc          as Sloc,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      matqty        as Matqty,
      uom           as Uom,
      rate          as Rate,
      costcenter    as Costcenter,
      glaccount     as Glaccount,
      spsfqty       as Spsfqty,
      hdrdesc       as Hdrdesc,
      mark          as Mark,
      @Semantics.user.createdBy: true
      createdby     as Createdby,
      @Semantics.systemDateTime.createdAt: true
      createdat     as Createdat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      @Semantics.systemDateTime.lastChangedAt: true
      lastchangedat as Lastchangedat,
      _Header
}
