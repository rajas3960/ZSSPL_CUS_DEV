@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Service Entry Sheet View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_RP02_SERIN as select from I_ServiceEntrySheetItemAPI01
{
    key ServiceEntrySheet,
    key substring(ServiceEntrySheetItem,2,5) as ServiceEntrySheetItem,
    PurchaseOrder,
    PurchaseOrderItem,
    IsDeleted,
    Service,
    ServiceEntrySheetItemDesc,
    ServicePerformer,
    AccountAssignmentCategory,
    MultipleAcctAssgmtDistribution,
    WorkItem,
    @Semantics.quantity.unitOfMeasure: 'QuantityUnit'
    ConfirmedQuantity,
    QuantityUnit,
    ServicePerformanceDate,
    OriginObject,
    @Semantics.amount.currencyCode: 'Currency'
    NetAmount,
     @Semantics.amount.currencyCode: 'Currency'
    NetPriceAmount,
    Currency,
    PurgDocItemExternalReference,
    PurchaseContract,
    PurchaseContractItem,
    PurchasingOrganization,
    PurchasingGroup,
    Plant,
    IsEndOfPurposeBlocked,
    CreationDateTime,
    CreatedByUser,
    LastChangeDateTime,
    LastChangedByUser,
    /* Associations */
    _ServiceEntrySheet
}
