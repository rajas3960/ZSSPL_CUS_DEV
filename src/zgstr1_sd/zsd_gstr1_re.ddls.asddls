@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1 REPORT ROOT ENTITY VIEW'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZSD_GSTR1_RE as select from   I_BillingDocument as BDH 
inner join I_BillingDocumentItem as BDI on BDI.BillingDocument = BDH.BillingDocument and BDH.BillingDocumentType <> 'F8' and BDH.BillingDocumentType <> 'JSN' and BDH.BillingDocumentType <> 'F5' 
left outer join ZSD_BILLING_PRCDELEMT1 as IGST on IGST.BillingDocument = BDI.BillingDocument 
                                                       and IGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and IGST.ConditionType = 'JOIG'  // IGST
left outer join ZSD_BILLING_PRCDELEMT1 as IGST_1 on IGST_1.BillingDocument = BDI.BillingDocument 
                                                       and IGST_1.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and IGST_1.ConditionType = 'ZOIG' // export zoig
left outer join ZSD_BILLING_PRCDELEMT1 as CGST on CGST.BillingDocument = BDI.BillingDocument 
                                                       and CGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and CGST.ConditionType = 'JOCG'  // CGST
left outer join ZSD_BILLING_PRCDELEMT1 as SGST on SGST.BillingDocument = BDI.BillingDocument 
                                                       and SGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and SGST.ConditionType = 'JOSG'  // SGST
left outer join ZSD_BILLING_PRCDELEMT1 as CESS on CESS.BillingDocument = BDI.BillingDocument 
                                                       and CESS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and CESS.ConditionType = 'ZCOS'// CESS CONDITION  
left outer join ZSD_BILLING_PRCDELEMT1 as FREIGHT on FREIGHT.BillingDocument = BDI.BillingDocument //ZSD_BILLING_PRCDELEMT1
                                                       and FREIGHT.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and (FREIGHT.ConditionType = 'ZKF0' or FREIGHT.ConditionType = 'ZKF1')  and FREIGHT.ConditionInactiveReason <> 'M'
left outer join ZSD_BILLING_PRCDELEMT1 as TCS on TCS.BillingDocument = BDI.BillingDocument 
                                                       and TCS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and TCS.ConditionType = 'JTC1'//TCS
left outer join ZSD_BILLING_PRCDELEMT1 as ZTDS on ZTDS.BillingDocument = BDI.BillingDocument 
                                                       and ZTDS.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and ZTDS.ConditionType = 'ZTDS'// TCS SCARPS CHARGES 
left outer join ZSD_BILLING_PRCDELEMT1 as ZPR1 on ZPR1.BillingDocument = BDI.BillingDocument 
                                                       and ZPR1.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and ZPR1.ConditionType = 'ZPR1'// PRICING CONDITION BASE VALUE
left outer join ZSD_BILLING_PRCDELEMT1 as ZOTH on ZOTH.BillingDocument = BDI.BillingDocument 
                                                       and ZOTH.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and ZOTH.ConditionType = 'ZOTH'// OTHER CHARGES 
left outer join ZSD_BILLING_PRCDELEMT1 as PAKG1 on PAKG1.BillingDocument = BDI.BillingDocument 
                                                       and PAKG1.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PAKG1.ConditionType = 'ZPF1' // PAKAGE 1
left outer join ZSD_BILLING_PRCDELEMT1 as PAKG2 on PAKG2.BillingDocument = BDI.BillingDocument 
                                                       and PAKG2.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PAKG2.ConditionType = 'ZPF2' // PAKAGE 2
left outer join ZSD_BILLING_PRCDELEMT1 as PAKG3 on PAKG3.BillingDocument = BDI.BillingDocument 
                                                       and PAKG3.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PAKG3.ConditionType = 'ZPF3' // PAKAGE 3
left outer join ZSD_BILLING_PRCDELEMT1 as PAKG4 on PAKG4.BillingDocument = BDI.BillingDocument 
                                                       and PAKG4.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PAKG4.ConditionType = 'ZPF4' // PAKAGE 4
