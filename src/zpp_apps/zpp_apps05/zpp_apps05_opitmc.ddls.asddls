@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Operation View  Item Child Entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS05_OPITMC as select from zpp_apps05_itb2 as _hdr 
inner join I_ProductionOrderOperation_2 as _ord on _ord.ProductionOrder = _hdr.orderno
association to parent ZPP_APPS05_SUITEMV as _prt on _prt.Vrno = $projection.Vrno and _prt.Jobsht = $projection.Jobsht and _prt.Sno = $projection.Sno
{
key _hdr.vrno as Vrno,
key _hdr.jobsht as Jobsht,
key _hdr.sno as Sno,
key _ord.OrderInternalID,
key _ord.OrderOperationInternalID,
_ord.ProductionOrder,
_ord.ProductionOrderOperation,
_ord.WorkCenterInternalID,
_ord._WorkCenterText.WorkCenterText,
_ord.ProductionOrderOperationText,
concat_with_space(_ord.ProductionOrder,_ord.ProductionOrderOperation,2) as barcodetext,
_prt

  
} where _ord.WorkCenterInternalID = '10000090'
