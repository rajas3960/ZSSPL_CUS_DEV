@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order App Header Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define ROOT view entity ZPP_APP02_HPV provider contract transactional_query as projection on ZPP_APP02_HRV
{
    key Uuid,
    Mat,
    Plant,
    Salesno,
    Createdby,
    Createdon,
    /* Associations */
    _Item : redirected to composition child ZPP_APP02_IPV
}
