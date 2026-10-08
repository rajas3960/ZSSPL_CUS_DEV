@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order Header Projection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZSD_APP_HPV provider contract transactional_query as projection on ZSD_APP_HRV
{
    key Recguid,
    @EndUserText.label: 'Order Type'
    Ordertype,
    @EndUserText.label: 'Sales Organization'
    Salesorg,
    @EndUserText.label: 'Distribution Channel'
    Dist,
    @EndUserText.label: 'Division'
    Div,
    @EndUserText.label: 'Sold To Party'
    
    Soldto,
    @EndUserText.label: 'Lc Number_1'
    Lcnumber,
    @EndUserText.label: 'Lc Number_2'
    Lcnumber2,
    @EndUserText.label: 'Lc Number_3'
    Lcnumber3,
    @EndUserText.label: 'Lc Number_4'
    Lcnumber4,
    @EndUserText.label: 'Lc Number_5'
    Lcnumber5,
      @EndUserText.label: 'Lc Number_6'
    Lcnumber6,
      @EndUserText.label: 'Lc Number_7'
    Lcnumber7,
      @EndUserText.label: 'Lc Number_8'
    Lcnumber8,
      @EndUserText.label: 'Lc Number_9'
    Lcnumber9,
      @EndUserText.label: 'Lc Number_10'
    Lcnumber10,
    @EndUserText.label: 'Lc Amount_1'
    @Semantics.amount.currencyCode: 'Lcurr'
    Lcamount,
     @EndUserText.label: 'Lc Amount_2'
    @Semantics.amount.currencyCode: 'Lcurr2'
    Lcamount2,
     @EndUserText.label: 'Lc Amount_3'
    @Semantics.amount.currencyCode: 'lcurr3'
    Lcamount3,
     @EndUserText.label: 'Lc Amount_4'
    @Semantics.amount.currencyCode: 'lcurr4'
    Lcamount4,
     @EndUserText.label: 'Lc Amount_5'
    @Semantics.amount.currencyCode: 'lcurr5'
    Lcamount5,
        @EndUserText.label: 'Lc Amount_6'
    @Semantics.amount.currencyCode: 'lcurr6'
    Lcamount6,
        @EndUserText.label: 'Lc Amount_7'
    @Semantics.amount.currencyCode: 'lcurr7'
    Lcamount7,
        @EndUserText.label: 'Lc Amount_8'
    @Semantics.amount.currencyCode: 'lcurr8'
    Lcamount8,
        @EndUserText.label: 'Lc Amount_9'
    @Semantics.amount.currencyCode: 'lcurr9'
    Lcamount9,
        @EndUserText.label: 'Lc Amount_10'
    @Semantics.amount.currencyCode: 'lcurr10'
    Lcamount10,
    @EndUserText.label: 'Lc Curr1'
    Lcurr,
    Lcurr2,
lcurr3,
lcurr4,
lcurr5,
lcurr6,
lcurr7,
lcurr8,
lcurr9,
lcurr10,

    @EndUserText.label: 'Created By'
    Createdby,
    @EndUserText.label: 'Created On'
    Createdon,
    @EndUserText.label: 'Last Changed By'
    Lastchangedby,
    @EndUserText.label: 'Last Changed On'
    Lastchangedon,
    @EndUserText.label: 'Sales Order Number'
    Salesorderno,
  
    /* Association */
    @UI.hidden: true
    IMAGES,
    @UI.hidden: true
    salesname,
    
    _SalesItem :redirected to composition child ZSD_APP_IPV
}
