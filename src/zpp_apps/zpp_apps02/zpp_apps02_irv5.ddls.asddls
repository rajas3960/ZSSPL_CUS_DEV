@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Jobsheet Creation Application - Item V Stocks - vf'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZPP_APPS02_IRV5 as select from zpp_apps02_itb5
association to parent ZPP_APPS02_RV as _hdr on _hdr.Uuid = $projection.Uuid
{

key uuid as Uuid,
key mblnr as Mblnr,
key yea as Yea,
key item as Item,
length as Length,
grade as Grade,
project as Project,
irno as Irno,
balaqty as Balaqty,
balqty as Balqty,
remarks as Remarks,
_hdr
}
