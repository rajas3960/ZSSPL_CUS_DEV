@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Patnar'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZPP_APPS08_BP as select from I_BusinessUserVH
{
@UI.hidden: true
    key BusinessPartner,
    UserID,
    PersonFullName
}
