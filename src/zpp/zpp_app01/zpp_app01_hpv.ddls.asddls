@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Manage Production Order Application Header Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    
}
@Metadata.allowExtensions: true
define ROOT view entity ZPP_APP01_HPV provider contract transactional_query as projection on ZPP_APP01_HRV
{
    key Uuid,
    Plant,
    Mat,
    Salesno,
    Createdby,
    Createdon,
    /* Associations */
    _Mitem : redirected to composition child ZPP_APP01_IPV
}
