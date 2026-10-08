@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Asset Register Report Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_RP01_PV provider contract transactional_query as projection on ZMM_RP01_RV
{

    key PurchaseOrder,
    key PurchaseOrderItem,
    key AccountAssignmentNumber,
    key MaterialDocument,
    key MaterialDocumentItem,
    key MaterialDocumentYear,
    key AccountingDocument,
    @Consumption.semanticObject: 'FixedAsset'
    key MasterFixedAsset,
    key FixedAsset,
    key TaxItemGroup,
    PLANT,
    SupplierName,
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 AmountInCompanyCodeCurrency,
 CompanyCodeCurrency,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
   AmountInCompanyCodeCurrency2,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  AmountInCompanyCodeCurrency3,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  AmountInCompanyCodeCurrency4,
//    MasterFixedAsset,
   
 FixedAssetDescription,
 FixedAssetExternalID,
 @ObjectModel.text.element: [ 'Assetdec' ]
 AssetAdditionalDescription,
 @UI.hidden: true
 Assetdec,
DocumentReferenceID,
 PostingDate,
 PurchaseOrderDate,
 DocumentDate,
 assetno,
 ps
}
