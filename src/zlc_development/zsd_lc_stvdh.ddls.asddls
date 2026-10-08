@AbapCatalog.sqlViewName: 'ZSD_LC_VIEW'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help for LC'
@Metadata.ignorePropagatedAnnotations: true
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE, #VALUE_HELP_PROVIDER, #SEARCHABLE_ENTITY]
@Search.searchable: true
@VDM.viewType: #BASIC
define view ZSD_LC_STVDH as select from ZSD_LC_RCE
{
@Search.defaultSearchElement: true
@EndUserText.label: 'LC Number'
    key Lnum,
    @EndUserText.label: 'Balance Amount'
    @Semantics.amount.currencyCode: 'Lc_Curr'
    
    Tot_Balance,
     @EndUserText.label: 'Status'
      status,
    @UI.hidden: true
    Lc_Curr
   
  
}
