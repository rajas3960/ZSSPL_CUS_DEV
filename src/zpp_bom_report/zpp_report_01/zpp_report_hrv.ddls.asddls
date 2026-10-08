@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Head'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_REPORT_HRV
  as select from    I_Product   as _hdr
    left outer join I_ProductText as pt on pt.Product = _hdr.Product
  left outer join zpp_rep_tb as form on  form.material = _hdr.Product
//  left outer join I_Product as pd on pd.Product = _hdr.Material
//                                     and pd.ProductGroup = 'PROJ'
  composition [0..*] of ZPP_REP_IRV as Item

{
  key _hdr.Product as Material,
//      _hdr.BillOfMaterialComponent as Structure,
      pt.ProductName as Desc_name,
//      @Semantics.largeObject:{
//      mimeType: 'Mimetype',
//      fileName: 'Filename',
//      contentDispositionPreference: #INLINE
//      }
      form.attachment              as Attachment,
      form.mimetype                as Mimetype,
      form.filename                as Filename,
      Item

}where _hdr.ProductGroup = 'PROJ'
