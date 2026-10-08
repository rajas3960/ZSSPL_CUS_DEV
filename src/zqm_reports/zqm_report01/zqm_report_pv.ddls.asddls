@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of Project Wise section Summary'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZQM_REPORT_PV provider contract transactional_query as projection on ZQM_REPORT_RV
{
    key SalesDocument,
    key Project,
    key po,
//    key Structure,
    key Subtype,
    key BillOfMaterialComponent,
    ProductName,    
    Subtypedesc,
    PurchaseOrderByCustomer,
    CustomerPurchaseOrderDate,
    SalesDocumentItemText,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    RequestedQuantity,
    BaseUnit,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    bat_wt,
    sec_kg,
    totoal_planwt,
    Bal_PlanWt,
    prod_wt,
    Bal_Prodwt,
    Glava,
    Bal_galwt,
    Dispin_wt,
    Bal_dinwt,
    dispwt,
    item :redirected to composition child ZQM_REPORT_IPV
}
