@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Value Help'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.dataCategory: #VALUE_HELP

@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZPP_MD_VH
  as select from I_Product as hdr
  left outer join ZPP_RP01_RV as main 
  on main.Material = hdr.Product
    left outer join ZPP_RP01_RV as sub
      on sub.Material = main.BillOfMaterialComponent
{
  key hdr.Product               as Projectno,

  key    sub.Material                as Towertype,

 key     sub.BillOfMaterialComponent as Structure
}//where hdr.ProductGroup = 'PROJ'

