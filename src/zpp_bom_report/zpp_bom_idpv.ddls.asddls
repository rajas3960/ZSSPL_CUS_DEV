@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Item Data Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define view entity ZPP_BOM_IDPV as projection on  ZPP_BOM_IRE
{
    key Uuid,
    key Srno,
    bomnumber,
    Markno,
    Member,
    Markdesc,
    Length,
    Width,
    Unit,
    unitperpcs,
    Quantity,
    totalwt,
    Markshortno,
    Itemcreatedby,
    Itemcreatedat,
    Itemlastchangedby,
    /* Associations */
    _hdr :  redirected to parent ZPP_BOM_HDPV
}
