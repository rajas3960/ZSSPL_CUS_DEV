@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order list Report Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSD_SALES_ORDERLIST_PV provider contract transactional_query as projection on  ZSD_SALES_ORDERLIST_RV
{
  @EndUserText.label: 'Sales Order Number'
   key SalesOrder,
   @EndUserText.label: 'Sales Line Item'
   key   lineitem,
    @EndUserText.label: 'Schedule Line Item'
   key sche,
   @EndUserText.label: 'Plant'
   Plant,
   @EndUserText.label: 'Product Number'
    Product,
    @EndUserText.label: 'Item Description'
    Descr,
    @EndUserText.label: 'Quantity Unit'
    qun,
    @EndUserText.label: 'Order Quantity'
    @Semantics.quantity.unitOfMeasure: 'qun'
    od,
    @EndUserText.label: 'Open Quantity'
    @Semantics.quantity.unitOfMeasure: 'qun'
    conf,
    @EndUserText.label: 'Currency'
    curr,
    @UI.hidden: true
    @EndUserText.label: 'Net Amount'
    @Semantics.amount.currencyCode: 'curr'
    NetAmount,
    @EndUserText.label: 'Delivery Quantity'
    //dequn,
   // @Semantics.quantity.unitOfMeasure: 'dequn'
   @Semantics.quantity.unitOfMeasure: 'qun'
    ordquantity,
   // @Semantics.quantity.unitOfMeasure: 'dequn'
   // actquantity,
    //Batch,
    @EndUserText.label: 'Requested Delivery Date'
    reqdate,
    @EndUserText.label: 'Payer'
    payno,
    @EndUserText.label: 'Payer Name'
    payname,
    @EndUserText.label: 'Sold To Party'
    stpno,
    @EndUserText.label: 'Sold To Party Name'
    stpname,
    @EndUserText.label: 'Bill To Party'
    btpno,
    @EndUserText.label: 'Bill To Party Name'
    btpname,
    @EndUserText.label: 'Ship To Party'
    sopno,
    @EndUserText.label: 'Ship To Party Name'
    sopname,
    @EndUserText.label: 'Inco Term'
    incoterm,
    @EndUserText.label: 'IncoTerm Desc'
    inconame,
    @EndUserText.label: 'Customer Reference'
    custref,
    @EndUserText.label: 'Customer Reference Date'
    custdt,
    @EndUserText.label: 'Delivery Status'
    overallstus,
    @UI.hidden: true
    OVERALLCRICITAL,
    @EndUserText.label: 'Sales Group'
    SalesGroup
}
