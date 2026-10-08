@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Operation View Entity'
@Metadata.ignorePropagatedAnnotations: true
//@UI.presentationVariant: [{ sortOrder: [{ by: 'OperationStandardTextCode', direction: #ASC }] }]
define view entity ZPP_APPS01_OPERV as select from ZPP_APPS01_IRV02 as IRV
inner join I_ProductionOrderOperation_2 as MNU on MNU.ProductionOrder = IRV.Productionorder
inner join I_WorkCenter as wc on wc.WorkCenterInternalID = MNU.WorkCenterInternalID
{
   
   key IRV.Uuid,
   IRV.Matnr,
   IRV.batch,
//   MNU.ProductionOrder,
   MNU.ProductionOrderOperationText,
   MNU.Plant,
   MNU.ProductionOrderOperation,
//   MNU.WorkCenterInternalID,
//   MNU.WorkCenterType,
//   MNU.OperationControlProfile,
//   MNU.OperationConfirmation,
//   MNU.NumberOfOperationConfirmations,
//   MNU.FactoryCalendar,
   wc.WorkCenter
}
group by
IRV.Uuid,
MNU.ProductionOrderOperationText,
IRV.Matnr,
   IRV.batch,
   MNU.ProductionOrderOperation,
MNU.OperationStandardTextCode,
//MNU.WorkCenterInternalID,
   MNU.Plant,
wc.WorkCenter
