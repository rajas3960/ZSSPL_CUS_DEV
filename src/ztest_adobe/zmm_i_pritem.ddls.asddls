@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Requisition Item'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZMM_I_PrItem as select from I_PurchaseRequisitionItemAPI01
  association to parent ZMM_I_PrHeader as _Header  on _Header.PurchaseRequisition = $projection.PurchaseRequisition
  association to I_Product             as _Product on _Product.Product = $projection.Material
{
  key PurchaseRequisition,
  key PurchaseRequisitionItem,
      Material,
      MaterialGroup,
      PurchasingDocumentCategory,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      RequestedQuantity,
      BaseUnit,
      Plant,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
      OrderedQuantity,
      CreationTime,
      Supplier,
      RequisitionerName,
      CreatedByUser,
      StorageLocation,

      /* Associations */
      _PurchaseRequisition,
      _PurReqnAcctAssgmt,
      _Product,
      _Header
}
