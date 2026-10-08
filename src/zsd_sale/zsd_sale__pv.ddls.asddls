@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View -  Sales Reports'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZSD_SALE__PV
  provider contract transactional_query
  as projection on ZSD_SALER_RE
{
    key BILLDOC,
    key BILLITNO,
    CMPC,
    SALESORG,
    DISTCHLN,
    Division,
    BILLDCTY,
    BILLDT,
    BILLTOPARTY,
    BILLTOPARTYNAME,
    PAYER,
    PAYERNAME,
    SoldToParty,
    SOLDTOPARTYNAME,
    GSTNO,
    PRODUCT,
    PRODU,
    HSNNO,
    uom,
     @Semantics.quantity.unitOfMeasure: 'BILLQTUNIT'
    BILLQTY,
    BILLQTUNIT,
    PlantName,
    STRLOCT,
     @Aggregation.default: #SUM @Aggregation.exception: #LAST
     @Semantics.quantity.unitOfMeasure: 'uom'
    NETWEIGHT,
     @Aggregation.default: #SUM @Aggregation.exception: #LAST
     @Semantics.quantity.unitOfMeasure: 'uom'
    GROSSWEIGHT,
    CURRENCY,
      @Semantics.amount.currencyCode: 'currency'
    netamt,
     @Aggregation.default: #SUM @Aggregation.exception: #LAST
      @Semantics.amount.currencyCode: 'currency'
    taxamt,
     @Aggregation.default: #SUM @Aggregation.exception: #LAST
      @Semantics.amount.currencyCode: 'currency'
    TOTALAMT,
    @Semantics.amount.currencyCode: 'currency'
    AMTPCIP,
    curr,
    rt,
    @Semantics.amount.currencyCode: 'curr'
    FREIGHT,
    @Semantics.amount.currencyCode: 'curr'
    MATERIALVAL,
//    @Semantics.quantity.unitOfMeasure: 'rt'
    igstrate,
    @Semantics.amount.currencyCode: 'curr'
    IGSTAMT,
//    @Semantics.quantity.unitOfMeasure: 'rt'
    cgstrate,
    @Semantics.amount.currencyCode: 'curr'
    CGSTAMT,
//    @Semantics.quantity.unitOfMeasure: 'rt'
    sgstrate,
    @Semantics.amount.currencyCode: 'curr'
    SGSTAMT,
    @Semantics.amount.currencyCode: 'curr'
    TCS,
    @Semantics.amount.currencyCode: 'curr'
    PCIPAMT,
    @Semantics.amount.currencyCode: 'curr'
    cessamt,
    @Semantics.amount.currencyCode: 'curr'
    tcssamt,
    @Semantics.amount.currencyCode: 'curr'
    otheramt,
    exchangerate,
    referencedoc,
    salesorder,
    docno,
    cancel,
    billcan,
    ponumber,
    odino,
    dcodino,
    PRGROUP,
    PRDCT,
    PurchaseOrder,
    @EndUserText.label: 'Box Packaging fee'
    @Semantics.amount.currencyCode: 'curr'
     PAKG1AMT,
     @EndUserText.label: 'Tower Packaging fee'
    @Semantics.amount.currencyCode: 'curr'
     PAKG2AMT,
     @EndUserText.label: 'Panal Packaging fee'
    @Semantics.amount.currencyCode: 'curr'
    PAKG3AMT,
     @EndUserText.label: 'Painting Packing fee'
    @Semantics.amount.currencyCode: 'curr'
     PAKG4AMT,
      @EndUserText.label: 'Bundling packing fee'
    @Semantics.amount.currencyCode: 'curr'
     PAKG5AMT,
     ConditionQuantityUnit,
     
      @Aggregation.default: #SUM @Aggregation.exception: #LAST
     @Semantics.quantity.unitOfMeasure: 'ConditionQuantityUnit'
     NETWEIGHTD
    
}
