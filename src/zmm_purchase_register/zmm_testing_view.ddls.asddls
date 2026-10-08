@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'testing'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmm_testing_view as select from I_PurchaseOrderAPI01 as POH

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
  key MDI.MaterialDocument ,
 
  key MDI.MaterialDocumentItem ,
  key MDI.MaterialDocumentYear ,
  key ACI.SupplierInvoice ,
  key ACI.SupplierInvoiceItem,
  key ACI.FiscalYear ,
  POI.DocumentCurrency as PriceUnit,
  
   @Semantics.amount.currencyCode: 'PriceUnit'
   cast(rdom.AmountInCompanyCodeCurrency as abap.dec( 15,2 ) )  as AMTRoundoff, 
     @Semantics.amount.currencyCode: 'PriceUnit'
    cast(rdom1.AmountInCompanyCodeCurrency as abap.dec( 15,2 ) )  as cess,
     @Semantics.amount.currencyCode: 'PriceUnit'
  cast(rdom2.AmountInCompanyCodeCurrency as abap.dec( 15,2 ) ) as TCS,  
    @Semantics.amount.currencyCode: 'PriceUnit'
  cast(rdom3.AmountInCompanyCodeCurrency as abap.dec( 15,2 ) ) as FreightEXO,  
     @Semantics.amount.currencyCode: 'PriceUnit'
    cast(rdom4.AmountInCompanyCodeCurrency as abap.dec( 15,2 ) )  as frigt
    
}
