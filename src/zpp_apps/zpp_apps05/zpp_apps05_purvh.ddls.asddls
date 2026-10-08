@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help For PO No And Section , Unit wt'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true 

define view entity ZPP_APPS05_PURVH as select from ZPP_APPS05_PROV as bom
left outer join I_Product as PRC on PRC.Product = bom.BillOfMaterialComponent
left outer join I_ProductText as dec on dec.Product = bom.BillOfMaterialComponent and dec.Language = 'E'
left outer join ZPP_APPS05_IRV2 as pc on pc.Orderno = bom.ManufacturingOrder

{
//@EndUserText.label: 'Purchase Lot No.'
@Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
@EndUserText.label: 'Priority Po No'
   key bom.YY1_PriorityPONos_SDH as Pono,
@EndUserText.label: 'Section / Material '
@Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
   key bom.BillOfMaterialComponent as Material,
      @EndUserText.label: 'Section / Material Dec '
      dec.ProductName as Materialdec,
           @EndUserText.label: 'Unit Wt'
      cast(PRC.YY1_UNIT_WGT_PRD as abap.dec(15,3) ) as Unitwt,
    @EndUserText.label: 'No Of Marks No'
    count( distinct bom.Material   ) as COUN,
    @EndUserText.label: 'Planned Marks No'
    count( distinct pc.Matnr ) as plcot
    
    
 

    
} where bom.YY1_PriorityPONos_SDH is not initial 
 group by 
 bom.YY1_PriorityPONos_SDH,

    bom.BillOfMaterialComponent,
      
      dec.ProductName,
      
      PRC.YY1_UNIT_WGT_PRD 
 

