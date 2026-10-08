@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Billet Production - 261'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_BILLET_261

  as projection on ZR_BILLET_261
{
  key id,
  key item,
      @EndUserText.label: 'Reference ID'
      referenceid,
      @EndUserText.label: 'Batch Number'
      heatnumber,      
      @EndUserText.label: 'Material'
      material,
      @EndUserText.label: 'Material Description'
      materialdescription,
      @EndUserText.label: 'Plant'
      plant,
      @EndUserText.label: 'Batch'
      batch,
      @EndUserText.label: 'Quantity'
      @Semantics.quantity.unitOfMeasure: 'uom'
      quantity,
      @Semantics.quantity.unitOfMeasure : 'Uom'
      @EndUserText.label: 'Act. Quantity'
      quantitys, 
       @Semantics.quantity.unitOfMeasure : 'Uom'
      @EndUserText.label: 'Qty Burn'
      @UI.hidden: true
      Qtybur,  
      @EndUserText.label: 'UoM'
      uom,
      @EndUserText.label: 'Storage Location'
      storagelocation,
      @UI.hidden: true
        @EndUserText.label: 'Reservation No'
        rsnum,
        @UI.hidden: true
        @EndUserText.label: 'Reservation Item'
        rspos,
      /* Associations */
      _Head : redirected to parent ZC_BILLET_HDR
}
