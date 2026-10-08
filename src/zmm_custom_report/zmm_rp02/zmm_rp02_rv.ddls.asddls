@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register Report - Root View Entity'
@Metadata.ignorePropagatedAnnotations:true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_RP02_RV as select from I_PurchaseOrderAPI01 as POH
inner join I_PurchaseOrderItemAPI01 as POI on POI.PurchaseOrder = POH.PurchaseOrder
left outer join I_PurOrdAccountAssignmentAPI01 as poia on poia.PurchaseOrder = POI.PurchaseOrder and poia.PurchaseOrderItem = POI.PurchaseOrderItem
left outer join I_FixedAsset as FA on FA.MasterFixedAsset =  poia.MasterFixedAsset and FA.FixedAsset = poia.FixedAsset
left outer join I_ProductText as PRT on PRT.Product = POI.Material and PRT.Language = 'E'
left outer join I_MaterialDocumentItem_2 as MDI on MDI.PurchaseOrder = POI.PurchaseOrder and MDI.PurchaseOrderItem = POI.PurchaseOrderItem
left outer join I_GLAccountText as glc on glc.GLAccount = MDI.GLAccount and glc.Language = 'E'
left outer join ZMM_RP02_INV as ACI on ACI.Reference3IDByBusinessPartner = MDI.MaterialDocument
                                       and ACI.Reference3IDByBusinessItem = MDI.MaterialDocumentItem
                                       

left outer join I_TaxCodeText                  as TXC on TXC.TaxCode  = ACI.TaxCode and TXC.Language = 'E'
 
 
left outer join ZMM_RP02_SERIN as SES on SES.ServiceEntrySheet =  MDI.InvtryMgmtReferenceDocument
                                                    and SES.ServiceEntrySheetItem = MDI.InvtryMgmtRefDocumentItem
                                                    
                                                    
left outer join I_ServiceEntrySheetAPI01 as SESH on SESH.ServiceEntrySheet = SES.ServiceEntrySheet

left outer join ZMM_RP02_INV as ACI2 on ACI2.Reference3IDByBusinessPartner = SES.ServiceEntrySheet
                                     and ACI2.Reference3IDByBusinessItem = SES.ServiceEntrySheetItem
                                     
left outer join I_TaxCodeText                  as TXC1 on TXC1.TaxCode  = ACI2.TaxCode and TXC1.Language = 'E'

left outer join ZMM_RP02_JV2 as JEI on JEI.PredecessorReferenceDocument = ACI.OriginalReferenceDocument
                                       and JEI.PredecessorReferenceDocItem = ACI.Reference3IDByBusinessItem
                                       
