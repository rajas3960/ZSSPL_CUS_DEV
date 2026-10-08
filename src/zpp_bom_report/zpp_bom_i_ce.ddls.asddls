@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom Entity Of Item Bom'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZPP_BOM_I_CE as select from ZPP_BOM_IRE
{
key Uuid,
key Srno,
bomnumber,
Markno,
Member,
Markdesc,
Length,
Width,
Unit,
unitperpcs,
Quantity,
totalwt,
Markshortno
}
