@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sale Report For Mark Number'
@Metadata.ignorePropagatedAnnotations: true
    define view entity ZSD_REPORT_IRV2 as select from I_SalesDocument as sd
    left outer join I_SalesDocumentItem as sdi on sdi.SalesDocument = sd.SalesDocument
                                               and  ( sdi.SalesDocumentItemCategory = 'TAN'
                                               or  sdi.SalesDocumentItemCategory = 'KMN' )
    left outer join I_Product as pd on pd.Product = sdi.Material   
    left outer join I_ProductText as pdt on pdt.Product = sdi.Material      
                                         and pdt.Language = $session.system_language                                  
    association to parent ZSD_REPORT as item on item.SalesDocument = $projection.SalesDocument
                                             and item.MainItemPricingRefProduct = $projection.MainItemPricingRefProduct
                                             and item.BillOfMaterial = $projection.BillOfMaterial
    association [1..1] to ZSD_REP_RV as _hdr
      on _hdr.SalesDocument = $projection.SalesDocument                                         
    
{
    key sd.SalesDocument,
    key sdi.BillOfMaterial,
    key sdi.Material,
    key sdi.MainItemPricingRefProduct,
    @Semantics.quantity.unitOfMeasure: 'RequestedQuantityUnit'
    sdi.RequestedQuantity,
    sdi.RequestedQuantityUnit,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sdi.NetPriceAmount,
    sdi.TransactionCurrency,
    cast(cast(pd.YY1_WGT_PC_PRD as abap.dec( 15, 3 )) *
        cast(sdi.RequestedQuantity as abap.dec( 15, 3 )) as abap.dec( 15, 3 ) ) as Totalwt,
         @Semantics.quantity.unitOfMeasure: 'wuom'
        pd.YY1_UNIT_WGT_PRD,
        pd.YY1_UNIT_WGT_PRDU as wuom,
        @Semantics.quantity.unitOfMeasure: 'UOM'
        cast(pd.YY1_LENGTH_MM_PRD as abap.dec( 10, 0 )) as YY1_LENGTH_MM_PRD,
        @Semantics.quantity.unitOfMeasure: 'UOM'
        cast( pd.YY1_WIDTH_MM_PRD as abap.dec( 10, 0 )) as YY1_WIDTH_MM_PRD,
        pd.YY1_LENGTH_MM_PRDU as UOM,
        @Semantics.quantity.unitOfMeasure: 'wuom'
        pd.YY1_WGT_PC_PRD,
        pdt.ProductName,
        item,
        _hdr
}
