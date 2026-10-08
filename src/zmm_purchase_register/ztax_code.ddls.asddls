@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Tax Code Root Entity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZTAX_CODE as select from ztaxcodetb
{
  key taxcode as Taxcode,
      cgstpercent as CGSTPercent,
      sgstpercent as SGSTPercent,
      igstpercent as IGSTPercent,
      description as Description,
      lastchangedat as lastchangedat

}
