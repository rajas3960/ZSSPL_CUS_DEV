@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operation View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_OPV as select from I_ManufacturingOrderOperation as MfO
left outer join I_WorkCenter as WR on WR.WorkCenterInternalID = MfO.WorkCenterInternalID
{
key MfO.MfgOrderInternalID,
key MfO.OrderOperationInternalID,
key WR.WorkCenterInternalID,
key WR.WorkCenterTypeCode,
WR.StandardTextInternalID,
MfO.ManufacturingOrder,
MfO.ManufacturingOrderSequence
//WR._StandardTextInternalID

    
}
