@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order LC Utilization Item Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_APP02_IPV as projection on ZSD_APP02_IRV
{
    key Salesdocument,
    key Lcline,
    Lnum,
    @Semantics.amount.currencyCode: 'Lcurr'
    Lcamount,
    Lcurr,
    Mark,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdon,
    @Semantics.user.lastChangedBy: true
    Lastchangedbyuser,
    @Semantics.systemDateTime.lastChangedAt: true
    Lastchangedatetime,
    
    /* Associations */
    _SalesHeader : redirected to parent ZSD_APP02_HPV
}
