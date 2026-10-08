@EndUserText.label: 'Parameter For Length'
define abstract entity ZPP_STOCK_P
//  with parameters parameter_name : parameter_type
{
    @EndUserText.label: 'Length'
    Length  : abap.dec(20,0);
    @EndUserText.label: 'Width'
    Width   : abap.dec(20,0);
    @EndUserText.label: 'Pcs'
    Pcs     : abap.dec( 20, 0 );
    
}
