@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Details'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_apps01_matnr as select from zpp_batch_vh as hdr
left outer join I_MaterialDocumentItem_2 as matdocitem
on matdocitem.Material = hdr.matnr
and matdocitem.MaterialDocument = hdr.mat
and matdocitem.Batch = hdr.Batch
left outer join I_Supplier as sup
on sup.Supplier = matdocitem.Supplier
 
{
    key hdr.matnr,
    key hdr.mat,
    key matdocitem.Batch,
    @Semantics.quantity.unitOfMeasure: 'uom'
    hdr.Totqt,
    hdr.uom,
    matdocitem.Supplier,
    sup.SupplierName
}where matdocitem.GoodsMovementType = '105'
and matdocitem.IsCompletelyDelivered <> 'X'
group by
hdr.matnr,
hdr.mat,
matdocitem.Batch,
hdr.Totqt,
hdr.uom,
matdocitem.Supplier,
sup.SupplierName
