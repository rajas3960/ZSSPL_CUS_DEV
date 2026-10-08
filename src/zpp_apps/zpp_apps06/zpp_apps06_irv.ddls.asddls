@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Production Orders - Item Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS06_IRV as select from zpp_apps05_itb2 as ITM
left outer join I_ManufacturingOrderItem as _moi on _moi.ManufacturingOrder = ITM.orderno
association to parent ZPP_APPS06_RE as _hdr on _hdr.Vrno = $projection.Vrno
{
    key ITM.vrno as Vrno,
    key ITM.sno as Sno,
     ITM.uuid as Uuid,
    ITM.orderno as Orderno,
    ITM.plant as Plant,
    ITM.matnr as Matnr,
    ITM.maktx as Maktx,
    @Semantics.quantity.unitOfMeasure: 'uom'
    ITM.plnqty as Plnqty,
     @Semantics.quantity.unitOfMeasure: 'uom'
    ITM.reqty as Reqty,
    ITM.uom as Uom,
    ITM.vbeln as Vbeln,
    ITM.length as Length,
    ITM.width as Width,
    ITM.wetpc as Wetpc,
    ITM.netwt as Netwt,
    ITM.jobsht as Jobsht,
    ITM.operation as Operation,
    case when _moi.OrderIsReleased is not initial
    then 'Released'
    else 'Not Released' end as OrderIsReleased,
    case when _moi.OrderIsReleased is not initial
    then 3
    else 1 end as OrderIsReleasedc,
    _hdr
}