left outer join ZSD_BILLING_PRCDELEMT1 as PAKG5 on PAKG5.BillingDocument = BDI.BillingDocument 
                                                       and PAKG5.BillingDocumentItem = BDI.BillingDocumentItem
                                                       and PAKG5.ConditionType = 'ZPF5' // PAKAGE 5
left outer join I_ProductPlantBasic            as HSN    on  HSN.Product = BDI.Product
                                                             and HSN.Plant   = BDI.Plant
    left outer join I_Customer                     as CUS    on CUS.Customer = BDI.BillToParty
    left outer join I_CustomerGroupText            as CDC    on  CDC.CustomerGroup = BDH.CustomerGroup
                                                             and CDC.Language      = 'E'
    left outer join I_Region                       as REG    on  REG.Country = BDH.Country
    //                                                   AND REG.LANGUAGE = 'E'
                                                             and REG.Region  = BDH.Region

    left outer join I_Plant                        as PLA    on PLA.Plant = BDI.Plant

    left outer join I_IN_BusinessPlaceTaxDetail    as SUP    on SUP.BusinessPlace = PLA.BusinessPlace
    left outer join I_BillingDocumentBasic         as BSC    on BSC.BillingDocument = BDH.BillingDocument
    //association[0..1] to ZSD_JOURNALENT_V as _jeh on 1=1
    //*ZSD_JOURNALENT_V as JEH on JEH.AccountingDocument = BDH.AccountingDocument 
    left outer join I_JournalEntryItem as jei on jei.AccountingDocument = BDH.AccountingDocument 
                                        and jei.Ledger = '0L' and jei.LedgerGLLineItem = '000001' and jei.TaxCode <> '' and jei.FiscalYear = BDH.FiscalYear
    
    { 
          key BDI.BillingDocument as BILLDOC,
          key BDI.BillingDocumentItem as BILLITEM,
          key BDH.AccountingDocument as ACCDOC,
          key jei.AccountingDocumentItem as ACCITM,
          key BDH.CompanyCode as CMP,
          key BDH.FiscalYear as FISC,
             
          //case
         // when _jeh.AccountingDocumentType = 'DG' or _jeh.AccountingDocumentType = 'DR'
         //  then _jeh.DocumentReferenceID
         // else
          BDH.DocumentReferenceID  as REFDOC,
          BDH.BillingDocumentDate as BILLDATE,
          
          case 
          when BDH.BillingDocumentType = 'F2' then 'TAX INVOICE'
          when BDH.BillingDocumentType = 'G2' then 'CDNR'
          else null 
          end  as BILLINGTYPE, 
         
         BSC.YY1_OrginalReferenceNo_BDH as CUSTOMINV,
            
          HSN.ConsumptionTaxCtrlCode as HSNNO,
          BDI.BillingDocumentItemText as ITETTEXT,
          BDI.BillingQuantityUnit as UOM,
          @Semantics.quantity.unitOfMeasure: 'UOM'
          @Aggregation.default: #SUM @Aggregation.exception: #LAST
          BDI.BillingQuantity  as QUANTITY,
          case 
  when BDH.CancelledBillingDocument is not initial then 
    cast(((coalesce(get_numeric_value(ZPR1.ConditionAmount), 0) + 
           coalesce(get_numeric_value(ZOTH.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG1.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG2.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG3.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG4.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG5.ConditionAmount), 0) + 
           coalesce(get_numeric_value(FREIGHT.ConditionAmount), 0)) * 
           coalesce(BDI.PriceDetnExchangeRate, 1) * -1) 
         as abap.dec(15,2)) 
  else 
    cast(((coalesce(get_numeric_value(ZPR1.ConditionAmount), 0) + 
           coalesce(get_numeric_value(ZOTH.ConditionAmount), 0) + 
           coalesce(get_numeric_value(PAKG1.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG2.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG3.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG4.ConditionAmount), 0) +
           coalesce(get_numeric_value(PAKG5.ConditionAmount), 0) +
           coalesce(get_numeric_value(FREIGHT.ConditionAmount), 0)) * 
           coalesce(BDI.PriceDetnExchangeRate, 1)) 
         as abap.dec(15,2)) 
end as TOTTAXAMT,

         case when BDH.CancelledBillingDocument is not initial 
         then cast((((get_numeric_value(BDI.NetAmount)+ get_numeric_value( BDI.TaxAmount)) * get_numeric_value(BDI.PriceDetnExchangeRate))*-1)as abap.dec( 15,2 ))
         else cast(((get_numeric_value(BDI.NetAmount)+ get_numeric_value( BDI.TaxAmount)) * get_numeric_value(BDI.PriceDetnExchangeRate))as abap.dec( 15,2 )) end as TOTNETAMT,
         
          case
          when CGST.ConditionType = 'JOCG' or SGST.ConditionType = 'JOSG'
          then round(cast(SGST.ConditionRateValue as abap.dec( 15, 2)) + cast(SGST.ConditionRateValue as abap.dec( 15,2)),2)
          when IGST.ConditionType       = 'JOIG' then round(cast(IGST.ConditionRateValue as abap.dec( 15,2)),2)
          when IGST_1.ConditionType = 'ZOIG' then round(cast(IGST_1.ConditionRateValue as abap.dec( 15,2)),2)
          else  null 
          end as GSTRATE,
          @Semantics.amount.currencyCode: 'CGSTCURR'
          case when IGST.ConditionType       = 'JOIG' and BDH.CancelledBillingDocument is not initial 
          then
          cast((get_numeric_value(IGST.ConditionAmount) * (BDI.PriceDetnExchangeRate ) *-1) as abap.dec( 15,2 ))
          when IGST.ConditionType       = 'JOIG'
          then cast(get_numeric_value(IGST.ConditionAmount) * (BDI.PriceDetnExchangeRate )  as abap.dec( 15,2 ))
          when IGST_1.ConditionType       = 'ZOIG' and BDH.CancelledBillingDocument is not initial 
          then
          cast((get_numeric_value(IGST_1.ConditionAmount) * (BDI.PriceDetnExchangeRate ) -1 )as abap.dec( 15,2 ))
          when IGST_1.ConditionType       = 'ZOIG'
          then
          cast(get_numeric_value(IGST_1.ConditionAmount) * (BDI.PriceDetnExchangeRate ) as abap.dec( 15,2 ))
          else null end as IGSTAMT,
          CGST.ConditionCurrency as CGSTCURR,
          @Semantics.amount.currencyCode: 'CGSTCURR'
          case when BDH.CancelledBillingDocument is not initial  then
          cast(CGST.ConditionAmount *-1 as abap.dec(15,2)) else cast(CGST.ConditionAmount  as abap.dec(15,2)) end as CGSTAMT,
          @Semantics.amount.currencyCode: 'CGSTCURR'
          case when BDH.CancelledBillingDocument is not initial then
          cast(SGST.ConditionAmount *-1 as abap.dec(15,2)) else cast(SGST.ConditionAmount  as abap.dec(15,2)) end as SGATAMT,
          @Semantics.amount.currencyCode: 'CGSTCURR'
          CESS.ConditionAmount as CESSAMT,
          CUS.CustomerName   as CUSTNAME,
          CUS.TaxNumber3   as TAXNO2, 
      
          case
          when CUS.Region = 'AN' then '35' -- ANDAMAN AND NICOBAR ISLANDS
          when CUS.Region = 'AP' then '37' -- ANDHRA PRADESH
          when CUS.Region = 'AR' then '12' -- ARUNACHAL PRADESH
          when CUS.Region = 'AS' then '18' -- ASSAM
          when CUS.Region = 'BR' then '10' -- BIHAR
          when CUS.Region = 'CG' then '22' -- CHHATTISGARH
          when CUS.Region = 'CH' then '04' -- CHANDIGARH
          when CUS.Region = 'DD' then '26' -- DADRA AND NAGAR HAVELI AND DAMAN AND DIU
          when CUS.Region = 'DL' then '07' -- DELHI
          when CUS.Region = 'DH' then '26' -- DADRA AND NAGAR HAVELI AND DAMAN AND DIU (DUPLICATE OF DD)
          when CUS.Region = 'GA' then '30' -- GOA
          when CUS.Region = 'GJ' then '24' -- GUJARAT
          when CUS.Region = 'HP' then '02' -- HIMACHAL PRADESH
          when CUS.Region = 'HR' then '06' -- HARYANA
          when CUS.Region = 'JH' then '20' -- JHARKHAND
          when CUS.Region = 'JK' then '01' -- JAMMU AND KASHMIR
          when CUS.Region = 'KA' then '29' -- KARNATAKA
          when CUS.Region = 'KL' then '32' -- KERALA
          when CUS.Region = 'LA' then '38' -- LADAKH
          when CUS.Region = 'LD' then '31' -- LAKSHADWEEP
          when CUS.Region = 'MH' then '27' -- MAHARASHTRA
          when CUS.Region = 'ML' then '17' -- MEGHALAYA
          when CUS.Region = 'MN' then '14' -- MANIPUR
          when CUS.Region = 'MP' then '23' -- MADHYA PRADESH
          when CUS.Region = 'MZ' then '15' -- MIZORAM
          when CUS.Region = 'NL' then '13' -- NAGALAND
          when CUS.Region = 'OD' then '21' -- ODISHA
          when CUS.Region = 'PB' then '03' -- PUNJAB
          when CUS.Region = 'PY' then '34' -- PUDUCHERRY
          when CUS.Region = 'RJ' then '08' -- RAJASTHAN
          when CUS.Region = 'SK' then '11' -- SIKKIM
          when CUS.Region = 'TS' then '36' -- TELANGANA
          when CUS.Region = 'TN' then '33' -- TAMIL NADU
          when CUS.Region = 'TR' then '16' -- TRIPURA
          when CUS.Region = 'UK' then '05' -- UTTARAKHAND
          when CUS.Region = 'UP' then '09' -- UTTAR PRADESH
          when CUS.Region = 'WB' then '19' -- WEST BENGAL
          when BDH.DistributionChannel = '20'then '97'
          else null
          end as STATECODE,
          
          case 
          when BDH.DistributionChannel =  '10' and  CUS.TaxNumber3 = ''  then 'B2C'
          when BDH.DistributionChannel =  '10' and  CUS.TaxNumber3 <> ''  then 'B2B'
          when BDH.DistributionChannel = '20'then 'EXP'
          else null 
          end as SALESTYPE,
          
         /* case when BDI.TaxCode = 'A1' then 'DEEMED EXPORT 0.1%'
          when BDI.TaxCode = 'E0' then 'LUT 0%'
          when BDI.TaxCode = 'E1' then 'IGST 18%' 
          else null 
          end as EXPORTTYPE,*/
          case 
         when IGST_1.ConditionType = 'ZOIG' and IGST_1.TaxCode = 'AC'
         then 'WPAY'
         when IGST_1.ConditionType = 'ZOIG' and IGST_1.TaxCode = 'A0'
         then 'WOPAY'
         when IGST_1.ConditionType = 'ZOIG' and IGST_1.TaxCode = 'AD'
         then 'WPAY'
          when IGST_1.ConditionType = 'ZOIG' and IGST_1.TaxCode = 'AA'
         then 'WPAY'
         when IGST_1.ConditionType = 'ZOIG' and IGST_1.TaxCode = 'A1'
         then 'WPAY'
         else null
          end as EXPORTTYPE,
          
        BDH.BillingDocumentDate as FIDATE,
        BDH.BillingDocumentIsCancelled as cancel,
BDH.CancelledBillingDocument as billcan,
CUS.Customer,
PLA.Plant,
PLA.PlantName,
@Semantics.amount.currencyCode: 'CGSTCURR'
          case when FREIGHT.ConditionType = 'ZKF0'
     then FREIGHT.ConditionAmount
     when FREIGHT.ConditionType = 'ZKF1'
     then FREIGHT.ConditionAmount
     else cast( 0.0 as abap.curr(15,2) ) 
end as FREIGHT,
@Semantics.amount.currencyCode: 'CGSTCURR'
TCS.ConditionAmount as tcsamt,
@Semantics.amount.currencyCode: 'CGSTCURR'
ZTDS.ConditionAmount as tcssrap,
@Semantics.amount.currencyCode: 'CGSTCURR'
ZOTH.ConditionAmount as otheramt,
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG1.ConditionAmount as PAKG1AMT,
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG2.ConditionAmount as PAKG2AMT,
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG3.ConditionAmount as PAKG3AMT,
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG4.ConditionAmount as PAKG4AMT,
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG5.ConditionAmount as PAKG5AMT,

      ZPR1.ConditionQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      case when BDH.CancelledBillingDocument is not initial  
       then 
      ZPR1.ConditionBaseQuantity  * -1
      else
      ZPR1.ConditionBaseQuantity end   as QTY                                                                

          /* association */
          //_jeh

} 
union all select from ZSD_JOURNALENT_V as jeh 
inner join I_JournalEntryItem as jei on jei.AccountingDocument = jeh.AccountingDocument 
                                        and jei.Ledger = '0L' and jei.LedgerGLLineItem = '000001' and jei.TaxCode <> '' and jei.FiscalYear = jeh.FiscalYear
