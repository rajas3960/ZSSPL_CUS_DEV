@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Contract rOOT pROJECTION vIEW'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPP_APPS05_Cp01 provider contract transactional_query as projection on ZPP_APPS05_COT01
{
    key BusinessPartner,
    BusinessPartnerName,
    contract
}
