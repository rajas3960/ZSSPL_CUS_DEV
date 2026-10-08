@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Final Gr'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_MAXGR as select from I_MaterialDocumentItem_2 as md
    inner join zmm_Maxdate as dt
       on md.Material     = dt.Material
      and md.PostingDate = dt.LastPostingDate
    inner join ZMM_MAXDOC as dc
       on md.Material        = dc.Material
      and md.MaterialDocument = dc.LastMaterialDocument
{
    key md.Material,
    key md.MaterialDocument,
    key md.MaterialDocumentYear,
    key max(md.MaterialDocumentItem) as MaterialDocumentItem ,

    md.PostingDate,
    md.PurchaseOrder,
    max(md.PurchaseOrderItem) as PurchaseOrderItem,
    md.Supplier,
    md.CostCenter
}
where md.GoodsMovementType = '101'
group by
 md.Material,
     md.MaterialDocument,
     md.MaterialDocumentYear,
       md.PostingDate,
    md.PurchaseOrder,
     md.Supplier,
    md.CostCenter
