@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Asset Register Report Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMM_RP01_RV as select from I_PurchaseOrderAPI01 as POH
inner join I_PurOrdAccountAssignmentAPI01 as POIA on POIA.PurchaseOrder =  POH.PurchaseOrder and POH.PurchaseOrderType = 'ZCAP'
 
left outer join I_FixedAsset as FA on FA.MasterFixedAsset =  POIA.MasterFixedAsset and FA.FixedAsset = POIA.FixedAsset
left outer join I_MaterialDocumentItem_2 as MDI on MDI.PurchaseOrder = POIA.PurchaseOrder
                                               and MDI.PurchaseOrderItem = POIA.PurchaseOrderItem
                                               
left outer join ZMM_RP01_INV as ACI on ACI.Reference3IDByBusinessPartner = MDI.MaterialDocument
                                   and ACI.Reference3IDByBusinessItem =  MDI.MaterialDocumentItem

left outer join zmm_rp01_jv as Jei on Jei.PredecessorReferenceDocument = ACI.OriginalReferenceDocument
                                         and Jei.PredecessorReferenceDocItem = ACI.Reference3IDByBusinessItem
//                                         and Jei.PredecessorReferenceDocCntxt = ACI.Reference3IDByBusinessYear

 
{
key POIA.PurchaseOrder,
key POIA.PurchaseOrderItem,
key POIA.AccountAssignmentNumber,
key MDI.MaterialDocument,
key MDI.MaterialDocumentItem,
key MDI.MaterialDocumentYear,
key ACI.AccountingDocument,
key FA.MasterFixedAsset,
key FA.FixedAsset,
key ACI.TaxItemGroup,
 
POIA._PurchaseOrderItem.Plant as PLANT,
ACI.SupplierName,
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
ACI.AmountInCompanyCodeCurrency,
ACI.CompanyCodeCurrency,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  ACI.CGST_C as AmountInCompanyCodeCurrency2,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
ACI.CGST_C as AmountInCompanyCodeCurrency3,
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
ACI.IGST_C as AmountInCompanyCodeCurrency4,
//POIA.MasterFixedAsset,
FA.FixedAssetDescription,
FA.FixedAssetExternalID,
@ObjectModel.text.element: [ 'Assetdec' ]
FA.AssetClass as AssetAdditionalDescription,
@UI.hidden: true
FA._AssetClass._Text.AssetClassDescription as Assetdec,
ACI.DocumentReferenceID,
ACI.PostingDate,
POH.PurchaseOrderDate,
MDI.DocumentDate ,
Jei.MasterFixedAsset as assetno,
Jei.PostingDate as ps
 
  
}
union all select from ZMM_RP01_INGA as UNI
left outer join I_FixedAsset as FSA on FSA.MasterFixedAsset  =  UNI.MasterFixedAsset and FSA.FixedAsset = UNI.FixedAsset
{
key UNI.PurchasingDocument as PurchaseOrder,
key UNI.PurchasingDocumentItem as PurchaseOrderItem,
key cast('' as abap.numc( 2 )) as AccountAssignmentNumber,
key ' ' as MaterialDocument,
key cast('' as abap.numc(4)) as MaterialDocumentItem,
key cast('' as abap.numc(4)) as MaterialDocumentYear,
key UNI.AccountingDocument,
key UNI.MasterFixedAsset,
key UNI.FixedAsset,
key UNI.TaxItemGroup,

' ' as Plant,
UNI.SupplierName,
UNI.AmountInCompanyCodeCurrency,
UNI.CompanyCodeCurrency,
UNI.CGST_C as AmountInCompanyCodeCurrency2,
UNI.CGST_C as AmountInCompanyCodeCurrency3,
UNI.IGST_C as AmountInCompanyCodeCurrency4,
FSA.FixedAssetDescription,
FSA.FixedAssetExternalID,
FSA.AssetClass as AssetAdditionalDescription,
FSA._AssetClass._Text.AssetClassDescription as Assetdec,
UNI.DocumentReferenceID,
UNI.PostingDate,
' ' as PurchaseOrderDate,
' ' as DocumentDate,
' ' as assetno,
' ' as  ps



}
