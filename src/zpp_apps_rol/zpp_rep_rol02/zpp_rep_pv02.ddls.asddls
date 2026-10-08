@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production report for 1010 and 1020 Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_REP_PV02
  provider contract transactional_query
  as projection on ZPP_REP_RV02
{
  key id,
  key purchaseorder,
  key prioritypo,
  key productionorder,
  key batch,
  key length,
  key pcs,
      postingdate,
      material,
      referenceid,
      plant,
      density,
      uom,
      lengthmtr,
      piece,
      @Semantics.quantity.unitOfMeasure: 'uom'
      quantity,
      storagelocation,
      asqty,
      @Semantics.quantity.unitOfMeasure: 'uom'
      orderquantity,
      @Semantics.quantity.unitOfMeasure: 'uom'
      billetquantity,
      noofbatches,
      @Semantics.quantity.unitOfMeasure: 'uom'
      heatquantity,
      @Semantics.quantity.unitOfMeasure: 'uom'
      totalpostquantity,
      shortqty,
      @Semantics.quantity.unitOfMeasure: 'uom'
      byproductquantity,
      yieldpercentage,
      @Semantics.quantity.unitOfMeasure: 'uom'
      rspqty,
      rsploc,
      @Semantics.quantity.unitOfMeasure: 'uom'
      wsqty,
      wsloc,
      //    Recplt,
      @Semantics.quantity.unitOfMeasure: 'buom'
      Qtybur,
      heatnumber,
      buom,
      Plannedorder
}
