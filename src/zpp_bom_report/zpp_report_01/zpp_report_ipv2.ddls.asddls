@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Wise Weight Summary Sub item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_REPORT_IPV2 as projection on ZPP_REP_IRV2
{
    key Material,
    key Structure,
    key Tower_Type,
    BOM_HT,
    BOM_MS,
    BOM_BN,
    HT_Weight,
    MS_Weight,
    BN_Weight,
    Mark_No  
}
