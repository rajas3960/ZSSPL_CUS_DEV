@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Summary of records'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS05_RAWS as select from ZPP_APPS05_IRV8 
{
    key Vrno,
   
   sum( Uqty ) as rqty
  
}group by 
Vrno
