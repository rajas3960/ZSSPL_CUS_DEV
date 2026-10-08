@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity - Sales Reports'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_SALER_RE
  as select from    I_BillingDocument              as BDH
    inner join      I_BillingDocumentItem          as BDI         on BDI.BillingDocument = BDH.BillingDocument
    left outer join ZSD_BILLING_PRCDELEMT as FREIGHT     on  FREIGHT.BillingDocument         =  BDI.BillingDocument //I_BillingDocumentItemPrcgElmnt
                                                                  and FREIGHT.BillingDocumentItem     =  BDI.BillingDocumentItem
                                                                  and (
                                                                     FREIGHT.ConditionType            =  'ZKF0'
                                                                     or FREIGHT.ConditionType         =  'ZKF1'
                                                                   )
                                                                  and FREIGHT.ConditionInactiveReason <> 'M'
                                                                  and FREIGHT.ConditionAmount         <> 0.0 // FREIGHT
    left outer join ZSD_BILLING_PRCDELEMT as MATERIALVAL on  MATERIALVAL.BillingDocument     = BDI.BillingDocument
                                                                  and MATERIALVAL.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and MATERIALVAL.ConditionType       = 'ZPR1' // MATERIAL VALUE
    left outer join ZSD_BILLING_PRCDELEMT as IGST        on  IGST.BillingDocument     = BDI.BillingDocument
                                                                  and IGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and IGST.ConditionType       = 'JOIG' // IGST
    left outer join ZSD_BILLING_PRCDELEMT as IGST_1      on  IGST_1.BillingDocument     = BDI.BillingDocument
                                                                  and IGST_1.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and IGST_1.ConditionType       = 'ZOIG' // IGST
    left outer join ZSD_BILLING_PRCDELEMT as CGST        on  CGST.BillingDocument     = BDI.BillingDocument
                                                                  and CGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and CGST.ConditionType       = 'JOCG'  // CGST
    left outer join ZSD_BILLING_PRCDELEMT as SGST        on  SGST.BillingDocument     = BDI.BillingDocument
                                                                  and SGST.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and SGST.ConditionType       = 'JOSG'  // SGST
    left outer join ZSD_BILLING_PRCDELEMT as TCS         on  TCS.BillingDocument     = BDI.BillingDocument
                                                                  and TCS.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and TCS.ConditionType       = 'JTC1' //TCS
    left outer join ZSD_BILLING_PRCDELEMT as PCIP        on  PCIP.BillingDocument     = BDI.BillingDocument
                                                                  and PCIP.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PCIP.ConditionType       = 'PCIP' //PCIP
    left outer join ZSD_BILLING_PRCDELEMT as CESS        on  CESS.BillingDocument     = BDI.BillingDocument
                                                                  and CESS.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and CESS.ConditionType       = 'ZCOS' // CESS CONDITION
    left outer join ZSD_BILLING_PRCDELEMT as ZTDS        on  ZTDS.BillingDocument     = BDI.BillingDocument
                                                                  and ZTDS.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and ZTDS.ConditionType       = 'ZTDS' // TCS SCARPS CHARGES
    left outer join ZSD_BILLING_PRCDELEMT as ZOTH        on  ZOTH.BillingDocument     = BDI.BillingDocument
                                                                  and ZOTH.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and ZOTH.ConditionType       = 'ZOTH' // OTHER CHARGES
    left outer join ZSD_BILLING_PRCDELEMT as PAKG1       on  PAKG1.BillingDocument     = BDI.BillingDocument
                                                                  and PAKG1.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PAKG1.ConditionType       = 'ZPF1' // PAKAGE 1
    left outer join ZSD_BILLING_PRCDELEMT as PAKG2       on  PAKG2.BillingDocument     = BDI.BillingDocument
                                                                  and PAKG2.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PAKG2.ConditionType       = 'ZPF2' // PAKAGE 2
    left outer join ZSD_BILLING_PRCDELEMT as PAKG3       on  PAKG3.BillingDocument     = BDI.BillingDocument
                                                                  and PAKG3.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PAKG3.ConditionType       = 'ZPF3' // PAKAGE 3
    left outer join ZSD_BILLING_PRCDELEMT as PAKG4       on  PAKG4.BillingDocument     = BDI.BillingDocument
                                                                  and PAKG4.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PAKG4.ConditionType       = 'ZPF4' // PAKAGE 4
    left outer join ZSD_BILLING_PRCDELEMT as PAKG5       on  PAKG5.BillingDocument     = BDI.BillingDocument
                                                                  and PAKG5.BillingDocumentItem = BDI.BillingDocumentItem
                                                                  and PAKG5.ConditionType       = 'ZPF5' // PAKAGE 5

    left outer join I_BillingDocumentPartner       as BDP         on  BDP.BillingDocument = BDI.BillingDocument
                                                                  and BDP.PartnerFunction = 'RE' // CUSTOMER
    left outer join I_BillingDocumentPartner       as bdps        on  bdps.BillingDocument = BDH.BillingDocument
                                                                  and bdps.PartnerFunction = 'AG' // SOLD TO PARTY
    left outer join I_BillingDocumentPartner       as payy        on  payy.BillingDocument = BDH.BillingDocument
                                                                  and payy.PartnerFunction = 'RG' // Payer

    left outer join I_ProductPlantBasic            as HSN         on  HSN.Product = BDI.Product
                                                                  and HSN.Plant   = BDI.Plant
    left outer join I_Customer                     as CUS         on CUS.Customer = BDP.Customer
    left outer join I_Customer                     as PAY         on PAY.Customer = payy.Customer
    left outer join I_Customer                     as SOP         on SOP.Customer = bdps.Customer
  //left outer join I_Plant as PLT on PLT.Plant = BDI.Plant
    left outer join I_SalesDocument                as SD          on SD.SalesDocument = BDI.SalesDocument

    left outer join I_BillingDocumentBasic         as bdb         on bdb.BillingDocument = BDH.BillingDocument
   
    left outer join I_Product                      as pro         on pro.Product = BDI.Product
    left outer join I_MaterialDocumentItem_2       as MAT         on  MAT.MaterialDocument     = BDI.ReferenceSDDocument
                                                                  and MAT.MaterialDocumentItem = '0001'

