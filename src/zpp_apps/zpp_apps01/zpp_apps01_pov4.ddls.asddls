@EndUserText.label: 'PO Section Material'
define abstract entity ZPP_APPS01_POV4
//  with parameters parameter_name : parameter_type
{
@Consumption.valueHelpDefinition: [ { entity:{ name: 'ZPP_APPS02_POV4',element: 'Pono' },additionalBinding: [{ localElement: 'secno',element: 'Material' }]}]
Pono : abap.char( 30 );
secno : matnr;

}
