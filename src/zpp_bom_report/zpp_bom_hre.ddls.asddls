@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Root View Of Bill of Material'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define root view entity ZPP_BOM_HRE as select from zpp_bom_htb 
association[1..1] to zpp_bom_from as form on form.bomnum = $projection.Bomnumber
association[1..1] to I_MaterialBOMLink as Mbom  on  Mbom.Material = $projection.Projectno
association[1..1] to I_ProductDescription as _PRD on _PRD.Product = $projection.Projectno and _PRD.Language = 'E'
association[1..1] to I_ProductDescription as _PRD1 on _PRD1.Product = $projection.Towertype and _PRD1.Language = 'E'
association[1..1] to I_ProductDescription as _PRD2 on _PRD2.Product = $projection.Structure and _PRD2.Language = 'E'
association[1..1] to ZPP_DESC as desc on desc.Material = $projection.Projectno
//association[1..1] to ZPP_DESC as desc1 on desc1.Material = $projection.Structure
composition [0..*] of ZPP_BOM_IRE as _item 
composition [0..*] of ZPP_BOM_IRV1 as _item1
{
    key uuid as Uuid,
    bomnum as Bomnumber,
    projectno as Projectno,
    _PRD.ProductDescription as Purchaser,
    desc.BOMAlternativeText as Refdocno,
    desc.BOMHeaderText as Projectname,
     drawingno as Drawingno,
    bomno as Bomno,
    towertype as Towertype,
    _PRD1.ProductDescription as towertypedesc,
    structure as Structure,
    _PRD2.ProductDescription as structuredesc,
    Mbom.BillOfMaterialVariant as BOMVERSION,
    form.attachment as Attachment,
    form.mimetype as Mimetype,
    form.filename as Filename,
    bomdat as Bomdate,
    createdby as Createdby,
    createdon as Createdon,
    _item,
    _item1
}
