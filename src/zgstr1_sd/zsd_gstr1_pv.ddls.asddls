 @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gstr1 Projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_GSTR1_PV
  provider contract transactional_query
  as projection on ZSD_GSTR1_RE  
{
    key BILLDOC,                                                    // Billing no
    key BILLITEM,    
    key ACCDOC,                                                // billing it
    key ACCITM,
    key CMP,
    key FISC,
    REFDOC,                                                         // invoice no  
    BILLDATE,                                                       // date
    BILLINGTYPE,                                                    // F2 OR G2 TAX INVOICE OR CDNR
    CUSTOMINV,                                                      // CUSTOM INVOICE NO
    HSNNO,                                                          // HSN
    ITETTEXT,                                                       // DESC
    UOM,                                                            // UNIT OF MEASUREMENT
     @Semantics.quantity.unitOfMeasure: 'UOM'                       // UNIT
    
    QUANTITY,                                                       // QUANTITY
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    TOTTAXAMT,                                                      // NETAMOUNT
     @Aggregation.default: #SUM @Aggregation.exception: #LAST
    TOTNETAMT,                                                      // TOTAL NETAMOUNT + TAX AMOUNT
    GSTRATE,                                                        // RATE
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    @Semantics.amount.currencyCode: 'CGSTCURR'
    IGSTAMT,                                                        // IGST AMOUNT
    CGSTCURR,                                                       // CURR
    @Semantics.amount.currencyCode: 'CGSTCURR'
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    CGSTAMT,                                                        // CGST AMOUNT
    @Semantics.amount.currencyCode: 'CGSTCURR'
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    SGATAMT,                                                        // SGST AMOUNT
    @Semantics.amount.currencyCode: 'CGSTCURR'
    @Aggregation.default: #SUM @Aggregation.exception: #LAST
    CESSAMT,                                                        // CESS AMOUNT
    CUSTNAME,                                                       // VENDOR NAME
    TAXNO2,                                                         // VENDOR GSTNO
    STATECODE,                                                      // GST CODE
    SALESTYPE,                                                      // SALES TYPE B2C,B2B,EXP
    EXPORTTYPE,                                                     // EXPORT TYPE
                                                            // ACCOUTING DOCUMENT
    FIDATE ,
    cancel,
    billcan,
    Customer  ,
    Plant,
    PlantName   ,
    @Semantics.amount.currencyCode: 'CGSTCURR'
    FREIGHT, 
     @Semantics.amount.currencyCode: 'CGSTCURR'  
    tcsamt, 
     @Semantics.amount.currencyCode: 'CGSTCURR'                                               
    tcssrap,
    @Semantics.amount.currencyCode: 'CGSTCURR'
     @EndUserText.label: 'Other Charges'
 otheramt,
 @EndUserText.label: 'Box Packaging fee'
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG1AMT,
 @EndUserText.label: 'Tower Packaging fee'
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG2AMT,
@EndUserText.label: 'Panal Packaging fee'
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG3AMT,
@EndUserText.label: 'Painting Packing fee'
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG4AMT,
@EndUserText.label: 'Bundling packing fee'
@Semantics.amount.currencyCode: 'CGSTCURR'
PAKG5AMT,
ConditionQuantityUnit,
  @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'  
QTY
}
