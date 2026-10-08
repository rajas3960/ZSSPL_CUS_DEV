@AbapCatalog.sqlViewName: 'ZOM_SALESV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Testing Purpose we are checking'
@Metadata.ignorePropagatedAnnotations: true
define view ZSD_SALES_RV_TEST as select from I_BillingDocument as BDH
inner join I_BillingDocumentItem as BDI on BDI.BillingDocument = BDH.BillingDocument
left outer join I_BillingDocumentItemPrcgElmnt as FREIGHT on FREIGHT.BillingDocument = BDI.BillingDocument //I_BillingDocumentItemPrcgElmnt
                                                       and FREIGHT.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and FREIGHT.ConditionType = 'ZKF0' and FREIGHT.ConditionInactiveReason <> 'M' and FREIGHT.ConditionAmount <> 0.0 // FREIGHT
left outer join I_BillingDocumentItemPrcgElmnt as MATERIALVAL on MATERIALVAL.BillingDocument = BDI.BillingDocument 
                                                       and MATERIALVAL.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and MATERIALVAL.ConditionType = 'ZPR1'  // MATERIAL VALUE
left outer join I_BillingDocumentItemPrcgElmnt as IGST on IGST.BillingDocument = BDI.BillingDocument 
                                                       and IGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and IGST.ConditionType = 'JOIG'  // IGST
left outer join I_BillingDocumentItemPrcgElmnt as IGST_1 on IGST_1.BillingDocument = BDI.BillingDocument 
                                                       and IGST_1.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and IGST_1.ConditionType = 'ZOIG'  // IGST                                                      
left outer join I_BillingDocumentItemPrcgElmnt as CGST on CGST.BillingDocument = BDI.BillingDocument 
                                                       and CGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and CGST.ConditionType = 'JOCG'  // CGST
left outer join I_BillingDocumentItemPrcgElmnt as SGST on SGST.BillingDocument = BDI.BillingDocument 
                                                       and SGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and SGST.ConditionType = 'JOSG'  // SGST
left outer join I_BillingDocumentItemPrcgElmnt as TCS on TCS.BillingDocument = BDI.BillingDocument 
                                                       and TCS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and TCS.ConditionType = 'JTC1'//TCS
left outer join I_BillingDocumentItemPrcgElmnt as PCIP on PCIP.BillingDocument = BDI.BillingDocument 
                                                       and PCIP.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PCIP.ConditionType = 'PCIP'//PCIP
left outer join I_BillingDocumentItemPrcgElmnt as CESS on CESS.BillingDocument = BDI.BillingDocument 
                                                       and CESS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and CESS.ConditionType = 'ZCOS'// CESS CONDITION 
left outer join I_BillingDocumentItemPrcgElmnt as ZTDS on ZTDS.BillingDocument = BDI.BillingDocument 
                                                       and ZTDS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and ZTDS.ConditionType = 'ZTDS'// TCS SCARPS CHARGES
left outer join I_BillingDocumentItemPrcgElmnt as ZOTH on ZOTH.BillingDocument = BDI.BillingDocument 
                                                       and ZOTH.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and ZOTH.ConditionType = 'ZOTH'// OTHER CHARGES 

left outer join I_BillingDocumentPartner as BDP on BDP.BillingDocument = BDI.BillingDocument and BDP.PartnerFunction = 'RE' // CUSTOMER
left outer join I_BillingDocumentPartner as bdps on bdps.BillingDocument = BDH.BillingDocument and bdps.PartnerFunction = 'AG' // SOLD TO PARTY 
left outer join I_BillingDocumentPartner as payy on payy.BillingDocument = BDH.BillingDocument and payy.PartnerFunction = 'RG' // Payer

left outer join I_ProductPlantBasic as HSN on HSN.Product = BDI.Product
                                          and HSN.Plant = BDI.Plant
left outer join I_Customer as CUS on CUS.Customer = BDP.Customer
left outer join I_Customer as PAY on PAY.Customer = payy.Customer
left outer join I_Customer as SOP on SOP.Customer = bdps.Customer
//left outer join I_Plant as PLT on PLT.Plant = BDI.Plant
left outer join I_SalesDocument as SD on SD.SalesDocument = BDI.SalesDocument

left outer join I_BillingDocumentBasic as bdb on bdb.BillingDocument =  BDH.BillingDocument
left outer join I_Product as pro on pro.Product = BDI.Product 
left outer join I_MaterialDocumentItem_2 as MAT on MAT.MaterialDocument = BDI.ReferenceSDDocument and MAT.MaterialDocumentItem = '0001'

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
BDI.Product as PRODUCT,
BDI.BillingDocumentItemText as PRODU,
HSN.ConsumptionTaxCtrlCode as HSNNO,
//@Semantics.unitOfMeasure: true
@EndUserText.label: 'Base of Unit'
@Semantics.unitOfMeasure: true
@ObjectModel.foreignKey.association: '_baseunit'  ///Change
BDI.BaseUnit,
BDI.BillingQuantityUnit as BILLQTUNIT,
@Semantics.quantity.unitOfMeasure: 'billqtunit'
BDI.BillingQuantity as BILLQTY,

