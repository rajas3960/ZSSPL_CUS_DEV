@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIS Details Report Root View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_REP_RV
  as select from    I_SalesDocument        as s
    left outer join I_SalesDocumentItem    as si  on  si.SalesDocument             = s.SalesDocument
                                                  and si.SalesDocumentItemCategory = 'TAN'
    left outer join I_Customer             as c   on c.Customer = s.SoldToParty
    left outer join I_SalesDocumentPartner as sp  on  sp.SalesDocument   = s.SalesDocument
                                                  and sp.PartnerFunction = 'WE'
    left outer join I_Customer             as sc  on sc.Customer = sp.Customer
    left outer join ZPP_WIP_RV             as Din on  Din.SalesOrder = s.SalesDocument
                                                  and Din.Product    = si.Product
    left outer join I_BillingDocumentItem  as bdi on  bdi.SalesDocument             =  s.SalesDocument
                                                  and bdi.SalesDocumentItem         =  si.SalesDocumentItem
                                                  and bdi.ReturnItemProcessingType  <> 'X'
                                                  and bdi.OverallBillingStatus      is not null
                                                  and bdi.SalesDocumentItemCategory =  'TAN'

{
  key s.SalesDocument                  as Salesorder,
  key si.SalesDocumentItem             as SaleslineItem,
  key si.Plant                         as Plant,
      si.MainItemPricingRefProduct     as PricingReferenceMaterial,
      s.SoldToParty                    as SoldToParty,
      c.CustomerName                   as SoldToPartyName,
      sp.Customer                      as ShipToParty,
      sc.CustomerName                  as ShipToPartyName,
      si.Product                       as ProductNumber,
      si.SalesDocumentItemText         as ItemDescription,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      si.OrderQuantity                 as OrderQuantity,
      si.OrderQuantityUnit             as OrderQuantityUnit,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      si.NetPriceAmount                as Ratekg,
      si.TransactionCurrency           as TransactionCurrency,
      @Semantics.quantity.unitOfMeasure: 'ConfirmationUnit'
      Din.ConfYieldQtyInProductionUnit as ProductionQuantityDIN,
      Din.ConfirmationUnit             as ConfirmationUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      bdi.BillingQuantity              as DispatchedQty,
      bdi.BillingQuantityUnit          as BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      cast(
      Din.ConfYieldQtyInProductionUnit as abap.quan( 15, 3 )
      )
      -
      cast(
      bdi.BillingQuantity as abap.quan( 15, 3 )
      )                                as BalanceQuantity,
      cast(
      (
        cast(
            Din.ConfYieldQtyInProductionUnit as abap.quan( 15, 3 )
        )
        -
        cast(
           bdi.BillingQuantity  as abap.quan( 15, 3 )
        )
      )
      *
      cast(
        si.NetPriceAmount as abap.dec( 15, 2 )
      )
      as abap.dec( 15, 2 )
      )                                as BalanceAmount


}
group by
  s.SalesDocument,
  si.SalesDocumentItem,
  si.Plant,
  si.MainItemPricingRefProduct,
  s.SoldToParty,
  c.CustomerName,
  sp.Customer,
  sc.CustomerName,
  si.Product,
  si.SalesDocumentItemText,
  si.OrderQuantity,
  si.OrderQuantityUnit,
  si.NetPriceAmount,
  si.TransactionCurrency,
  Din.ConfYieldQtyInProductionUnit,
  Din.ConfirmationUnit,
  bdi.BillingQuantityUnit,
  bdi.BillingQuantity
