@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item stock projection v'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_APPS02_IPV5  as projection on ZPP_APPS02_IRV5
{
key Uuid,
key Mblnr,
key Yea,
key Item,
Length,
Grade,
Project,
Irno,
Balaqty,
Balqty,
Remarks,
       /* Associations */
    _hdr : redirected to parent ZPP_APPS02_PV
}
