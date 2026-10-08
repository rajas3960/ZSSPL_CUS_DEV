@EndUserText.label: 'Project Wise Weight Summary Head Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZPP_FORM'
define custom entity ZPP_REP_hce 
{
    key Material : matnr;
    ProductName : abap.char( 40 );
     @ObjectModel.filter.enabled  : false
      item                      : association [1..*] to ZPP_REPORT_ICE on item.Material = $projection.Material;
//     @ObjectModel.filter.enabled  : false
//      item1                      : association [1..*] to ZPP_REPORT_ICE2 on item1.Material = $projection.Material;                                                                          
}
