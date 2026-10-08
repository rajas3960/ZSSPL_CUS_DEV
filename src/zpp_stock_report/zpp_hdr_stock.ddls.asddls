@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Header Stock'
@Metadata.ignorePropagatedAnnotations: true
define  view entity  zpp_hdr_stock as select distinct from  zpp_apps05_itb5 as hdr
inner join zpp_apps05_itb4 as itm on itm.uuid = hdr.uuid
{
    key itm.uuid as Uuid,
    key itm.sno as Sno,
//    key hdr.uuid as Uuid,
    key hdr.materialdoc as Materialdoc,
    key hdr.matdocitm as Matdocitm,
    key hdr.purchaseorder as Purchaseorder,
    key hdr.purchaseorderitem as Purchaseorderitem,
    key hdr.product as Product,
    key hdr.plant as Plant,
    key hdr.storagelocation as Storagelocation,
    key hdr.batch as Batch,
    itm.vrno as Vrno,
    itm.length as Length,
    itm.quantity as Quantity,
    itm.quanwt as Quanwt,
    itm.irno as Irno,
    itm.matnr as Matnr,
//    itm.batch as Batch,
//    itm.plant as Plant,
//    itm.storagelocation as Storagelocation,
//    hdr.length as Length,
//    hdr.width as Width,
    hdr.piecs as Piecs,
//    hdr.apiecs as Apiecs,
//    hdr.rpiecs as Rpiecs,
//    hdr.rquantity as Rquantity,
//    hdr.quantity as Quantity,
//    hdr.aquatity as Aquatity,
    hdr.pripono as Pripono,
//    hdr.irno as Irno,
//    hdr.supp as Supp,
    hdr.mark as Mark
}where hdr.mark = 'X'
group by
 itm.uuid ,
     itm.sno ,
//    key hdr.uuid as Uuid,
     hdr.materialdoc ,
     hdr.matdocitm ,
     hdr.purchaseorder ,
     hdr.purchaseorderitem ,
     hdr.product ,
     hdr.plant ,
     hdr.storagelocation ,
    hdr.batch ,
    itm.vrno ,
    itm.length ,
    itm.quantity ,
    itm.quanwt ,
    itm.irno ,
    itm.matnr ,
     hdr.piecs ,
     hdr.pripono,
      hdr.mark

