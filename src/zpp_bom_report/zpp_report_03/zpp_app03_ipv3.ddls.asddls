@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Release Document'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZPP_APP03_IPV3 provider contract transactional_query
  as projection on ZPP_APP03_IRV3
{
    key Material,
    key BillOfMaterialComponent
}
