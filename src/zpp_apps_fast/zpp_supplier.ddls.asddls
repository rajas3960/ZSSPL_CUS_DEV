@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Supplier Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_supplier
  as select from    I_Product          as pd
    left outer join I_BatchWithPlant_2 as mat on  mat.Material = pd.Product
                                              and mat.Plant    = '1040'
    left outer join I_Supplier         as sup on sup.Supplier = mat.Supplier
{
  key pd.Product,
  key mat.Supplier,
  key mat.Batch,
  key mat.BatchBySupplier,
      sup.SupplierName

}
where
     pd.ProductGroup = 'WIRE ROD'
  or pd.ProductGroup = 'SPR BLACK'
  or pd.ProductGroup = 'PCK BLACK'
