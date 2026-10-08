@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Purchase Register'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }

//define root view entity ZMM_PURC_REG_RE  as select from I_PurchaseOrderAPI01 as POH
//inner join I_PurchaseOrderItemAPI01 as POI on POI.PurchaseOrder = POH.PurchaseOrder
//left outer join I_ProductText as PRT on PRT.Product = POI.Material and PRT.Language = 'E'
//left outer join I_MaterialDocumentItem_2 as MDI on MDI.PurchaseOrder = POI.PurchaseOrder and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
//
//left outer join ZMM_GRP_SER_1 as ACI on ACI.Reference3IDByBusinessPartner = MDI.MaterialDocument
//                                                            and ACI.PurchasingDocument = MDI.PurchaseOrder 
//                                                            and ACI.PurchasingDocumentItem = MDI.PurchaseOrderItem
// 
// left outer join ZMM_GRP_SUP_1 as ACI1 on ACI1.Reference3IDByBusinessPartner = MDI.MaterialDocument
//                                                            and ACI1.PurchasingDocument = MDI.PurchaseOrder 


//                                                            
////left outer join ZMM_GRP_SUP_1 as ACI on ACI.Reference3IDByBusinessPartner = MDI.MaterialDocument and ACI.PurchasingDocument = MDI.PurchaseOrder and ACI.PurchasingDocumentItem = MDI.PurchaseOrderItem
//left outer join I_PurOrdItmPricingElementAPI01   as pie        on pie.PurchaseOrder = POI.PurchaseOrder
//                                                                  and pie.PurchaseOrderItem = POI.PurchaseOrderItem
//                                                                  and pie.ConditionType = 'ZDSV'                                                                    
//left outer join I_PurchasingDocumentTypeText     as pot        on pot.PurchasingDocumentType = POH.PurchaseOrderType
//                                                                  and pot.PurchasingDocumentCategory = POI.PurchaseOrderCategory
//                                                                  and pot.Language = 'E'  
//                                                                                                                                                                                                  
// left outer join ZTAX_CODE                  as TXC on TXC.Taxcode  = ACI.TaxCode



define root view entity ZMM_PURC_REG_RE  as select from I_PurchaseOrderAPI01 as POH

inner join I_PurchaseOrderItemAPI01 as POI on POI.PurchaseOrder = POH.PurchaseOrder

left outer join I_ProductText as PRT on PRT.Product = POI.Material and PRT.Language = 'E'

left outer join I_MaterialDocumentItem_2 as MDI on MDI.PurchaseOrder = POI.PurchaseOrder
                                               and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
                                               
left outer join I_SuplrInvcItemPurOrdRefAPI01 as ACI on ACI.ReferenceDocument = MDI.MaterialDocument
                                            and ACI.ReferenceDocumentItem = MDI.MaterialDocumentItem
                                            and ACI.PurchaseOrder = MDI.PurchaseOrder 
                                            and ACI.PurchaseOrderItem = MDI.PurchaseOrderItem
                                            and ACI.FiscalYear = MDI.MaterialDocumentYear
                                            
left outer join ZOPERATIONAL_RV as CGST on CGST.OriginalReferenceDocument = ACI.SupplierInvoice
                                               and CGST.FiscalYear = ACI.FiscalYear  and CGST.TaxItemGroup = substring(ACI.SupplierInvoiceItem,4,6)
                                               and CGST.AccountingDocumentItemType = 'T'
                                               and CGST.TransactionTypeDetermination = 'JIC'                                              
      left outer join ZOPERATIONAL_RV as IGST on IGST.OriginalReferenceDocument = ACI.SupplierInvoice
                                               and IGST.FiscalYear = ACI.FiscalYear and IGST.TaxItemGroup = substring(ACI.SupplierInvoiceItem,4,6)
                                               and IGST.AccountingDocumentItemType = 'T'
                                               and IGST.TransactionTypeDetermination = 'JII' 
       left outer join ZOPERATIONAL_RV as IGST1 on IGST1.OriginalReferenceDocument = ACI.SupplierInvoice
                                              and IGST1.FiscalYear = ACI.FiscalYear and IGST1.TaxItemGroup = substring(ACI.SupplierInvoiceItem,4,6)
                                               and IGST1.AccountingDocumentItemType = 'T'
                                               and IGST1.TransactionTypeDetermination = 'JIM'
                                                                                                      

left outer join I_PurOrdItmPricingElementAPI01   as pie        on pie.PurchaseOrder = POI.PurchaseOrder
                                                                  and pie.PurchaseOrderItem = POI.PurchaseOrderItem
                                                                  and pie.ConditionType = 'ZDSV'    
                                                                                                                                  
