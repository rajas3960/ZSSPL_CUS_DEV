@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WIP Rep For Fastener'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_REP_RE
  as select from    ZPP_APPS01_RE      as hdr
    left outer join ZPP_APPS01_IRV02   as item on item.Uuid = hdr.Uuid
    left outer join ZPP_Ordercon_REP   as f    on  f.ProductionOrder              = item.Productionorder
                                               and f.ProductionOrderOperationText = 'Forging'
    left outer join ZPP_Ordercon_REP   as t    on  t.ProductionOrder              = item.Productionorder
                                               and t.ProductionOrderOperationText = 'Tapping'
    left outer join ZPP_Ordercon_REP   as G    on  G.ProductionOrder              = item.Productionorder
                                               and G.ProductionOrderOperationText = 'Galva'
    left outer join ZPP_Ordercon_REP   as H    on  H.ProductionOrder              = item.Productionorder
                                               and H.ProductionOrderOperationText = 'Heat Treatment'
    left outer join ZPP_Ordercon_REP   as D    on  D.ProductionOrder              = item.Productionorder
                                               and D.ProductionOrderOperationText = 'Drilling'
    left outer join ZPP_Ordercon_REP   as E    on  E.ProductionOrder              = item.Productionorder
                                               and E.ProductionOrderOperationText = 'Electro Plating'
    left outer join I_BatchWithPlant_2 as s    on  s.Material        = hdr.Material
                                               and s.Batch           = hdr.Batch
                                               and s.BatchBySupplier = hdr.grnno
                                               and s.Plant           = '1040'
    left outer join I_Supplier         as n    on n.Supplier = s.Supplier

{
  key hdr.Jcnum,
  key hdr.Material,
  key item.Saleorder,
  key item.Productionorder,
      hdr.makts,
      hdr.Batch                      as batch,
      hdr.Plant,
      s.Supplier,
      n.SupplierName,
      hdr.grnno,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      hdr.Totqty,
      hdr.Uom,
      hdr.remark,
      hdr.Createdby,
      hdr.Createdon,
      item.Matnr,
      item.Maktx,
      item.Pcs,
      @Semantics.quantity.unitOfMeasure: 'Meins'
      item.Menge,
      item.Meins,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      f.ConfYieldQtyInProductionUnit as Forging,
      f.Prod_weight                  as ForgingWt,
      case
      when item.Pcs > f.ConfYieldQtyInProductionUnit
        then cast( f.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoForging,
      case
      when item.Menge > f.Prod_weight 
       then cast( f.Balance_Wt as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as balForgingWt,
      case
      when item.Pcs < f.ConfYieldQtyInProductionUnit
        then cast( f.Balance_qty  as abap.dec(20,3) ) * -1
      else cast( 0 as abap.dec(20,0) )
      end                            as acc_forgingpc,
      case
      when item.Menge < f.Prod_weight 
       then cast( f.Balance_Wt as abap.dec(20,3) ) * -1
      else cast( 0 as abap.dec(20,0) )
      end                            as acc_forgingkg,
      //      f.Balance_Wt  * -1             as balForgingWt,
      f.ConfirmationUnit,
      f.ConfirmationEntryDate        as Forgingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      t.ConfYieldQtyInProductionUnit as Tapping,
      t.Prod_weight                  as Tappingwt,
             case
            when item.Pcs > t.ConfYieldQtyInProductionUnit
              then  t.Balance_qty
            else cast( 0 as abap.dec(20,0) )
            end    as baltoTapping,
      //      t.Balance_qty * -1             as baltoTapping,
      case
      when item.Menge > t.Prod_weight
        then cast( t.Balance_Wt  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoTappingwt,
      //      t.Balance_Wt  * -1             as baltoTappingwt,
      t.ConfirmationEntryDate        as Tappingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      G.ConfYieldQtyInProductionUnit as Galva,
      G.Prod_weight                  as Galvawt,
      case
      when item.Pcs > G.ConfYieldQtyInProductionUnit
       then cast( G.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoGalva,
      //      G.Balance_qty * -1             as baltoGalva,
      case
      when item.Menge > G.Prod_weight
        then cast( G.Balance_Wt  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoGalvawt,
      //      G.Balance_Wt  * -1             as baltoGalvawt,
      G.ConfirmationEntryDate        as Galvadt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      H.ConfYieldQtyInProductionUnit as Heattreatment,
      H.Prod_weight                  as htwt,
      case
      when item.Pcs > H.ConfYieldQtyInProductionUnit
       then cast( H.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoHeattreatment,
      //      H.Balance_qty * -1             as baltoHeattreatment,
      case
      when item.Menge > H.Prod_weight
        then cast( H.Balance_Wt  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltohtwt,
      //      H.Balance_Wt  * -1             as baltohtwt,
      H.ConfirmationEntryDate        as Heattreatmentdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      D.ConfYieldQtyInProductionUnit as Drilling,
      D.Prod_weight                  as Drillingwt,
      case
      when item.Pcs > D.ConfYieldQtyInProductionUnit
        then cast( D.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoDrilling,
      //      D.Balance_qty * -1             as baltoDrilling,
      case
      when item.Menge > D.Prod_weight
        then cast( D.Balance_Wt  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as baltoDrillingwz,
      //      D.Balance_Wt  * -1             as baltoDrillingwz,
      D.ConfirmationEntryDate        as Drillingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      E.ConfYieldQtyInProductionUnit as Eleplating,
      E.Prod_weight                  as epwt,
      case
      when item.Pcs > E.ConfYieldQtyInProductionUnit
        then cast( E.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as balep,
      //      E.Balance_qty * -1             as balep,
      case
      when item.Menge > E.Prod_weight
        then cast( E.Balance_qty  as abap.dec(20,3) )
      else cast( 0 as abap.dec(20,0) )
      end                            as balepwt,
      //      E.Balance_Wt  * -1             as balepwt,
      E.ConfirmationEntryDate        as Eleplatingdt
      
}
where
  hdr.checkstatus = 'X'
