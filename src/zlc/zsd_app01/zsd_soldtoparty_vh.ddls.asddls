@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help For Customer'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_soldtoparty_vh as select from I_Customer
{
@ObjectModel.text.element: [ 'CustomerName' ]
    key Customer,
    CustomerName
  
}
