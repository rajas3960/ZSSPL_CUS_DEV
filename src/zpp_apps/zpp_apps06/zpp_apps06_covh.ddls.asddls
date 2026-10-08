@EndUserText.label: 'Contractor View Help'
define abstract entity ZPP_APPS06_COVH
//  with parameters parameter_name : parameter_type
{

@Consumption.valueHelpDefinition: [
    {
      entity: { name: 'ZPP_APPS05_COTt', element: 'BusinessPartner' },
      additionalBinding: [
        { localElement: 'BusinessPartnerName', element: 'BusinessPartnerName', usage: #RESULT }
      ]
    }
  ]
    BusinessPartner : abap.char(10);
    
    
    BusinessPartnerName : abap.char(81);
    
}