left outer join I_PurchasingDocumentTypeText     as pot        on pot.PurchasingDocumentType = POH.PurchaseOrderType
                                                                  and pot.PurchasingDocumentCategory = POI.PurchaseOrderCategory
                                                                  and pot.Language = 'E'
                                                                  
 left outer join ZTAX_CODE                  as TXC on TXC.Taxcode  = ACI.TaxCode

 
  left outer join ZOPERATIONAL_RV as rdom on rdom.OriginalReferenceDocument = ACI.SupplierInvoice 
                                                    and rdom.FiscalYear = ACI.FiscalYear                                                    
                                                    and rdom.GLAccount = '0000400300'
  left outer join ZOPERATIONAL_RV as rdom1 on rdom1.OriginalReferenceDocument = ACI.SupplierInvoice  
                                                    and rdom1.FiscalYear = ACI.FiscalYear                                                                    
                                                    and rdom1.GLAccount = '0000389202'
   left outer join ZOPERATIONAL_RV as rdom2 on rdom2.OriginalReferenceDocument = ACI.SupplierInvoice 
                                                     and rdom2.FiscalYear = ACI.FiscalYear                                                                      
                                                     and rdom2.GLAccount = '0000220660'
   left outer join ZOPERATIONAL_RV as rdom3 on rdom3.OriginalReferenceDocument = ACI.SupplierInvoice
                                                      and rdom3.FiscalYear = ACI.FiscalYear                                                                       
                                                     and rdom3.GLAccount = '0000389303'
  left outer join ZOPERATIONAL_RV as rdom4 on  rdom4.OriginalReferenceDocument = ACI.SupplierInvoice  
                                                     and rdom4.FiscalYear = ACI.FiscalYear                                                                
                                                     and  rdom4.GLAccount = '0000389309'
                                                                                                        
    left outer join ZMM_GRP_SUP2  as jen on jen.ReferenceDocument = ACI.SupplierInvoice
//                                  and jen.PurchasingDocument = ACI.PurchaseOrder 
//                                  and jen.PurchasingDocumentItem = ACI.PurchaseOrderItem      
                                                                                                                               
                                                                           
                                                                           
