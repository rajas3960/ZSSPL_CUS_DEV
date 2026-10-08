@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Value help View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_PRODUCT_VH as select from I_ProductStdVH
{
    key Product,
    @UI.hidden: true
    ProductExternalID,
    @UI.hidden: true
    ProductGroup,
     @UI.hidden: true
    ProductType,
     @UI.hidden: true
    AuthorizationGroup,
     @UI.hidden: true
    /* Associations */
    _ProductGroup_2,
     @UI.hidden: true
    _ProductType,
     
    _Text
} where ProductType = 'HALB'
