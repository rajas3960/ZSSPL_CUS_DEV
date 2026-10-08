@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view of BOM Screen Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_BOM_HPV provider contract transactional_query as projection on ZPP_BOM_HRV
{
    key Uuid,
    Cpno,
    Projectid,
    Bomnumber,
    Bomrevision,
    Bomdate,
    Projectdesc,
    Clientname,
    Contractor,
    Manufacturer,
    Structure,
    Refdrgno,
    Refno,
    @Semantics.user.createdBy: true
    Createdby,
    @Semantics.systemDateTime.createdAt: true
    Createdat,
    @Semantics.user.lastChangedBy: true
    Lastchangedby,
    /* Associations */
    _item : redirected to composition child ZPP_BOM_IPV
}
