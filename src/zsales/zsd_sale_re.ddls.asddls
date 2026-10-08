@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity - Sales Reports'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_Sale_re as 
select from I_BillingDocumentItem as BDI
inner join I_BillingDocument as BDH on BDH.BillingDocument = BDI.BillingDocument
 left outer join I_BillingDocumentItemPrcgElmnt as IGST on  IGST.BillingDocument     = BDI.BillingDocument
                                                           and IGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                           and IGST.ConditionType       = 'JOIG'
    left outer join I_BillingDocumentItemPrcgElmnt as CGST on  CGST.BillingDocument     = BDI.BillingDocument
                                                           and CGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                           and CGST.ConditionType       = 'JOCG'
    left outer join I_BillingDocumentItemPrcgElmnt as SGST on  SGST.BillingDocument     = BDI.BillingDocument
                                                           and SGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                           and SGST.ConditionType       = 'JOSG'
left outer join I_BillingDocumentPartner as BDP on BDP.BillingDocument = BDI.BillingDocument and BDP.PartnerFunction = 'RE'
left outer join I_ProductPlantBasic as HSN on HSN.Product = BDI.Product
                                          and HSN.Plant = BDI.Plant
left outer join I_Customer as CUS on CUS.Customer = BDP.Customer
left outer join I_Customer as PAY on PAY.Customer = BDH.PayerParty
left outer join I_Customer as SOP on SOP.Customer = BDH.SoldToParty
left outer join I_Plant as PLT on PLT.Plant = BDI.Plant
left outer join I_SalesDocument as SD on SD.SalesDocument = BDI.SalesDocument

{
key BDH.BillingDocument as BILLDOC,
key BDI.BillingDocumentItem as BILLITNO,
BDH.CompanyCode as CMPC,
BDH.SalesOrganization as SALESORG,
BDH.DistributionChannel as DISTCHLN,
BDH.Division ,
BDH.BillingDocumentType as BILLDCTY,
BDH.BillingDocumentDate as BILLDT,
BDP.Customer as BILLTOPARTY,
CUS.CustomerFullName as BILLTOPARTYNAME,
BDH.PayerParty as  PAYER,
PAY.CustomerFullName as PAYERNAME,
BDH.SoldToParty,
SOP.CustomerFullName as SOLDTOPARTYNAME,
CUS.TaxNumber3 as GSTNO,
BDI.Product as MATERIALNO,
BDI.BillingDocumentItemText as PRODUCT,
HSN.ConsumptionTaxCtrlCode as HSNNO,
BDI.BaseUnit as uom,
@Semantics.quantity.unitOfMeasure: 'billqtunit'
BDI.BillingQuantity as BILLQTY,
BDI.BillingQuantityUnit as BILLQTUNIT,
PLT.PlantName,
BDI.StorageLocation as STRLOCT,
@Semantics.quantity.unitOfMeasure: 'uom'
BDI.ItemNetWeight as NETWEIGHT,
@Semantics.quantity.unitOfMeasure: 'uom'
BDI.ItemGrossWeight as GROSSWEIGHT,
BDI.TransactionCurrency as CURRENCY,
@Semantics.amount.currencyCode: 'CURRENCY'
BDI.NetAmount as netamt,
@Semantics.amount.currencyCode: 'CURRENCY'
BDI.TaxAmount as taxamt,
@Semantics.amount.currencyCode: 'CURRENCY'
cast(BDI.TaxAmount + BDI.NetAmount as abap.dec( 15, 2 ) ) as TOTALAMT,
IGST.ConditionCurrency as curr,
@Semantics.amount.currencyCode: 'curr'
IGST.ConditionAmount         as igstamt,
@Semantics.amount.currencyCode: 'curr'
CGST.ConditionAmount         as cgstamt,
@Semantics.amount.currencyCode: 'curr'
SGST.ConditionAmount         as sgstamt,
BDI.PriceDetnExchangeRate as exchangerate,
BDI.ReferenceSDDocument as referencedoc,
BDI.SalesDocument as salesorder,
BDH.AccountingDocument as docno,
BDH.BillingDocumentIsCancelled as cancel,
BDH.CancelledBillingDocument as billcan,
SD.PurchaseOrderByCustomer as ponumber

    
}
