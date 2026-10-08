@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for Sales Organization'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_SALESORGN_STVH as select from I_SalesOrganization
{
@ObjectModel.text.association: '_Text'
    key SalesOrganization,
    _Text
}
