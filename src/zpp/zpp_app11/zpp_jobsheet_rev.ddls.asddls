@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet root entity view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zpp_jobsheet_REV as select from zpp_app03_itb2 as ITB2
 left outer join zpp_app03_tb1 as TB1 on TB1.jobshtnum = ITB2.jobsheet
// left outer join I_ManufacturingOrderStatusText as gis on gis.ManufacturingOrder = ITB2.orderno and gis.StatusCode =
 left outer join I_MfgOrderConfirmation as MOC on MOC.ManufacturingOrder =ITB2.orderno
//left outer join zpp_app09_itb2 as ITB9 on ITB9.jobshtnum = TB1.jobshtnum
                                      

{
    key ITB2.jobsheet as Jobnsheetno,
    key ITB2.orderno as Orderno,
    ITB2.matnr as MaterialSFG,
    ITB2.orderitem as Orderitemno,
    ITB2.resev as Reservationo,
    @Semantics.quantity.unitOfMeasure: 'uom'
    ITB2.plndqty as Plannedqty,
    @Semantics.quantity.unitOfMeasure: 'uom'
    ITB2.reqty as Requestedqty,
    ITB2.uom,
    TB1.status as Status,
    TB1.delmark as Deletionmark,
    @Semantics.user.createdBy: true
    TB1.createdby as Createdby,
    @Semantics.systemDateTime.createdAt: true
    TB1.createdon as Createdon,
    case when MOC.IsFinalConfirmation = 'X'
    then  'CNF' 
    when MOC.IsFinalConfirmation = ' ' then 'PCNF' else null end as ConfirmStatus
    
        
}
