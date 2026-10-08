@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Planned Order View entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS03_PLDV as select from ZPP_APPS02_SE as rv
    inner join zpp_apps03_itb2 as tb2
      on tb2.orderno = rv.PlannedOrder
     and tb2.matnr   = rv.Material

    left outer join zpp_apps01_itb1 as tb1
      on tb1.orderno = rv.PlannedOrder
     and tb1.matnr   = rv.Material

    left outer join zpp_apps01_htb1 as tb
      on tb.uuid = tb1.uuid
{
  key rv.PlannedOrder,
  key rv.Material,
      sum( cast(tb2.reqty as abap.dec(15,3)) ) as reqty
}
group by
  rv.PlannedOrder,
  rv.Material;
