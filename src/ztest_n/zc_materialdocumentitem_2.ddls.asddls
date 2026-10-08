@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZC_MATERIALDOCUMENTITEM_2
  as select from I_ProductVH_2
{
 key Product,
  ProductDescription
}
