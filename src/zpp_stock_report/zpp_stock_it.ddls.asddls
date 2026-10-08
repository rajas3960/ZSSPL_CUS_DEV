@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock 8'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_STOCK_IT as select from zpp_apps05_itb5 as hdr
//inner join zpp_apps05_itb4 as citm on citm.uuid = hdr.uuid 
inner join zpp_apps05_itb8 as itm on itm.matnr = hdr.product and itm.plant = hdr.plant and itm.storagelocation = hdr.storagelocation and itm.batch = hdr.batch
and itm.uuid = hdr.uuid and hdr.materialdoc = substring(itm.matnoitno,1,10) and   hdr.matdocitm = substring(itm.matnoitno,11,14)
{
  
   key hdr.materialdoc as Materialdoc,
   key hdr.matdocitm as Matdocitm,
   key hdr.purchaseorder as Purchaseorder,
   key hdr.purchaseorderitem as Purchaseorderitem,
   key hdr.product as Product,
   key hdr.plant as Plant,
   key hdr.storagelocation as Storagelocation,
   key hdr.batch as Batch,
   
//   key itm.sno as Sno,
   
//   hdr.length as Length,
//  key hdr.uuid as Uuid,
//   hdr.width as Width, 
  hdr.piecs as Piecs,
//   hdr.apiecs as Apiecs,
//   hdr.rpiecs as Rpiecs,
//   hdr.rquantity as Rquantity,
   hdr.quantity  as Quantity,
//   hdr.aquatity as Aquatity,
   hdr.pripono as Pripono,
   
//   hdr.irno as Irno,
//   hdr.supp as Supp,
    hdr.mark as Mark,
//   itm.vrno as Vrno,
   
   
//   itm.length as Length,
//   itm.width as Width,
//   itm.apcs as Apcs,
     sum(itm.used)  as Used,
//   itm.rqty as Rqty,
    sum(itm.uqty)  as Uqty
   
   
   //   itm.wasper as Wasper,
//   itm.rtrn as Rtrn,
//   itm.netwst as Netwst,
//   itm.quanwt as Quanwt,
//   itm.irno as Irno,
//   itm.matnr as Matnr,
//   itm.batch as Batch,
//   itm.plant as Plant,
//   itm.storagelocation as Storagelocation 
}where hdr.mark = 'X'
group by 
  hdr.materialdoc ,
    hdr.matdocitm ,
   hdr.purchaseorder ,
    hdr.purchaseorderitem ,
    hdr.product ,
    hdr.plant ,
    hdr.storagelocation ,
    hdr.batch ,
//    itm.sno,
//   hdr.length ,

//   hdr.Uuid ,
//   hdr.width as Width, 
  hdr.piecs ,
//   hdr.apiecs as Apiecs,
//   hdr.rpiecs as Rpiecs,
//   hdr.rquantity as Rquantity,
   hdr.quantity  ,
//   hdr.aquatity as Aquatity,
   hdr.pripono ,
   
//   hdr.irno as Irno,
//   hdr.supp as Supp,
    hdr.mark 
//   itm.vrno as Vrno,
   
   
//   itm.length as Length,
//   itm.width as Width,
//   itm.apcs as Apcs,
  
