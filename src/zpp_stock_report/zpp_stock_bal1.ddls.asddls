@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Balance from Jobsheet 1'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_STOCK_BAL1 as select from ZPP_STOCK_bal
{
    key Materialdoc,
    key Matdocitm,
    key Purchaseorder,
    key Purchaseorderitem,
    key Product,
    key Plant,
    key Storagelocation,
    key Batch,
    Piecs,
    Quantity,
    Pripono,
    Used,
    Uqty,
    balnce,
    QTYBLNE
}where QTYBLNE <> 0
