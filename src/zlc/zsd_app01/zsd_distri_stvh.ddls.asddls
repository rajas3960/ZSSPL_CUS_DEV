@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help For Distribution Channel'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_DISTRI_STVH as select from I_DistributionChannel
{
@ObjectModel.text.association: '_Text'
    key DistributionChannel,
    
    /* Associations */
    _Text
}
