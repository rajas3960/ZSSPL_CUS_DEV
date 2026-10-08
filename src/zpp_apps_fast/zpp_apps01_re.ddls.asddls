@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'JOB CARD FOR FASTENERS'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZPP_APPS01_RE
  as select from zpp_apps01_tb as _hdr
//left outer join zpp_batch_vh as bat
// on bat.Batch = _hdr.batch
// and bat.matnr = _hdr.material   
// and bat.mat  = _hdr.grnno                        
association[1..1] to zpp_form_db as form
     on form.jcnum = $projection.Jcnum
    
association [1..1] to I_ProductText as pdt
    on pdt.Product = $projection.Material
    and pdt.Language = $session.system_language
    
composition [1..*] of ZPP_APPS01_IRV   as _item
composition [1..*] of ZPP_APPS01_IRV02 as _item1
composition [1..*] of ZPP_MATERIAL_RV  as _mat
composition [1..*] of ZPP_OPERATION_RV as _op

{
    key _hdr.uuid as Uuid,
    _hdr.machine as machine,

    _hdr.material as Material,
    pdt.ProductName   as makts,

    _hdr.plant as Plant,

    _hdr.plant_d as Plantdesc,

    _hdr.jcseries as Jcseries,

    _hdr.jcnum as Jcnum,

    _hdr.batch as Batch,
    _hdr.grnno as grnno,
    _hdr.checkstatus,
    _hdr.relstatus,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    _hdr.totqty as Totqty,

    _hdr.uom as Uom,
    _hdr.length as length,
    _hdr.supplier as supplier,
    _hdr.suppliername,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    _hdr.unitwt as Unitwt,
    _hdr.remark,
    _hdr.cdate,
    @Semantics.user.createdBy: true
    _hdr.createdby as Createdby,

    @Semantics.systemDateTime.createdAt: true
    _hdr.createdon as Createdon,
    form.attachment as Attachment,
    form.mimetype as Mimetype,
    form.filename as Filename,

    _item,
    _item1,
    _mat,
    _op
}
