@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Batch Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_BATCH_DETAILS as select from I_Product as pd
left outer join I_MaterialStock_2 as mts on mts.Material = pd.Product
                                         and mts.Plant = '1040'
left outer join I_BatchWithPlant_2 as bwp on bwp.Material = mts.Material
                                          and bwp.Plant = mts.Plant
                                          and bwp.Batch = mts.Batch
{
    key pd.Product,
    key mts.Batch,
    sum(cast(mts.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 15, 3 ) ) ) as Totqty,
    bwp.BatchBySupplier as sbatch
}where (
         pd.ProductGroup = 'WIRE ROD'
      or pd.ProductGroup = 'SPR BLACK'
      or pd.ProductGroup = 'PCK BLACK'
      )
  and mts.Batch is not initial
group by
pd.Product,
mts.Batch,
bwp.BatchBySupplier
