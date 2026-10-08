@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity Of Section Item'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_SUBTYPE_CE as select from ZPP_SUBTYPE
{
    key  bomnum as Bomnumber,
    key Uuid as Material,
    key mat_type as MarkNumber,
    total_weight
}