{                                                                         
/*   PURCHASE HEADER */
  key POH.PurchaseOrder,
  key POI.PurchaseOrderItem,
  key MDI.MaterialDocument as GRDocument,
 
  key MDI.MaterialDocumentItem as MATDOCITEM,
  key MDI.MaterialDocumentYear as YEARSSD,    
  key ACI.SupplierInvoice as GLNumber,
  key ACI.SupplierInvoiceItem,
  key ACI.FiscalYear as GRYear,
  
  //ACI1.OriginalReferenceDocument as SupplierInvoiceNo,
  ACI.SupplierInvoice as SupplierInvoiceNo,
  MDI.PostingDate as GRNDate,
 jen.PostingDate as GRpostingDate,
 jen.DocumentDate as InvoiceDate,
 jen.DocumentReferenceID as DocumentReferenceID,
//jhi.DocumentReferenceID as DocumentReferenceID,
//  SDB.DocumentReferenceID,
   @Semantics.amount.currencyCode: 'PriceUnit'
  rdom.AmountInCompanyCodeCurrency as AMTRoundoff, 
     @Semantics.amount.currencyCode: 'PriceUnit'
   rdom1.AmountInCompanyCodeCurrency as cess,
     @Semantics.amount.currencyCode: 'PriceUnit'
 rdom2.AmountInCompanyCodeCurrency as TCS,  
    @Semantics.amount.currencyCode: 'PriceUnit'
 rdom3.AmountInCompanyCodeCurrency as FreightEXO,  
     @Semantics.amount.currencyCode: 'PriceUnit'
  rdom4.AmountInCompanyCodeCurrency as FreightSpare,    
  
  POH.PurchaseOrderType as PurchaseType,
  POH.PurchaseOrderDate as Podate,
  POH.PurchasingGroup as Pogrp,
  
/* PURCHASE ITEM */

  POI.BR_NCM as hsnno,
  POI.MaterialType as MaterialType,
      case
      when POI.MaterialType   = 'FERT'
      then '180020'
      when POI.MaterialType   = 'HALB'
      then '180010'
      when POI.MaterialType   = 'ROH'
      then '180000'
      when POI.MaterialType   = 'HIBE'
      then '180030'
      else null end as GLCode,
      case
      when POI.MaterialType   = 'FERT'
      then 'Inv-Finished Goods'
      when POI.MaterialType   = 'HALB'
      then 'Inv-Semi Finished Material'
      when POI.MaterialType   = 'ROH'
      then 'Inv-Raw Material'
      when POI.MaterialType   = 'HIBE'
      then 'Inv-Operating suppliers'
      else null end as GLDescription,
       POI.MaterialGroup   as Matgrp,
       @Semantics.quantity.unitOfMeasure:    'Baseunit'
      POI.OrderQuantity                                 as OrdQty,
      POI.Plant                                         as plant,
      POI.TaxCode                                       as taxcod,
      TXC.Description   as TaxDescription,
      POI.BaseUnit                                      as Baseunit,
       @Semantics.amount.currencyCode: 'PriceUnit'
      POI.NetPriceAmount                                as Rate,  
      POI.DocumentCurrency as condcurr,
/* MATERIAL DOCUMENT */
     MDI.GoodsMovementType as GoodsMovement,
      MDI.StorageLocation                               as StgLoc,
//       MDI.DocumentDate,                                 //as InvoiceDate,    
      MDI.MaterialBaseUnit as EntryUnit,
        @Semantics.quantity.unitOfMeasure:    'EntryUnit'  
        case when MDI.DebitCreditCode = 'H' or ACI.DebitCreditCode = 'H'
        then  
      MDI.QuantityInBaseUnit * -1 else
      MDI.QuantityInBaseUnit end as GRNQuantity, 
      ACI.StockUnit as BASE,
     @Semantics.quantity.unitOfMeasure:    'BASE'
     case when MDI.DebitCreditCode = 'H' or ACI.DebitCreditCode = 'H'
        then  
         ACI.QuantityInPurchaseOrderUnit * -1 
         else  ACI.QuantityInPurchaseOrderUnit end as Quantity,
     MDI.DebitCreditCode,
     ACI.DebitCreditCode as dCCode,
       @Semantics.amount.currencyCode: 'PriceUnit'
     ACI.SupplierInvoiceItemAmount as taxablevalue,
     ACI.DocumentCurrency as PriceUnit,
      @Semantics.amount.currencyCode: 'PriceUnit'
     CGST.AmountInCompanyCodeCurrency as cgstamount,
      @Semantics.amount.currencyCode: 'PriceUnit'
    CGST.AmountInCompanyCodeCurrency as sgstamount,
       @Semantics.amount.currencyCode: 'PriceUnit'
       IGST.AmountInCompanyCodeCurrency as igstamount,
//       ACI.Supplier as Vendor,
       abap.char'' as VendorName,
        POI.Material as Material,
       PRT.ProductName as MaterialDescription,
         @Semantics.amount.currencyCode: 'PriceUnit'
       pie.ConditionRateValue as discountvalue,
       pot.PurchasingDocumentTypeName as POType,
       
       TXC.CGSTPercent as CGSTPercent,
       TXC.SGSTPercent as SGSTPercent,
       TXC.IGSTPercent as IGSTPercent,     
        @Semantics.amount.currencyCode: 'PriceUnit'
         case

      when CGST.AmountInCompanyCodeCurrency is not initial and ACI.DebitCreditCode = 'H'
      then ( CGST.AmountInCompanyCodeCurrency * 2 ) - ACI.SupplierInvoiceItemAmount + rdom2.AmountInCompanyCodeCurrency + rdom1.AmountInCompanyCodeCurrency
        when CGST.AmountInCompanyCodeCurrency is not initial and ACI.DebitCreditCode = 'S'
      then ( CGST.AmountInCompanyCodeCurrency * 2 ) + ACI.SupplierInvoiceItemAmount + rdom2.AmountInCompanyCodeCurrency + rdom1.AmountInCompanyCodeCurrency
      when IGST.AmountInCompanyCodeCurrency is not initial and  ACI.DebitCreditCode = 'H' 
      then (IGST.AmountInCompanyCodeCurrency * 1) - ACI.SupplierInvoiceItemAmount + rdom2.AmountInCompanyCodeCurrency + rdom1.AmountInCompanyCodeCurrency
       when IGST.AmountInCompanyCodeCurrency is not initial and  ACI.DebitCreditCode = 's' 
       then IGST.AmountInCompanyCodeCurrency + ACI.SupplierInvoiceItemAmount + rdom2.AmountInCompanyCodeCurrency + rdom1.AmountInCompanyCodeCurrency
      else ACI.SupplierInvoiceItemAmount end      as grossamount
      
    
  

//cast(rdom.AmountInTransactionCurrency + rdom1.AmountInTransactionCurrency + rdom2.AmountInTransactionCurrency + rdom3.AmountInTransactionCurrency + rdom4.AmountInTransactionCurrency as abap.dec( 15, 2)) as TotalAmount
//cast(cast(cast(JOI.AmountInTransactionCurrency + DIS.AmountInTransactionCurrency as abap.dec(15,2)) * TXC.CGSTPercent  as abap.dec(15,2)) / 100 as abap.dec( 15,2)) as TaxableAmountCGST,


   }

