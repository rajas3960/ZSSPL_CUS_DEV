@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billet Production - HTB'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BILLET_HTB

  as projection on ZR_BILLET_HTB
{
  key id,
  key item,
      @EndUserText.label: 'Reference ID'
      referenceid,
      @EndUserText.label: 'Batch Number'
      heatnumber,
      @EndUserText.label: 'Billet Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      heatquantity,
      @EndUserText.label: 'Section Quantity'
          @Semantics.quantity.unitOfMeasure: 'HUOM'
      billetquantity,
      @EndUserText.label: 'ByProduct Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      byproductquantity,
      @EndUserText.label: 'Balance Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      balancequantity,
      @EndUserText.label: 'Yield Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      yield,
     @EndUserText.label: 'UoM'
    @UI.hidden: true
      Uom,
          @UI.hidden: true
      HUOM,
      /* Associations */
      _Head : redirected to parent ZC_BILLET_HDR
}