left outer join ZMM_RP02_CSI_V as opi on opi.OriginalReferenceDocument = MDI.MaterialDocument


                                       
{
    key POI.PurchaseOrder,
    key POI.PurchaseOrderItem,
    key MDI.MaterialDocument,     //GRNDocument
    key MDI.MaterialDocumentItem, //GRNItem
    key MDI.MaterialDocumentYear, //GRNYear
    // and ACI2.AccountingDocument is not initial ADDITIONAL ADDED BY OMKAR 05.03.2026
    key case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial        then 
       ACI2.AccountingDocument
       else
    ACI.AccountingDocument end as AccountingDocument,   
    key ACI.TaxItemGroup,
    key SES.ServiceEntrySheet,
    key SES.ServiceEntrySheetItem,
    key poia.AccountAssignmentNumber,
    key FA.MasterFixedAsset,
    key FA.FixedAsset,
    ACI.FiscalYear,
    case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then 
    ACI2.OriginalReferenceDocument
    else ACI.OriginalReferenceDocument end as OriginalReferenceDocument, //SupplierInvoiceNo
    POH.PurchaseOrderDate,         // Purchase Order Date
    MDI.DocumentDate,              // Material Document Date
    case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then 
       ACI2.PostingDate
       else
    ACI.PostingDate end as PostingDate,               // Invoice Date 
    
      POH.PurchaseOrderType ,
    POH.PurchasingGroup ,
    POI.BR_NCM as hsnno,
   POI.MaterialType,
     case
      when POI.MaterialType   = 'FERT'
      then cast('180020' as abap.char(10))
      when POI.MaterialType   = 'HALB'
      then cast('180010' as abap.char(10))
      when POI.MaterialType   = 'ROH'
      then cast('180000' as abap.char(10))
      when POI.MaterialType   = 'HIBE'
      then cast('180030' as abap.char(10))
      else
       MDI.GLAccount end as GLCode,
      case  when POI.MaterialType   = 'FERT'
      then 'Inv-Finished Goods'
      when POI.MaterialType   = 'HALB'
      then 'Inv-Semi Finished Material'
      when POI.MaterialType   = 'ROH'
      then 'Inv-Raw Material'
      when POI.MaterialType   = 'HIBE'
      then 'Inv-Operating suppliers'
      else
     glc.GLAccountName end as GLDescription , 
       POI.MaterialGroup ,
       POI.BaseUnit   ,
       @Semantics.quantity.unitOfMeasure:    'Baseunit'
       POI.OrderQuantity,
       POI.Plant,
       @Semantics.amount.currencyCode: 'DocumentCurrency'
       
       POI.NetPriceAmount  as Rate,  
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
       cast(cast(POI.NetPriceAmount as abap.dec(11,2)) * POH.ExchangeRate as abap.dec(11,2))   as RateInr,
       case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then
       ACI2.Supplier
       else
       ACI.Supplier end  as SUPPLIER,
       
       case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then
       ACI2.SupplierName
       else
       ACI.SupplierName end as SupplierName,
       
       
       
       POI.DocumentCurrency,
       // Material Document //
       MDI.GoodsMovementType as GoodsReceiptType ,
       MDI.StorageLocation,
       MDI.MaterialBaseUnit,
       MDI.EntryUnit,
        @Semantics.quantity.unitOfMeasure:    'EntryUnit'
       case when MDI.DebitCreditCode = 'H'
       then MDI.QuantityInBaseUnit * -1 
       when MDI.DebitCreditCode = 'S'
       then
       MDI.QuantityInBaseUnit
       when POH.PurchaseOrderType = 'ZSER' and SESH.IsDeleted = 'X'
       then
       SES.ConfirmedQuantity * -1
       when POH.PurchaseOrderType = 'ZSER' and SESH.IsDeleted <> 'X'
       then
        SES.ConfirmedQuantity 
       else null end as GRNQuantity ,
       MDI.DebitCreditCode,
       // Invoice Details //
        ACI.CompanyCodeCurrency,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     
       case 
        when POH.PurchaseOrderType = 'ZSER'  and ACI2.AccountingDocument is not initial
       then
       ACI2.AmountInCompanyCodeCurrency
       else
       ACI.AmountInCompanyCodeCurrency end as AmountInCompanyCodeCurrency,

       
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        
          case 
            when POH.PurchaseOrderType = 'ZSER'  and ACI2.AccountingDocument is not initial
          then
          ACI2.CGST_C
       else
       ACI.CGST_C  end as CGST_C,

        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then
       ACI2.CGST_C
       else
       ACI.CGST_C end as SGST_C ,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when POH.PurchaseOrderType = 'ZSER' and ACI2.IGST_C is  not initial and ACI2.AccountingDocument is not initial
       then
       ACI2.IGST_C
       when  POH.PurchaseOrderType = 'ZSER' and ACI2.IGST1_C is  not initial and ACI2.AccountingDocument is not initial
       then
       ACI2.IGST1_C
       when ACI.IGST1_C is not initial
       then
       ACI.IGST1_C
       else 
       ACI.IGST_C end as IGST_C,
       case 
       when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
       then
       ACI2.DocumentReferenceID
       else 
       ACI.DocumentReferenceID end as DocumentReferenceID,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
       cast(0 as abap.curr(23,2)) as Extravalue,
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
     then coalesce(cast(ACI2.AmountInCompanyCodeCurrency as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI2.CGST_C as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI2.CGST_C as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI2.IGST_C as abap.dec(23,2) ),0)
        + coalesce(cast(ACI2.IGST1_C as abap.dec(23,2)),0)
     else coalesce(cast(ACI.AmountInCompanyCodeCurrency as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI.CGST_C as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI.CGST_C as abap.dec(23,2) ),0) 
        + coalesce(cast(ACI.IGST_C as abap.dec(23,2) ),0)
        +  coalesce(cast(ACI.IGST1_C as abap.dec(23,2)),0)
end as grossvalue,
ACI.AccountingDocumentType,
case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
then
ACI2.InvoiceDate
else 
ACI.InvoiceDate end as Invoicedate,
case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
then
ACI2.TaxCode
else 
ACI.TaxCode end as taxcode,
case when POH.PurchaseOrderType = 'ZSER' and ACI2.AccountingDocument is not initial
then
TXC1.TaxCodeName
else 
TXC.TaxCodeName end as TaxCodeName,
MDI.GoodsMovementIsCancelled,
POI.PurchaseOrderItemText,
FA.FixedAssetDescription,
FA.FixedAssetExternalID,
@ObjectModel.text.element: [ 'Assetdec' ]
FA.AssetClass as AssetAdditionalDescription,
@UI.hidden: true
FA._AssetClass._Text.AssetClassDescription as Assetdec,
JEI.MasterFixedAsset as MasterFixedAsset1,
JEI.PostingDate as PostingDate1,
opi.AccountingDocument as accuoun1,
MDI.PostingDate as Grnpostingdate







       
       
       
       
       
      
       
       
       
       
       
    
}
union all select from ZMM_RP02_INV_CD as UNI
left outer join I_TaxCodeText  as TXCE on TXCE.TaxCode  = UNI.TaxCode and TXCE.Language = 'E'
left outer join I_GLAccountText as glp on glp.GLAccount =  UNI.GLAccount and glp.Language = 'E'
left outer join I_FixedAsset as FAS on FAS.MasterFixedAsset =  UNI.MasterFixedAsset and FAS.FixedAsset = UNI.FixedAsset
{
  key UNI.PurchasingDocument as PurchaseOrder,
  key UNI.PurchasingDocumentItem as PurchaseOrderItem,
  key UNI.Reference3IDByBusinessPartner as MaterialDocument,
  key UNI.Reference3IDByBusinessItem as MaterialDocumentItem,
  key  cast('' as abap.numc(4)) as MaterialDocumentYear,
  key UNI.AccountingDocument,
  key UNI.TaxItemGroup,
  key ' ' as ServiceEntrySheet,
  key cast('' as abap.numc(5)) as ServiceEntrySheetItem,
  key  cast(' ' as abap.numc(2)) as AccountAssignmentNumber,
  key  FAS.MasterFixedAsset,
  key FAS.FixedAsset,
  UNI.FiscalYear,
  UNI.OriginalReferenceDocument,
  ' ' as PurchaseOrderDate,
  ' ' as DocumentDate,
  UNI.PostingDate,
  ' ' as PurchaseOrderType,
  ' ' as PurchasingGroup,
  ' ' as hsnno,
  ' ' as MaterialType,
  UNI.GLAccount as GLCode,
  glp.GLAccountName as GLDescription,
  ' ' as MaterialGroup ,
  cast(' ' as abap.unit(3)) as BaseUnit,
  cast(0 as abap.quan(13, 3)) as OrderQuantity,
  ' ' as Plant,
  cast(0 as abap.curr(11,2)) as Rate,
  cast(0 as abap.dec(11,2)) as RateInr,
  UNI.Supplier,
       UNI.SupplierName,
  cast('' as abap.cuky( 5 )) as DocumentCurrency,
  ' ' as GoodsReceiptType,
  ' 'as StorageLocation,
 cast(' ' as abap.unit(3)) as MaterialBaseUnit,
cast(' ' as abap.unit(3)) as EntryUnit,
cast(0 as abap.dec(13,3)) as GRNQuantity,
' ' as DebitCreditCode,
 cast('' as abap.cuky( 5 )) as CompanyCodeCurrency,
cast(0 as abap.curr(23,2)) as AmountInCompanyCodeCurrency,
UNI.CGST_C,
UNI.CGST_C as SGST_C ,
case when UNI.IGST_C is not initial
then
UNI.IGST_C
else 
UNI.IGST1_C end as IGST_C,
UNI.DocumentReferenceID,
UNI.AmountInCompanyCodeCurrency as Extravalue,

coalesce(cast(UNI.AmountInCompanyCodeCurrency as abap.dec(23,2)),0)
 + coalesce(cast(UNI.CGST_C as abap.dec(23,2)),0) 
 + coalesce(cast(UNI.CGST_C as abap.dec(23,2)),0) 
 + coalesce(cast(UNI.IGST_C as abap.dec(23,2)),0)
 + coalesce(cast(UNI.IGST1_C as abap.dec(23,2)),0)  as grossvalue,
 UNI.AccountingDocumentType,
 UNI.InvoiceDate,
 UNI.TaxCode,
 TXCE.TaxCodeName,
 ' ' as GoodsMovementIsCancelled,
 ' ' as PurchaseOrderItemText,
FAS.FixedAssetDescription,
FAS.FixedAssetExternalID,
FAS.AssetClass as AssetAdditionalDescription,
FAS._AssetClass._Text.AssetClassDescription as Assetdec,
'' as MasterFixedAsset1,
'' as PostingDate1,
'' as accuoun1,
'' as Grnpostingdate
 
 


  
  
  
  
   
}
