@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CR & CI VIEW ENTITY'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS07_RRV01 as select from zpp_apps05_itb6 as ITM 
  inner join zpp_apps05_itb7 as CITM on CITM.uuid = ITM.uuid and CITM.srcid =  ITM.srcid and CITM.vrno = ITM.vrno
  left outer join I_ProductionOrderComponent as COM on COM.ProductionOrder = CITM.orderno
  left outer join I_ManufacturingOrderItem as MOI on MOI.ManufacturingOrder = CITM.orderno
  left outer join zpp_apps05_itb2 as ITB on ITB.uuid = ITM.uuid and ITB.orderno = CITM.orderno 
{
   key ITM.vrno      as Vrno,
  key ITM.srcid       as Sno,
  key CITM.parid      as Pardtm,
      ITM.uuid      as Uuid,
      CITM.orderno   as Orderno,

      ITM.plant     as Plant,
      CITM.marno     as Matnr,
      COM.Material    as Maktx,
//      @Semantics.quantity.unitOfMeasure: 'uom'
      CITM.pcs    as Plnqty,
//      @Semantics.quantity.unitOfMeasure: 'uom'
      CITM.pcs    as Reqty,
      'KG'   as Uom,
      MOI.SalesOrder     as Vbeln,
      CITM.length    as Length,
      ITB.width    as Width,
     ITB.wetpc     as Wetpc,
      cast(CITM.totqty as abap.dec(15,3) )   as Netwt,
      ITB.jobsht    as Jobsht,
      ITB.operation as Operation,
      COM.Reservation     as Resv,
      COM.ReservationItem,
      MOI.SalesOrderItem,
      ITM.srclent 
} 
union all  select from ZPP_APPS05_IRV2 as IMT
  left outer join I_ProductionOrderComponent as COM on COM.ProductionOrder = IMT.Orderno
  left outer join I_ManufacturingOrderItem as MOI on MOI.ManufacturingOrder = IMT.Orderno
 {

key IMT.Vrno as Vrno,
key IMT.Sno as Sno,
key cast(' ' as abap.numc( 5 )) as Pardtm,
 IMT.Uuid as Uuid,

IMT.Orderno as Orderno,

IMT.Plant as Plant,
IMT.Matnr as Matnr,
COM.Material as Maktx,
IMT.Plnqty as Plnqty,
IMT.Reqty as Reqty,
'KG' as Uom,
IMT.Vbeln as Vbeln,
IMT.Length as Length,
IMT.Width as Width,
IMT.Wetpc as Wetpc,
IMT.Netwt as Netwt,
IMT.Jobsht as Jobsht,
IMT.Operation as Operation,
IMT.Resv as Resv,
COM.ReservationItem,
MOI.SalesOrderItem,
cast( 0 as abap.dec( 15, 3 )) as srclent

} where IMT._hdr.Vrcuting = 'CR'

