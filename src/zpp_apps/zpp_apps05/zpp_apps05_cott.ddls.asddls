@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contract Root View Entity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_APPS05_COTt as select from ZPP_APPS05_COT01 as bp
{
key bp.BusinessPartner,
bp.BusinessPartnerName,
@UI.hidden: true
bp.contract


    
}where bp.contract = 'C'
