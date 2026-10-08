@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contract Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPS05_COT01 as select from I_BusinessPartner as bp
left outer join zpp_apps05_cohb  as tbp on tbp.businesspartner = bp.BusinessPartner
{
key bp.BusinessPartner,
bp.BusinessPartnerName,
tbp.contract


    
}
