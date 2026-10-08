@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Last Document'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_MAXDOC as select from  I_MaterialDocumentItem_2 as md
    inner join zmm_Maxdate as dt
       on md.Material     = dt.Material
      and md.PostingDate = dt.LastPostingDate
{
    key md.Material,
    max(md.MaterialDocument) as LastMaterialDocument
}
where md.GoodsMovementType = '101'
group by md.Material;
    
