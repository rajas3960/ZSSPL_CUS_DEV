@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value help For vr number'
@Metadata.ignorePropagatedAnnotations: true
define view entity zpp_vrno_vh as select from ZPP_APPS06_RE
{
    key Vrno
}
