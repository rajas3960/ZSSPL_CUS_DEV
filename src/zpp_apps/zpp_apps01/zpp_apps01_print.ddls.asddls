@EndUserText.label: 'Print abstract entity'
define abstract entity ZPP_APPS01_PRINT
//  with parameters parameter_name : parameter_type
{
@Consumption.valueHelpDefinition: [ { entity:{ name: 'zpp_apps01_dov',element: 'value_low' }}]
@EndUserText.label: 'Print View'
   lowvalu : abap.char(2);
}
