@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIS Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE

define root view entity ZPP_REPORT02_RV2 as select from zpp_report02_irv
{
    key SalesDocument,
    key YY1_PriorityPONos_SDH,
    YY1_Project_SDH,
    
    ProductName,
     @Aggregation.default: #SUM 
    batch_wt,
     @Aggregation.default: #SUM 
    Plan_wt,
     @Aggregation.default: #SUM 
    Balance_Wt,
     @Aggregation.default: #SUM 
    Glava_in,
     @Aggregation.default: #SUM 
    Balglvin_wt,
     @Aggregation.default: #SUM 
    Glalva_wt,
     @Aggregation.default: #SUM 
    Balglv_wt,
     @Aggregation.default: #SUM 
    Despatch_wt,
     @Aggregation.default: #SUM 
    Balrdispatch_wt,
     @Aggregation.default: #SUM 
    TotSP_Wt
    
}
