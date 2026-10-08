@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View Structure Report Of BOM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRV_REP
  as select from    ZPP_RP01_RV               as Bom
    left outer join I_Product                 as pd   on pd.Product = Bom.BillOfMaterialComponent
    left outer join I_BillOfMaterialItemBasic as Item on  Item.BillOfMaterialComponent = Bom.BillOfMaterialComponent
                                                      and Item.BillOfMaterial          = Bom.BOM
{
  key Bom.Material,
      Item.BillOfMaterial,
      Bom.BillOfMaterialComponent,
      @Semantics.quantity.unitOfMeasure: 'YY1_WGT_PC_PRDU'
      pd.YY1_WGT_PC_PRD,
      pd.YY1_WGT_PC_PRDU,
      @Semantics.quantity.unitOfMeasure: 'BOMUnit'
      Item.BillOfMaterialItemQuantity,
      Item.BillOfMaterialItemUnit as BOMUnit,
      cast( cast( Item.BillOfMaterialItemQuantity as abap.dec( 10, 3 ) ) * cast(pd.YY1_WGT_PC_PRD as abap.dec( 10, 3 ))
      as abap.dec( 15, 3 ) ) as  TOTALWEIGHT 
}