left outer join I_Customer                     as CUS    on CUS.Customer = jei.Customer
left outer join I_OperationalAcctgDocItem as aci on aci.AccountingDocument = jei.AccountingDocument
                                             and aci.FiscalYear = jei.FiscalYear and aci.ProfitCenter <>''
 left outer join I_OperationalAcctgDocItem as CGST on CGST.AccountingDocument = aci.AccountingDocument
                                               and CGST.FiscalYear = aci.FiscalYear and CGST.TaxItemGroup = aci.TaxItemGroup
                                               and CGST.AccountingDocumentItemType = 'T'
                                               and CGST.TransactionTypeDetermination = 'JOC'                                              
      left outer join I_OperationalAcctgDocItem as IGST on IGST.AccountingDocument = aci.AccountingDocument
                                               and IGST.FiscalYear = aci.FiscalYear and IGST.TaxItemGroup = aci.TaxItemGroup 
                                               and IGST.AccountingDocumentItemType = 'T'
                                               and IGST.TransactionTypeDetermination = 'JOI'
   left outer join I_Plant as PLT on PLT.Plant = jei.Plant
{
key '' as BILLDOC, 
key cast('' as abap.numc(6)) as BILLITEM,
key aci.AccountingDocument as ACCDOC,
key aci.AccountingDocumentItem as ACCITM,
key aci.CompanyCode as CMP,
key aci.FiscalYear as FISC,
jeh.DocumentReferenceID  as REFDOC,
jeh.DocumentDate as BILLDATE,
case 
          when jeh.AccountingDocumentType = 'DR' then 'DR'
          when jeh.AccountingDocumentType = 'DG' then 'DG'
          else null 
          end  as BILLINGTYPE, 
' 'as CUSTOMINV,
'' as HSNNO,
        '' as ITETTEXT,
          cast('' as abap.unit(3)) as UOM,
         
         cast( 0 as abap.quan(13,3) ) as QUANTITY,
case
when jeh.AccountingDocumentType = 'DR' 
then
 cast((get_numeric_value(aci.AmountInTransactionCurrency) * -1) as abap.dec( 15,2 ))
 when
 jeh.AccountingDocumentType = 'DG' 
then
cast((get_numeric_value(aci.AmountInTransactionCurrency)* -1) as abap.dec( 15,2 ))
else null end as TOTTAXAMT,
 case
           when CGST.TransactionTypeDetermination = 'JOC' and jeh.AccountingDocumentType = 'DR' 
          then cast((CGST.AmountInTransactionCurrency + CGST.AmountInTransactionCurrency + aci.AmountInTransactionCurrency ) * (-1) as abap.dec(15,2) )  // CHANGE CURR TO DEC
             when CGST.TransactionTypeDetermination = 'JOC' and jeh.AccountingDocumentType = 'DG' 
          then cast((CGST.AmountInTransactionCurrency + CGST.AmountInTransactionCurrency + aci.AmountInTransactionCurrency ) * (-1) as abap.dec(15,2) )
          when IGST.TransactionTypeDetermination = 'JOI'  and jeh.AccountingDocumentType = 'DG' 
          then cast((IGST.AmountInTransactionCurrency + aci.AmountInTransactionCurrency)* (-1) as abap.dec(15,2))
          when IGST.TransactionTypeDetermination = 'JOI'  and jeh.AccountingDocumentType = 'DR' 
          then cast((IGST.AmountInTransactionCurrency + aci.AmountInTransactionCurrency) * (-1) as abap.dec(15,2))
          else cast(aci.AmountInTransactionCurrency * -1 as abap.dec(15,2) ) end  as TOTNETAMT,
          
          case
    when CGST.TransactionTypeDetermination = 'JOC' or CGST.TransactionTypeDetermination = 'JOS' then
        case aci.TaxCode
            when 'AE' then cast(0.00 as abap.dec(15,2))
            when 'AF' then cast(5.00 as abap.dec(15,2))
            when 'AG' then cast(12.00 as abap.dec(15,2))
            when 'AH' then cast(18.00 as abap.dec(15,2))
            when 'AI' then cast(28.00 as abap.dec(15,2))
            when 'AJ' then cast(0.10 as abap.dec(15,2))
            else null
        end
    when IGST.TransactionTypeDetermination = 'JOI' then
        case aci.TaxCode
            when 'A0' then cast(0.00 as abap.dec(15,2))
            when 'A1' then cast(0.10 as abap.dec(15,2))
            when 'AA' then cast(5.00 as abap.dec(15,2))
            when 'AB' then cast(12.00 as abap.dec(15,2))
            when 'AC' then cast(18.00 as abap.dec(15,2))
            when 'AD' then cast(28.00 as abap.dec(15,2))
            else null
        end
    else cast(0.00 as abap.dec(15,2))
end as GSTRATE,

case 
when jeh.AccountingDocumentType = 'DR'
then
cast(IGST.AmountInTransactionCurrency * -1 as abap.dec(15,2))
when jeh.AccountingDocumentType = 'DG'
then
cast(IGST.AmountInTransactionCurrency * -1 as abap.dec(15,2))
else  null end as IGSTAMT,
aci.TransactionCurrency as CGSTCURR,
case 
when jeh.AccountingDocumentType = 'DR'
then
cast(CGST.AmountInTransactionCurrency * -1 as abap.dec(15,2)) 
when jeh.AccountingDocumentType = 'DG'
then
cast(CGST.AmountInTransactionCurrency * -1 as abap.dec(15,2)) 
 else null end as cgstamt,

case 
when jeh.AccountingDocumentType = 'DR'
then
cast(CGST.AmountInTransactionCurrency * -1 as abap.dec(15,2))  
when jeh.AccountingDocumentType = 'DG'
then
cast(CGST.AmountInTransactionCurrency * -1 as abap.dec(15,2))
else null end
as SGATAMT,

          cast(0 as abap.curr(15,2)) as CESSAMT,
CUS.CustomerName   as CUSTNAME,
CUS.TaxNumber3   as TAXNO2 ,
case
          when CUS.Region = 'AN' then '35' -- ANDAMAN AND NICOBAR ISLANDS
          when CUS.Region = 'AP' then '37' -- ANDHRA PRADESH
          when CUS.Region = 'AR' then '12' -- ARUNACHAL PRADESH
          when CUS.Region = 'AS' then '18' -- ASSAM
          when CUS.Region = 'BR' then '10' -- BIHAR
          when CUS.Region = 'CG' then '22' -- CHHATTISGARH
          when CUS.Region = 'CH' then '04' -- CHANDIGARH
          when CUS.Region = 'DD' then '26' -- DADRA AND NAGAR HAVELI AND DAMAN AND DIU
          when CUS.Region = 'DL' then '07' -- DELHI
          when CUS.Region = 'DH' then '26' -- DADRA AND NAGAR HAVELI AND DAMAN AND DIU (DUPLICATE OF DD)
          when CUS.Region = 'GA' then '30' -- GOA
          when CUS.Region = 'GJ' then '24' -- GUJARAT
          when CUS.Region = 'HP' then '02' -- HIMACHAL PRADESH
          when CUS.Region = 'HR' then '06' -- HARYANA
          when CUS.Region = 'JH' then '20' -- JHARKHAND
          when CUS.Region = 'JK' then '01' -- JAMMU AND KASHMIR
          when CUS.Region = 'KA' then '29' -- KARNATAKA
          when CUS.Region = 'KL' then '32' -- KERALA
          when CUS.Region = 'LA' then '38' -- LADAKH
          when CUS.Region = 'LD' then '31' -- LAKSHADWEEP
          when CUS.Region = 'MH' then '27' -- MAHARASHTRA
          when CUS.Region = 'ML' then '17' -- MEGHALAYA
          when CUS.Region = 'MN' then '14' -- MANIPUR
          when CUS.Region = 'MP' then '23' -- MADHYA PRADESH
          when CUS.Region = 'MZ' then '15' -- MIZORAM
          when CUS.Region = 'NL' then '13' -- NAGALAND
          when CUS.Region = 'OD' then '21' -- ODISHA
          when CUS.Region = 'PB' then '03' -- PUNJAB
          when CUS.Region = 'PY' then '34' -- PUDUCHERRY
          when CUS.Region = 'RJ' then '08' -- RAJASTHAN
          when CUS.Region = 'SK' then '11' -- SIKKIM
          when CUS.Region = 'TS' then '36' -- TELANGANA
          when CUS.Region = 'TN' then '33' -- TAMIL NADU
          when CUS.Region = 'TR' then '16' -- TRIPURA
          when CUS.Region = 'UK' then '05' -- UTTARAKHAND
          when CUS.Region = 'UP' then '09' -- UTTAR PRADESH
          when CUS.Region = 'WB' then '19' -- WEST BENGAL
          //when BDH.DistributionChannel = '20'then '97'
          else null
          end as STATECODE,
          
          case 
          when   CUS.TaxNumber3 = ''  then 'B2C'
          when   CUS.TaxNumber3 <> ''  then 'B2B'
          when CUS.TaxNumber3= 'f'  then 'EXP'
          else null 
          end as SALESTYPE,
          
         /* case when BDI.TaxCode = 'A1' then 'DEEMED EXPORT 0.1%'
          when BDI.TaxCode = 'E0' then 'LUT 0%'
          when BDI.TaxCode = 'E1' then 'IGST 18%' 
          else null 
          end as EXPORTTYPE,*/
          case 
          when jeh.CompanyCode = '20' then 'WPAY'
          when jeh.CompanyCode = '20' and jeh.AccountingDocument = '09' then 'WOPAY'
          else null 
          end as EXPORTTYPE,
          
         
          jeh.DocumentDate as FIDATE,
          '' as cancel,
          '' as billcan,
          CUS.Customer,
          PLT.Plant,
          PLT.PlantName,
          cast( 0.0 as abap.curr(15,2) )  as FREIGHT,
          cast( 0.0 as abap.curr(15,2) ) as tcsamt,
          cast( 0.0 as abap.curr(15,2) ) as tcssrap,
          cast( 0.0 as abap.curr(15,2) ) as otheramt,
          cast( 0.0 as abap.curr(15,2) ) as PAKG1AMT,        
          cast( 0.0 as abap.curr(15,2) )  as PAKG2AMT,
          cast( 0.0 as abap.curr(15,2) ) as PAKG3AMT,
          cast( 0.0 as abap.curr(15,2) ) as PAKG4AMT,
          cast( 0.0 as abap.curr(15,2) ) as PAKG5AMT,
          
          cast('' as abap.unit(3) ) as ConditionQuantityUnit,
          
          cast(0 as abap.dec( 24, 9 )) as qty
          
          
          
}








