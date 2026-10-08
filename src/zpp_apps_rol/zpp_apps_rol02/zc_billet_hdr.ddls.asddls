@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Section Production - Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_BILLET_HDR

  provider contract transactional_query

  as projection on ZR_BILLET_HDR
{
  key id,
      @EndUserText.label: 'Reference ID'
      referenceid,
      //      @EndUserText.label: 'Status Code'
      //      statuscode,
      //      @EndUserText.label: 'Status Desc.'
      //      statusdesc,
      @EndUserText.label: 'Production Order'
      productionorder,
      @EndUserText.label: 'Plant'
      plant,
      @EndUserText.label: 'Posting Date'
      postingdate,
      @EndUserText.label: 'Material'
      material,
      @EndUserText.label: 'Material Description'
      materialdesc,
      @EndUserText.label: 'Status'
      status,
      @EndUserText.label: 'Criticality'
      Criticality,
      @EndUserText.label: 'Progress'
      Progress,
      @EndUserText.label: 'Total'
      Total,
      @EndUserText.label: 'Planned Production Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      orderquantity,
      @Semantics.quantity.unitOfMeasure: 'uom'
      @EndUserText.label: 'Actual Produced Quantity'
      totalpostquantity,
      @EndUserText.label: 'Activity(Grid Power)'
      activity,
      @EndUserText.label: 'UoM'
      uom,
      @EndUserText.label: 'Caster'
      caster,
      @EndUserText.label: 'Width(M)'
      width,
      @EndUserText.label: 'Height(M)'
      height,
      @EndUserText.label: 'Density(KGV)'
      density,

      @EndUserText.label: 'Checked?'
      postcheck,
      @EndUserText.label: 'Posted Confirmation?'
      postcnf,
      @EndUserText.label: 'Posted GR?'
      post101,
      @EndUserText.label: 'Posted 261?'
      post261,
      @EndUserText.label: 'Posted 531?'
      post531,
      @EndUserText.label: 'No. of Billets Consumed'
      noofheats,
      @EndUserText.label: 'No. of Batches Produced'
      noofbatches,
      @EndUserText.label: 'Consumed Batches Fetched?'
      getcons,

      @EndUserText.label: 'Total Billet Quantity'
      @Semantics.quantity.unitOfMeasure: 'Uom'
      heatquantity,
      @EndUserText.label: 'Total Section Quantity'
      @Semantics.quantity.unitOfMeasure: 'Uom'
      billetquantity,
      @EndUserText.label: 'Total By-Product Quantity'
      @Semantics.quantity.unitOfMeasure: 'Uom'
      byproductquantity,
      @EndUserText.label: 'Balance Quantity'
      @Semantics.quantity.unitOfMeasure: 'Uom'
      balancequantity,
      @EndUserText.label: 'Yield%'
      yieldpercentage,
      @EndUserText.label: 'Dummy'
      dummy,
         @EndUserText.label: 'Short/Excess Quantity'
       shortqty ,

      /* Associations */
      _101 : redirected to composition child ZC_BILLET_101,
      _261 : redirected to composition child ZC_BILLET_261,
      _531 : redirected to composition child ZC_BILLET_531,
      _HTB : redirected to composition child ZC_BILLET_HTB
}
