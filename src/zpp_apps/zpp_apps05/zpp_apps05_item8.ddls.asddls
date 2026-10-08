@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Production Order Jobsheet - Summary View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS05_ITEM8 as select from zpp_apps05_itb8 as hd
left outer join I_MaterialDocumentItem_2 as moi on moi.MaterialDocument = substring(hd.matnoitno,1,10) and moi.MaterialDocumentItem = substring(hd.matnoitno,11,14)
{
    key hd.vrno as Vrno,
    key hd.sno as Sno,
    hd.uuid as Uuid,
    hd.length as Length,
    hd.width as width,
    hd.apcs as Apcs,
    hd.used as Used,
    hd.rqty as Rqty,
    hd.uqty as Uqty,
    hd.wasper as Wasper,
    hd.rtrn as Rtrn,
    hd.netwst as Netwst,
    hd.quanwt as Quanwt,
    hd.irno as Irno,
    hd.matnr as Matnr,
    hd.batch as Batch,
    hd.plant as Plant,
    hd.storagelocation as Storagelocation,
    moi.YY1_EmbossingNumber_MMI as Embosing
}
