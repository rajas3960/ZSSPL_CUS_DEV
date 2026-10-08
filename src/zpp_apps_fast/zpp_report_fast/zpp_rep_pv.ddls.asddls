@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Of MIS Report For 1040'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_REP_PV
  provider contract transactional_query
  as projection on ZPP_REP_RE
{
  key Jcnum,
  key Material,
  key Saleorder,
  key Productionorder,
      makts,
      batch,
      Plant,
      Supplier,
      SupplierName,
      grnno,
      @Semantics.quantity.unitOfMeasure: 'Uom'
      Totqty,
      Uom,
      remark,
      Createdby,
      Createdon,
      Matnr,
      Maktx,
      Pcs,
      @Semantics.quantity.unitOfMeasure: 'Meins'
      Menge,
      Meins,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Forging,
      ForgingWt,
      acc_forgingkg,
      acc_forgingpc,
      ConfirmationUnit,
      Forgingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Tapping,
      Tappingwt,
      Tappingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Galva,
      Galvawt,
      Galvadt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Heattreatment,
      htwt,
      Heattreatmentdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Drilling,
      Drillingwt,
      Drillingdt,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Eleplating,
      epwt,
      Eleplatingdt,
      baltoForging,
      balForgingWt,
      baltoTapping,
      baltoTappingwt,
      baltoGalva,
      baltoGalvawt,
      baltoHeattreatment,
      baltohtwt,
      baltoDrilling,
      baltoDrillingwz,
      balep,
      balepwt as balepwt
      
}
