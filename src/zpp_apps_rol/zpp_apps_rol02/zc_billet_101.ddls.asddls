@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billet Production - 101'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity  ZC_BILLET_101

  as projection on ZR_BILLET_101

{
  key id,
  key item,
      @EndUserText.label: 'Reference ID'
      referenceid,
      @EndUserText.label: 'Batch Number'
      heatnumber,
      @EndUserText.label: 'Material'
      material,
      @EndUserText.label: 'Plant'
      plant,
      @EndUserText.label: 'Actual Length(MM)'
      lengthmtr,
      @EndUserText.label: 'Batch'
      batch,
      @EndUserText.label: 'Actual Pieces'
      piece,
      @EndUserText.label: 'Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      quantity,
      @EndUserText.label: 'UoM'
      uom,
      @EndUserText.label: 'Storage Location'
      storagelocation,
      @UI.hidden: true
      productionorder,
      @EndUserText.label: 'Purchase Order'
//      @UI.hidden: true
      purchaseorder ,
//      @UI.hidden: true
 @EndUserText.label: 'Purchase Order Item'
      purchaseitm   ,
//  @UI.hidden: true
     @EndUserText.label: 'Priority Po No'
      prioritypo ,
        @EndUserText.label: 'Planned Length'
      length,
        @EndUserText.label: 'Planned Width'
      width,
        @EndUserText.label: 'Planned Pieces'
      pcs,
       @EndUserText.label: 'Remark'
      remark , 
      @EndUserText.label: 'Balance'
        balance,
          @EndUserText.label: 'Balance'
             balance1   , 
        @EndUserText.label: 'Check Box'
    checkbox,
      
      /* Associations */
      _Head : redirected to parent ZC_BILLET_HDR
}
