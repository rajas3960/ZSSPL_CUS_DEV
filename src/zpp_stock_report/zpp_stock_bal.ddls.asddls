@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Balance from Jobsheet'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_STOCK_bal as select from ZPP_STOCK_IT
{
    key Materialdoc,
    key Matdocitm,
    key Purchaseorder,
    key Purchaseorderitem,
    key Product,
    key Plant,
    key Storagelocation,
    key Batch,
//    key Uuid,
//    key sno,
    Piecs,
    Quantity,
    Pripono,
    Used,
    Uqty,
    Piecs - Used as balnce,
    Quantity - Uqty as QTYBLNE,
    Mark
    
} 