{
  key BDH.BillingDocument                                                                                     as BILLDOC,
  key BDI.BillingDocumentItem                                                                                 as BILLITNO,
      BDH.CompanyCode                                                                                         as CMPC,
      BDH.SalesOrganization                                                                                   as SALESORG,
      BDH.DistributionChannel                                                                                 as DISTCHLN,
      BDH.Division,
      BDH.BillingDocumentType                                                                                 as BILLDCTY,
      BDH.BillingDocumentDate                                                                                 as BILLDT,
      BDP.Customer                                                                                            as BILLTOPARTY,
      CUS.CustomerName                                                                                        as BILLTOPARTYNAME,
      BDH.PayerParty                                                                                          as PAYER,
      PAY.CustomerName                                                                                        as PAYERNAME,
      BDH.SoldToParty,
      SOP.CustomerName                                                                                        as SOLDTOPARTYNAME,
      CUS.TaxNumber3                                                                                          as GSTNO,
      BDI.Product                                                                                             as PRODUCT,
      BDI.BillingDocumentItemText                                                                             as PRODU,
      HSN.ConsumptionTaxCtrlCode                                                                              as HSNNO,
      BDI.BaseUnit                                                                                            as uom,
      BDI.BillingQuantityUnit                                                                                 as BILLQTUNIT,
      @Semantics.quantity.unitOfMeasure: 'billqtunit'
      case when BDH.CancelledBillingDocument is not initial 
      then 
      BDI.BillingQuantity  * -1
      else 
      BDI.BillingQuantity
      end   
      as BILLQTY,
      
      case BDI.Plant
      when '1010' then 'KMPT ROLLING DIVISION'
      when '1020' then 'BTBR ROLLING DIVISION'
      when '1030' then 'BTBR TLT DIVISION'
      when '1040' then 'BTBR FASTNER DIVISION'
      else null end                                                                                           as PlantName,
      BDI.StorageLocation                                                                                     as STRLOCT,
      @Semantics.quantity.unitOfMeasure: 'uom'
      case when BDH.CancelledBillingDocument is not initial 
       then 
      BDI.ItemNetWeight * -1
      else
        BDI.ItemNetWeight 
        end  as NETWEIGHT,
      @Semantics.quantity.unitOfMeasure: 'uom'
         case when BDH.CancelledBillingDocument is not initial  
       then
      BDI.ItemGrossWeight  * -1
       else
       BDI.ItemGrossWeight 
        end as GROSSWEIGHT,
      BDI.TransactionCurrency                                                                                 as CURRENCY,
      @Semantics.amount.currencyCode: 'CURRENCY'
      case when BDH.CancelledBillingDocument is not initial  
       then 
       cast(((get_numeric_value(BDI.NetAmount)) * (BDI.PriceDetnExchangeRate)*-1) as abap.dec( 15,2 )) 
       else
       cast((get_numeric_value(BDI.NetAmount)) * (BDI.PriceDetnExchangeRate) as abap.dec( 15,2 )) 
       end as netamt,
       
      @Semantics.amount.currencyCode: 'CURRENCY'
      case when BDH.CancelledBillingDocument is not initial  
      then
      cast(BDI.TaxAmount *-1 as abap.curr(15,2))
      else
      BDI.TaxAmount end                                                                                       as taxamt,
      @Semantics.amount.currencyCode: 'CURRENCY'
      case when BDH.CancelledBillingDocument is not initial  
      then cast((BDI.TaxAmount + BDI.NetAmount) *-1 as abap.dec( 15, 2 ) )
      else
      cast(BDI.TaxAmount + BDI.NetAmount as abap.dec( 15, 2 ) ) end                                           as TOTALAMT,
      @Semantics.amount.currencyCode: 'CURRENCY'
       case when BDH.CancelledBillingDocument is not initial  
       then 
      cast(BDI.NetAmount - PCIP.ConditionAmount as abap.dec(15,2) ) *-1
       else
       cast(BDI.NetAmount - PCIP.ConditionAmount as abap.dec(15,2) ) end as AMTPCIP,
      FREIGHT.ConditionCurrency                                                                               as curr,
      FREIGHT.ConditionRateRatioUnit                                                                          as rt, //-----------------------------------------------------------------------------------------------------
      //@Semantics.quantity.unitOfMeasure: 'rt'//-----------------------------------
      //Freight.ConditionRateRatio as frate,//-------------------------------------------------------------------------------------------------------
      @Semantics.amount.currencyCode: 'curr'
      case when FREIGHT.ConditionType = 'ZKF0' and BDH.CancelledBillingDocument is not initial
      then FREIGHT.ConditionAmount * -1
      when FREIGHT.ConditionType = 'ZKF0'
      then FREIGHT.ConditionAmount
      when FREIGHT.ConditionType = 'ZKF1' and BDH.CancelledBillingDocument is not initial  
      then FREIGHT.ConditionAmount * -1
       when FREIGHT.ConditionType = 'ZKF1'
       then FREIGHT.ConditionAmount 
      else null end                                                                                           as FREIGHT,
      @Semantics.amount.currencyCode: 'curr'
           case when BDH.CancelledBillingDocument is not initial  
       then 
      MATERIALVAL.ConditionAmount   *-1
      else 
       MATERIALVAL.ConditionAmount 
       end as MATERIALVAL,
//      @Semantics.quantity.unitOfMeasure: 'rt' //===========
      case when IGST.ConditionType = 'JOIG' then
      round(cast(IGST.ConditionRateRatio as abap.dec(15,2)),2)
      when IGST_1.ConditionType = 'ZOIG' then
      round(cast(IGST_1.ConditionRateRatio  as abap.dec( 15,2)),2)
      else null end                                                                                           as igstrate,
      @Semantics.amount.currencyCode: 'curr'
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
               else null end                                                                                  as IGSTAMT,
//      @Semantics.quantity.unitOfMeasure: 'rt'
      round(cast(CGST.ConditionRateRatio as abap.dec( 15, 2)),2)                                              as cgstrate,
      @Semantics.amount.currencyCode: 'curr'
      case when BDH.CancelledBillingDocument is not initial 
      then
      cast(CGST.ConditionAmount * -1 as abap.curr( 15,2)) else CGST.ConditionAmount end                       as CGSTAMT,
//      @Semantics.quantity.unitOfMeasure: 'rt'
      round(cast(SGST.ConditionRateRatio as abap.dec( 15, 2)),2)                                              as sgstrate,
      @Semantics.amount.currencyCode: 'curr'
      case when BDH.CancelledBillingDocument is not initial 
      then
      cast(SGST.ConditionAmount *-1 as abap.curr(15,2)) else SGST.ConditionAmount end                         as SGSTAMT,
      @Semantics.amount.currencyCode: 'curr'
        case when BDH.CancelledBillingDocument is not initial 
       then 
      TCS.ConditionAmount *-1
      else
        TCS.ConditionAmount end as TCS,
      @Semantics.amount.currencyCode: 'curr'
        case when BDH.CancelledBillingDocument is not initial then
      PCIP.ConditionAmount  * -1
      else PCIP.ConditionAmount
       end as PCIPAMT,
      @Semantics.amount.currencyCode: 'curr'
      case when BDH.CancelledBillingDocument is not initial 
       then 
      CESS.ConditionAmount * -1
      else 
       CESS.ConditionAmount end as cessamt,
      @Semantics.amount.currencyCode: 'curr'
        case when BDH.CancelledBillingDocument is not initial
       then 
      ZTDS.ConditionAmount * -1
      else 
          ZTDS.ConditionAmount end as tcssamt,
      @Semantics.amount.currencyCode: 'curr'
        case when BDH.CancelledBillingDocument is not initial  or
       (BDH.BillingDocumentType = 'F8' and BDH.AccountingTransferStatus = 'E') or 
       (BDH.BillingDocumentType = 'JSN' and BDH.AccountingTransferStatus = 'E')
       then 
      ZOTH.ConditionAmount * -1
      else 
         ZOTH.ConditionAmount end as otheramt,
      BDI.PriceDetnExchangeRate                                                                               as exchangerate,
      BDI.ReferenceSDDocument                                                                                 as referencedoc,
      BDI.SalesDocument                                                                                       as salesorder,
      BDH.AccountingDocument                                                                                  as docno,
//      case when BDH.BillingDocumentType = 'F8' and BDH.AccountingTransferStatus = 'E'
//      then 'X'
//      when BDH.BillingDocumentType = 'JSN' and BDH.AccountingTransferStatus = 'E'
//      then 'X'
//      when BDH.BillingDocumentType = 'F5' and BDH.AccountingTransferStatus = 'E'
//      then 'X'
//      else
//      cast(BDH.BillingDocumentIsCancelled as abap.char(1)) end as cancel,
case 
  when (BDH.BillingDocumentType = 'F8' or 
        BDH.BillingDocumentType = 'JSN' or 
        BDH.BillingDocumentType = 'F5') 
       and BDH.AccountingTransferStatus = 'E'
    then 'X'
  when BDH.BillingDocumentIsCancelled = 'X'
    then 'X'
  else '' 
end as cancel,
//cast(
//  case 
//    when (BDH.BillingDocumentType = 'F8' or 
//          BDH.BillingDocumentType = 'JSN' or 
//          BDH.BillingDocumentType = 'F5') 
//         and BDH.AccountingTransferStatus = 'E'
//      then 'X'
//    when BDH.BillingDocumentIsCancelled = 'X'
//      then 'X'
//    else ''
//  end as abap.char(1)
//) as cancel,
      BDH.CancelledBillingDocument                                                                            as billcan,
      SD.PurchaseOrderByCustomer                                                                              as ponumber,
      BDH.DocumentReferenceID                                                                                 as odino,
      bdb.YY1_OrginalReferenceNo_BDH                                                                          as dcodino,
      BDI.ProductGroup                                                                                        as PRGROUP,
      pro.ProductType                                                                                         as PRDCT,
      MAT.PurchaseOrder,
      @Semantics.amount.currencyCode: 'curr'
      PAKG1.ConditionAmount                                                                                   as PAKG1AMT,
      @Semantics.amount.currencyCode: 'curr'
      PAKG2.ConditionAmount                                                                                   as PAKG2AMT,
      @Semantics.amount.currencyCode: 'curr'
      PAKG3.ConditionAmount                                                                                   as PAKG3AMT,
      @Semantics.amount.currencyCode: 'curr'
      PAKG4.ConditionAmount                                                                                   as PAKG4AMT,
      @Semantics.amount.currencyCode: 'curr'
      PAKG5.ConditionAmount                                                                                   as PAKG5AMT,
      MATERIALVAL.ConditionQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
      case when BDH.CancelledBillingDocument is not initial  
       then 
      MATERIALVAL.ConditionBaseQuantity  * -1
      else
      MATERIALVAL.ConditionBaseQuantity end                                                                   as NETWEIGHTD
      
      



}
