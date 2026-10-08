@EndUserText.label: 'Excel Upload Abstract Entity H'
define root abstract entity ZPP_APPS05_EXLP
//  with parameters parameter_name : parameter_type
{
@UI.hidden: true
    DUMMY : abap_boolean;
    _StreamProperties : association[1] to ZPP_APPS05_EXLUP on 1 = 1;
    
}
