@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Grouping'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS05_POLV as select from ZPP_APPS05_PROV as rv
    inner join zpp_apps05_itb2 as tb2
      on tb2.orderno = rv.ManufacturingOrder
     and tb2.matnr   = rv.Material

    left outer join zpp_apps05_itb as tb1
      on tb1.orderno = rv.ManufacturingOrder
     and tb1.matnr   = rv.Material

    left outer join zpp_apps01_htb1 as tb
      on tb.uuid = tb1.uuid
{
  key rv.ManufacturingOrder,
  key rv.Material,
      sum( cast(tb2.reqty as abap.dec(15,3)) ) as reqty
}
group by
  rv.ManufacturingOrder,
  rv.Material;
