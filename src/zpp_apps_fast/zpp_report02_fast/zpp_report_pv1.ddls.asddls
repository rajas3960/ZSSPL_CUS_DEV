@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of BALANCE TO PLAN'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_REPORT_PV1 provider contract transactional_query as projection on ZPP_REPORT_RV1
{
    key SalesOrder,
    key SalesOrderItem,
    key Product,
    ProductName,
    ProductGroup,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    PlannedTotalQtyInBaseUnit,
    BaseUnit,
    @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
    RequestedQuantity,
    RequestedQuantityUnit,
    bal_pcs,
    jcpc,
    jcqty,
    Plan_TotalQty,
    TotalPC
}
