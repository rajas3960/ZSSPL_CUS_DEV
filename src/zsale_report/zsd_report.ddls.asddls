@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Report Root - BOM Summary'
@Metadata.ignorePropagatedAnnotations: true
@UI.presentationVariant: [{ sortOrder: [{by: 'MainItemPricingRefProduct' , direction: #ASC}] }]
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_REPORT
  as select from    I_SalesDocument     as _hd
    left outer join I_SalesDocumentItem as _item  on  _hd.SalesDocument              =  _item.SalesDocument
                                                  and ( _item.SalesDocumentItemCategory <> 'TAP'
                                                  or _item.SalesDocumentItemCategory <> 'KMB' )
                                                  
    left outer join I_Product           as PD     on PD.Product = _item.Material
    left outer join I_SalesDocumentItem as _item1 on  _item1.SalesDocument = _item.SalesDocument
                                                  and _item1.Material      = _item.MainItemPricingRefProduct
    left outer join I_ProductPlantBasic  as HSN on HSN.Product = _item1.Material
    
    left outer join I_SalesDocItemPricingElement as price on price.SalesDocument = _item.SalesDocument
                                                          and price.SalesDocumentItem = _item.SalesDocumentItem
                                                          and price.ConditionType = 'JOCG'
    
    left outer join I_SalesDocItemPricingElement as price1 on price1.SalesDocument = _item.SalesDocument
                                                          and price1.SalesDocumentItem = _item.SalesDocumentItem
                                                          and price1.ConditionType = 'JOSG'  
                                                          
     left outer join I_SalesDocItemPricingElement as price2 on price2.SalesDocument = _item.SalesDocument
                                                          and price2.SalesDocumentItem = _item.SalesDocumentItem
                                                          and price2.ConditionType = 'JOIG' 
                                                          
      left outer join I_SalesDocItemPricingElement as ZPR1 on ZPR1.SalesDocument = _item.SalesDocument
                                                          and ZPR1.SalesDocumentItem = _item.SalesDocumentItem
                                                          and ZPR1.ConditionType = 'ZPR1'
                                                              
                                                                                                 
  association to parent ZSD_REP_RV as _hdr on _hdr.SalesDocument = $projection.SalesDocument
  composition [0..*] of ZSD_REPORT_IRV2 as Item1

{
  key _hd.SalesDocument           as SalesDocument,
  key _item.BillOfMaterial         as BillOfMaterial,
  key _item.MainItemPricingRefProduct,
      _item1.SalesDocumentItemText,
      HSN.ConsumptionTaxCtrlCode,
      _item.TransactionCurrency    as TransactionCurrency,
      _item1.RequestedQuantityUnit as RequestedQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
      _item1.RequestedQuantity,
      price.ConditionRateRatio as CGSTRate,
      sum(cast(price.ConditionAmount as abap.dec( 15, 3 ))) as CGSTValue, 
//      cast(
//    sum((
//          get_numeric_value( PD.YY1_WGT_PC_PRD )
//        * get_numeric_value( _item.NetPriceAmount )
//        * get_numeric_value( _item.RequestedQuantity )
//        * get_numeric_value(price.ConditionRateRatio)) / 100
//    )
//as abap.dec(23,2) ) as CGSTValue, 
      price1.ConditionRateRatio as SGSTRate,
      sum(cast(price1.ConditionAmount as abap.dec( 15, 3 ))) as SGSTValue,
//       cast(
//    sum((
//          get_numeric_value( PD.YY1_WGT_PC_PRD )
//        * get_numeric_value( _item.NetPriceAmount )
//        * get_numeric_value( _item.RequestedQuantity )
//        * get_numeric_value(price1.ConditionRateRatio)) / 100
//    )
//as abap.dec(23,2) ) as SGSTValue, 
      price2.ConditionRateRatio as IGSTRate,
      sum(cast(price2.ConditionAmount as abap.dec( 15, 3 ))) as IGSTValue,
//       cast(
//    sum((
//          get_numeric_value( PD.YY1_WGT_PC_PRD )
//        * get_numeric_value( _item.NetPriceAmount )
//        * get_numeric_value( _item.RequestedQuantity )
//        * get_numeric_value(price2.ConditionRateRatio)) / 100
//    )
//as abap.dec(23,2) ) as IGSTValue, 
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    _item.NetPriceAmount as zpr1rate,
      
      @EndUserText.label: 'Total Weight'
      cast(
    sum(
        cast( PD.YY1_WGT_PC_PRD as abap.dec(15,3) ) *
        cast( _item.RequestedQuantity as abap.dec(15,3) )
    )
as abap.dec(15,3) ) as TotalWeight,

      @EndUserText.label: 'Total Price'
      sum( cast( _item.NetAmount as abap.dec( 15, 3 ))) as TotalPrice,
//cast(
//    sum(
//          get_numeric_value( PD.YY1_WGT_PC_PRD )
//        * get_numeric_value( _item.NetPriceAmount )
//        * get_numeric_value( _item.RequestedQuantity )
//    )
//as abap.dec(23,2) ) as TotalPrice,
 substring(
    _item1.Material,
    cast( length( _item1.Material ) - 1 as abap.int4 ),
    2
) as LastTwoChar,
      _hdr,
      Item1


} where _item.MainItemPricingRefProduct is not initial 
group by
  _hd.SalesDocument,
  _item.BillOfMaterial,
  _item1.Material,
  _item1.SalesDocumentItemText,
  HSN.ConsumptionTaxCtrlCode,
  _item1.RequestedQuantity,
  price.ConditionRateRatio,
  price1.ConditionRateRatio,
  price2.ConditionRateRatio,
  _item1.RequestedQuantityUnit,
  _item.TransactionCurrency,
  _item.NetPriceAmount,  
  _item.TransactionCurrency,
  _item.MainItemPricingRefProduct
