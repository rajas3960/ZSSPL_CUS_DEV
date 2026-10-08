@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TAX CODE PV'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZTAXCODE_PJV provider contract transactional_query
as projection on ZTAX_CODE
{
    key Taxcode,
    CGSTPercent,
    SGSTPercent,
    IGSTPercent,
    Description
    
}
