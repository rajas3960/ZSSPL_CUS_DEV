@EndUserText.label: 'Sales F4 Help using Abstract Entity'
define abstract entity ZPP_SALESVH_AE
//  with parameters parameter_name : parameter_type
{
@Consumption.valueHelpDefinition: [ { entity:{ name: 'I_SalesOrderStdVH',element: 'SalesOrder' }}]
  @Consumption.filter: { selectionType : #RANGE, multipleSelections : true}
    vbeln : vbeln;
    
}
