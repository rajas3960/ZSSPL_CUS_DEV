@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FOR Data Group by'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_SUP_GRP as select from  I_SuplrInvcItemPurOrdRefAPI01

{

    key SupplierInvoice,
    key FiscalYear,
    
    PurchaseOrder,
    PurchaseOrderItem,
    Plant,
    SupplierInvoiceItemText,
    PurchaseOrderItemMaterial,
    PurchaseOrderQuantityUnit,

    ReferenceDocument,
    ReferenceDocumentFiscalYear,
    ReferenceDocumentItem,
    DebitCreditCode,
    FreightSupplier,
    IsNotCashDiscountLiable,
    SuplrInvcItemHasPriceVariance,
    SuplrInvcItemHasQtyVariance,
    SuplrInvcItemHasDateVariance,
    SuplrInvcItemHasOrdPrcQtyVarc,
    SuplrInvcItemHasOtherVariance,
    SuplrInvcItemHasAmountOutsdTol,
    SuplrInvcItmHasQualityVariance,
    TaxCountry,
//    SuplrInvcItmUnplndDelivCost,
    IsFinallyInvoiced
}
group by 
     SupplierInvoice,
     FiscalYear,
    PurchaseOrder,
    PurchaseOrderItem,
    Plant,
    SupplierInvoiceItemText,
    PurchaseOrderItemMaterial,
    PurchaseOrderQuantityUnit,

    ReferenceDocument,
    ReferenceDocumentFiscalYear,
    ReferenceDocumentItem,
    DebitCreditCode,
    FreightSupplier,
    IsNotCashDiscountLiable,
    SuplrInvcItemHasPriceVariance,
    SuplrInvcItemHasQtyVariance,
    SuplrInvcItemHasDateVariance,
    SuplrInvcItemHasOrdPrcQtyVarc,
    SuplrInvcItemHasOtherVariance,
    SuplrInvcItemHasAmountOutsdTol,
    SuplrInvcItmHasQualityVariance,
    TaxCountry,
//    SuplrInvcItmUnplndDelivCost,
    IsFinallyInvoiced
