@EndUserText.label: 'Material F4 Help using Abstract Entity'
define abstract entity ZPP_MATSTVH_AE
//  with parameters parameter_name : parameter_type
{
@Consumption.valueHelpDefinition: [ { entity:{ name: 'I_ProductStdVH',element: 'Product' }}]
@Consumption.filter: { selectionType : #RANGE, multipleSelections : true}
    matnr : matnr;
 
    
}
