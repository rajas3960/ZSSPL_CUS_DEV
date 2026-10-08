@EndUserText.label: 'Deletion Parameter'
define abstract entity ZPP_APPS5_DEL
//  with parameters parameter_name : parameter_type
{
  @EndUserText.label: 'Reason For Deletion'
  @UI.multiLineText: true
  Deletet : abap.char( 200 );
  
    
}
