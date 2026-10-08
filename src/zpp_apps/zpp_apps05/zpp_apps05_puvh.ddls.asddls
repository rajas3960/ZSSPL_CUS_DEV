@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase order view help'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true 
define view entity ZPP_APPS05_PUVH as select from ZPP_APPS05_PURVH
{
@Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
@EndUserText.label: 'Priority Po No'
    key Pono,
    @EndUserText.label: 'Section / Material '
@Search.defaultSearchElement: true
 @Search.fuzzinessThreshold: 0.5
      @Search.ranking: #HIGH
    key Material,
     @EndUserText.label: 'Section / Material Dec '
    Materialdec,
       @EndUserText.label: 'Unit Wt'
    Unitwt,
     @EndUserText.label: 'No Of Marks No'
    COUN,
    @EndUserText.label: 'Planned Marks No'
    plcot,
    @EndUserText.label: 'Balance'
    $projection.coun - $projection.plcot as bal
}where COUN - plcot <> 0
