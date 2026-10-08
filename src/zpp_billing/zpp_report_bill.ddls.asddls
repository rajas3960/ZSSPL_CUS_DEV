@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BILLING REPORT'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_report_BILL
  as select from    I_BillingDocument              as BD
    left outer join I_BillingDocumentItem          as BDI    on  BDI.BillingDocument           =  BD.BillingDocument
                                                             and BDI.SalesDocumentItemCategory <> 'TAP'
    left outer join I_BillingDocumentItemPrcgElmnt as bdp    on  bdp.BillingDocument     = BDI.BillingDocument
                                                             and bdp.BillingDocumentItem = BDI.BillingDocumentItem
                                                             and bdp.ConditionType       = 'ZPR1'
    left outer join I_BillingDocumentItemPrcgElmnt as IGST   on  IGST.BillingDocument     = BDI.BillingDocument
                                                             and IGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                             and IGST.ConditionType       = 'JOIG'
    left outer join I_BillingDocumentItemPrcgElmnt as SGST   on  SGST.BillingDocument     = BDI.BillingDocument
                                                             and SGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                             and SGST.ConditionType       = 'JOSG'
    left outer join I_BillingDocumentItemPrcgElmnt as CGST   on  CGST.BillingDocument     = BDI.BillingDocument
                                                             and CGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                             and CGST.ConditionType       = 'JOCG'
    left outer join I_BillingDocumentItemPrcgElmnt as FRIGHT on  FRIGHT.BillingDocument     = BDI.BillingDocument
                                                             and FRIGHT.BillingDocumentItem = BDI.BillingDocumentItem
                                                             and FRIGHT.ConditionType       = 'ZKF1'
    left outer join I_Product                      as PD     on PD.Product = BDI.Product
    left outer join I_ProductText                  as pt     on  pt.Product = BDI.MainItemPricingRefMaterial
                                                             and pt.Language    = $session.system_language
{
  key BD.BillingDocument,
  key BDI.MainItemPricingRefMaterial,
      pt.ProductName,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      sum(BDI.BillingQuantity)                             as billingqty,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      cast(
            sum( cast(BDI.BillingQuantity as abap.dec( 10, 3 ) )* cast( PD.YY1_WGT_PC_PRD as abap.dec( 10, 3 )) )
            as abap.dec( 15, 3 )
          )                                                as TOT_WT,
      cast(
      sum(
          cast( bdp.ConditionAmount as abap.dec(10,3) )
      )
      as abap.dec(15,3)
      )                                                    as TOT_PRICE,
      BDI.BillingQuantityUnit,
      bdp.ConditionRateValue,
      IGST.ConditionRateValue                              as igst,
      sum(cast(IGST.ConditionAmount as abap.dec( 15, 3 ))) as IGST_value,
      CGST.ConditionRateValue                              as Cgst,
      sum(cast(CGST.ConditionAmount as abap.dec( 15, 3 ))) as CGST_value,
      SGST.ConditionRateValue                              as Sgst,
      sum(cast(SGST.ConditionAmount as abap.dec( 15, 3 ))) as SGST_value,
      FRIGHT.ConditionRateValue                              as FRIGHT,
      sum(cast(FRIGHT.ConditionAmount as abap.dec( 15, 3 ))) as FRIGHT_VALUE

}
where
  BDI.MainItemPricingRefMaterial is not initial
group by
  BD.BillingDocument,
  BDI.MainItemPricingRefMaterial,
  BDI.BillingQuantityUnit,
  pt.ProductName,
  bdp.ConditionRateValue,
  IGST.ConditionRateValue,
  CGST.ConditionRateValue,
  SGST.ConditionRateValue,
  FRIGHT.ConditionRateValue
