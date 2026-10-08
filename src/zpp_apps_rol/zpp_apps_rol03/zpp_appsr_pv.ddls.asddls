@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPSR_PV provider contract transactional_query as projection on ZPP_APPSR_RV
{
    key Uuid,
    Secmat,
    Plant,
    Frmdt,
    Todt,
    @Consumption.semanticObject: 'PlannedOrder'
    Plannedorder,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Totqty,
    Uom,
    Status,
    ManufacturingOrder,
    Createdby,
    Createdon,
     @Semantics.quantity.unitOfMeasure: 'Uom'
    unitwt,
    /* Associations */
    _itemselc : redirected to composition child ZPP_APPSR_IPV ,
    _itemseld  : redirected to composition child ZPP_APPSR_IPV2 
}
