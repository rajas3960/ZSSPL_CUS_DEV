@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Report - Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZMM_RP02_PV provider contract transactional_query as projection on ZMM_RP02_RV
{
@Consumption.semanticObject: 'PurchaseOrder'
    key PurchaseOrder,
    key PurchaseOrderItem,
    key MaterialDocument,
    key MaterialDocumentItem,
    key MaterialDocumentYear,
    key AccountingDocument,
    key TaxItemGroup,
    key ServiceEntrySheet,
    key ServiceEntrySheetItem,
    key AccountAssignmentNumber,
    key MasterFixedAsset,
    key FixedAsset,
    FiscalYear,
    OriginalReferenceDocument,
    PurchaseOrderDate,
    DocumentDate,
    PostingDate,
    PurchaseOrderType,
    PurchasingGroup,
    hsnno,
    MaterialType,
    GLCode,
    GLDescription,
    MaterialGroup,
    BaseUnit,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    OrderQuantity,
    Plant,
    @Semantics.amount.currencyCode: 'DocumentCurrency'
    Rate,
    RateInr,
    SUPPLIER,
    SupplierName,
    DocumentCurrency,
    GoodsReceiptType,
    StorageLocation,
    MaterialBaseUnit,
    EntryUnit,
    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    GRNQuantity,
    DebitCreditCode,
    CompanyCodeCurrency,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    AmountInCompanyCodeCurrency,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    CGST_C,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    SGST_C,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    IGST_C,
    DocumentReferenceID,
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    Extravalue,
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    grossvalue,
    AccountingDocumentType,
    Invoicedate,
    taxcode,
    TaxCodeName,
    GoodsMovementIsCancelled,
    PurchaseOrderItemText,
FixedAssetDescription,
FixedAssetExternalID,
 @ObjectModel.text.element: [ 'Assetdec' ]
AssetAdditionalDescription,
 Assetdec,
  MasterFixedAsset1,
PostingDate1,
accuoun1,
Grnpostingdate
 
}
