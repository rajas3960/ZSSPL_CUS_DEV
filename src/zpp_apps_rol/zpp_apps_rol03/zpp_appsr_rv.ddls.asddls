@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Planning Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPSR_RV as select from zpp_appsr_htb as _hdr
left outer join I_PlannedOrder as Pln on Pln.PlannedOrder = _hdr.plannedorder
left outer join ZPP_APPS_MANU as ord on ord.PlannedOrder = _hdr.plannedorder 
left outer join I_Product as PR on PR.Product = _hdr.secmat
composition[1..*] of ZPP_APPSR_IRV as _itemselc
composition[1..*] of ZPP_APPSR_IRV2 as _itemseld
{
    key _hdr.uuid as Uuid,
    _hdr.secmat as Secmat,
    _hdr.plant as Plant,
    _hdr.frmdt as Frmdt,
    _hdr.todt as Todt,
    _hdr.plannedorder as Plannedorder,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    _hdr.totqty as Totqty,
    _hdr.uom as Uom,
    case
    when Pln.PlannedOrder is not null 
         or ord.PlannedOrder is not null
    then 'C'
    else 'D'
end as Status,
ord.ManufacturingOrder,
 @Semantics.user.createdBy: true
    _hdr.createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    _hdr.createdon as Createdon,
    @Semantics.quantity.unitOfMeasure: 'uom'
    PR.YY1_UNIT_WGT_PRD as unitwt,
 
    _itemselc,
    _itemseld
    
}
