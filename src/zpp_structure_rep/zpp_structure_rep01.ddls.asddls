@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Structure Report Of BOM Summary'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPP_STRUCTURE_REP01
  as select from ZRV_REP
{
  key Material,
      BillOfMaterial,

      cast(
      sum( TOTALWEIGHT )
      as abap.dec(15,3)
      ) as Total_weight
}
group by
  Material,
  BillOfMaterial
