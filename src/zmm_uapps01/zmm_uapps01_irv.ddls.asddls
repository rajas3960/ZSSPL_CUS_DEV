@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mass Transfar Posting GI Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_UAPPS01_IRV
  as select from zmm_uapps01_tb2
  association to parent ZMM_UAPPS01_RV as _Header on $projection.Uuid = _Header.Uuid
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
      batch         as Batch,
      imaterial     as Imaterial,
      isloc         as Isloc,
      ibatch        as Ibatch,
      vbeln         as Vbeln,
      posnr         as Posnr,
      vbelnt        as Vbelnt,
      posnrt        as Posnrt,
      splc          as Splc,
      spls          as Spls,
      inst          as Inst,
      createdby     as Createdby,
      createdat     as Createdat,
      lastchangedby as Lastchangedby,
      lastchangedat as Lastchangedat,
      _Header
}
