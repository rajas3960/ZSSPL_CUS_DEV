@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mass Transfar Posting GI Item Projection Entity'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZMM_UAPPS01_IPV
  as projection on ZMM_UAPPS01_IRV
{
  key Uuid,
  key Itemno,
      Gmtype,
      Matdoc,
      Material,
      Mdesc,
      Plant,
      Sloc,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Matqty,
      Uom,
      Rate,
      Costcenter,
      Glaccount,
      Spsfqty,
      Hdrdesc,
      Mark,
      Batch,
      Imaterial,
      Isloc,
      Ibatch,
      Vbeln,
      Posnr,
      Vbelnt,
      Posnrt,
      Splc,
      Spls,
      Inst,
      Createdby,
      Createdat,
      Lastchangedby,
      Lastchangedat,
      /* Associations */
      _Header : redirected to parent ZMM_UAPPS01_PV
}
