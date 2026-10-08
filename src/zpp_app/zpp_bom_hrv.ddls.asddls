@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM root view of Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPP_BOM_HRV as select from zpp_bom_db
composition[0..*] of ZPP_BOM_IRV as _item
{
    key uuid as Uuid,
    cpno as Cpno,
    projectid as Projectid,
    bomnumber as Bomnumber,
    bomrevision as Bomrevision,
    bomdate as Bomdate,
    projectdesc as Projectdesc,
    clientname as Clientname,
    contractor as Contractor,
    manufacturer as Manufacturer,
    structure as Structure,
    refdrgno as Refdrgno,
    refno as Refno,
    createdby as Createdby,
    createdat as Createdat,
    lastchangedby as Lastchangedby,
    _item
}
