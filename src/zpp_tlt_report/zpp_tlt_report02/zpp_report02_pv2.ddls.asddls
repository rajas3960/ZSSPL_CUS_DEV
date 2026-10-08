@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection View of MIS Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Analytics.dataCategory: #CUBE
@OData.applySupportedForAggregation: #FULL
define root view entity ZPP_REPORT02_pV2 provider contract transactional_query as projection on ZPP_REPORT02_RV2
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
