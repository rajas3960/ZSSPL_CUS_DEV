@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Update Projection View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSD_APP2_PRV provider contract transactional_query as projection on  ZSD_APP2_RV
{
    key SalesDocument,
    SoldToParty,
    SalesDocumentDate,
    PurchaseOrderByCustomer,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TotalNetAmount,
    TransactionCurrency,
    IncotermsClassification,
    FiscalYear,
    FiscalPeriod,
    YY1_LCNUMBER_1_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_5_SDHC'
    YY1_LCAMOUNT_5_SDH,
    YY1_LCAMOUNT_5_SDHC,
    YY1_LCNUMBER_4_SDH,
    YY1_LCNUMBER_8_SDH,
    YY1_LCNUMBER_5_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_1_SDHC'
    YY1_LCAMOUNT_1_SDH,
    YY1_LCAMOUNT_1_SDHC,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_4_SDHC'
    YY1_LCAMOUNT_4_SDH,
    YY1_LCAMOUNT_4_SDHC,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_7_SDHC'
    YY1_LCAMOUNT_7_SDH,
    YY1_LCAMOUNT_7_SDHC,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_6_SDHC'
    YY1_LCAMOUNT_6_SDH,
    YY1_LCAMOUNT_6_SDHC,
    YY1_LCNUMBER_7_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_10_SDHC'
    YY1_LCAMOUNT_10_SDH,
    YY1_LCAMOUNT_10_SDHC,
    YY1_LCNUMBER_3_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_2_SDHC'
    YY1_LCAMOUNT_2_SDH,
    YY1_LCAMOUNT_2_SDHC,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_3_SDHC'
    YY1_LCAMOUNT_3_SDH,
    YY1_LCAMOUNT_3_SDHC,
    YY1_LCNUMBER_10_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_8_SDHC'
    YY1_LCAMOUNT_8_SDH,
    YY1_LCAMOUNT_8_SDHC,
    YY1_LCNUMBER_2_SDH,
     @Semantics.amount.currencyCode: 'YY1_LCAMOUNT_9_SDHC'
    YY1_LCAMOUNT_9_SDH,
    YY1_LCAMOUNT_9_SDHC,
    YY1_LCNUMBER_9_SDH,
    YY1_LCNUMBER_6_SDH,
    CreatedByUser,
    CreationDate,
    LastChangedByUser,
    LastChangeDateTime,
    Mark,
    /* Associations */
    _SDI
}