case BDI.Plant
when '1010' then 'KMPT ROLLING DIVISION'
when '1020' then 'BTBR ROLLING DIVISION'
when '1030' then 'BRBR TLR DIVISION'
when '1040' then 'BTBR FASTNER DIVISION'
else 'Hello' end as PlantName,
BDI.StorageLocation as STRLOCT,
@Semantics.quantity.unitOfMeasure: 'BaseUnit'
BDI.ItemNetWeight as NETWEIGHT,
@Semantics.quantity.unitOfMeasure: 'BaseUnit'
BDI.ItemGrossWeight as GROSSWEIGHT,

//BDI.TransactionCurrency,
//@Semantics.amount.currencyCode: 'TransactionCurrency'
BDI.NetAmount,
//@Semantics.amount.currencyCode: 'TransactionCurrency'
BDI.TaxAmount,
//@Semantics.amount.currencyCode: 'TransactionCurrency'
@API.element: { releaseState: #DECOMMISSIONED, successor: 'TOTALAMT' }
cast(BDI.TaxAmount + BDI.NetAmount as abap.dec( 15, 2 ) ) as TOTALAMT,
//@Semantics.amount.currencyCode: 'TransactionCurrency'
cast(BDI.NetAmount - PCIP.ConditionAmount as abap.dec(15,2) )as AMTPCIP,
FREIGHT.ConditionCurrency as curr,
FREIGHT.ConditionRateRatioUnit as rt, //-----------------------------------------------------------------------------------------------------
//@Semantics.quantity.unitOfMeasure: 'rt'//-----------------------------------
//Freight.ConditionRateRatio as frate,//-------------------------------------------------------------------------------------------------------
@Semantics.amount.currencyCode: 'curr'
FREIGHT.ConditionAmount as FREIGHT,
@Semantics.amount.currencyCode: 'curr'
MATERIALVAL.ConditionAmount as MATERIALVAL,
@Semantics.quantity.unitOfMeasure: 'rt'   //===========
case when IGST.ConditionType = 'JOIG' then
round(cast(IGST.ConditionRateRatio  as abap.dec( 15,2)),0)
when IGST_1.ConditionType = 'ZOIG' then
round(cast(IGST_1.ConditionRateRatio  as abap.dec( 15,2)),0)
else 0 end
 as igstrate,
@Semantics.amount.currencyCode: 'curr'
case when IGST.ConditionType = 'JOIG' then
IGST.ConditionAmount
when IGST_1.ConditionType = 'ZOIG' then 
IGST_1.ConditionAmount else 0 end
as IGSTAMT,
@Semantics.quantity.unitOfMeasure: 'rt'
round(cast(CGST.ConditionRateRatio as abap.dec( 15, 2)),0) as cgstrate,
@Semantics.amount.currencyCode: 'curr'
CGST.ConditionAmount as CGSTAMT,
@Semantics.quantity.unitOfMeasure: 'rt'
round(cast(SGST.ConditionRateRatio as abap.dec( 15, 2)),0) as sgstrate,
@Semantics.amount.currencyCode: 'curr'
SGST.ConditionAmount as SGSTAMT,
@Semantics.amount.currencyCode: 'curr'
TCS.ConditionAmount,
@Semantics.amount.currencyCode: 'curr'
PCIP.ConditionAmount  as PCIPAMT,
@Semantics.amount.currencyCode: 'curr'
CESS.ConditionAmount as cessamt,
//@Semantics.amount.currencyCode: 'curr'
//ZTDS.ConditionAmount,
@Semantics.amount.currencyCode: 'curr'
ZOTH.ConditionAmount as otheramt,
BDI.PriceDetnExchangeRate as exchangerate,
BDI.ReferenceSDDocument as referencedoc,
BDI.SalesDocument as salesorder,
BDH.AccountingDocument as docno,
BDH.BillingDocumentIsCancelled as cancel,
BDH.CancelledBillingDocument as billcan,
SD.PurchaseOrderByCustomer as ponumber,
BDH.DocumentReferenceID as odino,
bdb.YY1_OrginalReferenceNo_BDH as dcodino,
BDI.ProductGroup as PRGROUP,
pro.ProductType as PRDCT,
MAT.PurchaseOrder,
BDI._BaseUnit
//BDI._TransactionCurrency    
}
