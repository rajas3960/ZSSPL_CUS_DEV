@EndUserText.label: 'Custom Entity Sales Report'
@Search.searchable: true
@ObjectModel:{
query:{
    implementedBy: 'ABAP:ZCL_SALES'
    }
    }
    
@UI: {
  headerInfo: {
    typeName: 'Sales Report',
    typeNamePlural: 'Sales Report',
    title: { value: 'billdoc' },
    description: { value: 'billdoc' }

  }
}
define custom entity ZCE_SALES
{

      @UI.facet           : [
            {
              id          :  'billdoc',
              purpose     :  #STANDARD,
              //type: #CHART_REFERENCE,


              type        :#IDENTIFICATION_REFERENCE,
              label       :  'billdoc',

              position    : 60 }
          ]
      @UI                 : { lineItem: [{ position: 60, label: 'Billing Number' }],
      identification      : [{ position: 60, label: 'Billing Number' }],
      selectionField      : [{position: 60}]   }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_BillingDocumentStdVH', element: 'BillingDocument' } } ]
      @EndUserText.label  : 'Billing Number'
      
  key billdoc             : abap.char(10);
      @UI                 : { lineItem: [{ position: 70, label: 'Billing Date' }],
      identification      : [{ position: 70, label: '' }],
      selectionField      : [{position: 70}]   }
      @EndUserText.label  : 'Billing Date'
  key billdt              : abap.dats;
      @UI                 : { lineItem: [{ position : 30, label : 'Distribution chennal'}],
      identification      : [{ position : 30, label :'Distribution chennal'}],
      selectionField      : [{position: 30}]   }
      @EndUserText.label  : 'Distribution chennal'
      distchaln           : abap.char(2);
      @UI                 : { lineItem: [{ position: 40, label: 'Division' }],
      identification      : [{ position: 40, label: 'Division' }],
      selectionField      : [{position: 40}]   }
      @EndUserText.label  : 'Division'
      division            : abap.char(2);
      @UI                 : { lineItem: [{ position: 50, label: 'Billing Document type' }],
      identification      : [{ position: 50, label: 'Billing Document type' }],
      selectionField      : [{position: 50}]   }
      @EndUserText.label  : 'Billing Document type'
      billdoctype         : abap.char(4);
      @UI                 : { lineItem: [{ position: 10, label: 'Company Code' }],
      identification      : [{ position: 10, label: 'Company Code' }],
      selectionField      : [{position: 10}]   }
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CompanyCodeStdVH', element: 'CompanyCode' } } ]
      @EndUserText.label  : 'Company Code'
      companycode         : abap.char(4);
      @UI                 : { lineItem: [{ position: 20, label: 'Sales Org' }],
      identification      : [{ position: 20, label: 'Sales Org' }],
      selectionField      : [{position: 20}]   }
      @EndUserText.label  : 'Sales Org'
      salesorg            : abap.char(4);
      @UI                 : { lineItem: [{ position: 80, label: 'Customer No' }],
      identification      : [{ position: 80, label: 'Customer No' }]}
      customerno          : abap.char(10);
      @UI                 : { lineItem: [{ position: 90, label: 'Customer Name' }],
      identification      : [{ position: 90, label: 'Customer Name' }]}
      customername        : abap.char(20);
      @UI                 : { lineItem: [{ position: 100, label: 'Payer' }],
      identification      : [{ position: 100, label: 'Payer' }]}
      payer               : abap.char(10);
      @UI                 : { lineItem: [{ position: 110, label: 'Payer Name' }],
      identification      : [{ position: 110, label: 'Payer Name' }]}
      payername           : abap.char(20);
      @UI                 : { lineItem: [{ position: 120, label: 'Sold To Party' }],
      identification      : [{ position: 120, label: 'Sold To Party' }]}
      stp                 : abap.char(10);
      @UI                 : { lineItem: [{ position: 130, label: 'Sold To Party Name' }],
      identification      : [{ position: 130, label: 'Sold To Party Name' }]}
      stpn                : abap.char(20);
      @UI                 : { lineItem: [{ position: 140, label: 'GST No ' }],
      identification      : [{ position: 140, label: 'GST No' }]}
      gstno               : abap.char(20);
      @UI                 : { lineItem: [{ position: 140, label: 'Place Name' }],
      identification      : [{ position: 140, label: 'Place Name' }]}
      plname              : abap.char(20);
      @UI                 : { lineItem: [{ position: 150, label: 'Material Number' }],
      identification      : [{ position: 150, label: 'Material Number' }]}
      materialno          : abap.char(40);
      @UI                 : { lineItem: [{ position: 160, label: 'Billing Item Number' }],
      identification      : [{ position: 160, label: 'Billing Item Number' }]}
      billingino          : abap.numc(6);
      @UI                 : { lineItem: [{ position: 170, label: 'Product' }],
      identification      : [{ position: 170, label: 'Product' }]    }
      product             : abap.char(40);
      @UI                 : { lineItem: [{ position: 180, label: 'HSN Code' }],
      identification      : [{ position: 180, label: 'HSN Code' }]      }
      hsncode             : abap.char(16);
      @UI                 : { lineItem: [{ position: 190, label: 'Quantity' }],
      identification      : [{ position: 190, label: 'Quantity' }]    }
      @Semantics.quantity.unitOfMeasure : 'billingquantityunit'
      billingqty          : abap.quan(13,3);
      @UI                 : { lineItem: [{ position: 200, label: 'Sales Unit' }],
      identification      : [{ position: 200, label: 'Sales Unit' }]    }
      salesunit           : abap.unit(3);
      @UI                 : { lineItem: [{ position: 210, label: 'Plant' }],
      identification      : [{ position: 210, label: 'Plant' }]    }
      plant               : abap.char(4);
      @UI                 : { lineItem: [{ position: 220, label: 'Storage Location' }],
      identification      : [{ position: 220, label: 'Storage Location' }]    }
      strloct             : abap.char(4);
      @UI                 : { lineItem: [{ position: 230, label: 'Freight' }],
      identification      : [{ position: 230, label: 'Freight' }]    }
      @Semantics.amount.currencyCode : 'currency'
      freight             : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 270, label: 'CGST Amount' }],
      identification      : [{ position: 270, label: 'CGST Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      cgstamt             : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 280, label: 'SGST Amount' }],
      identification      : [{ position: 280, label: 'SGST Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      sgstamt             : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 290, label: 'IGST Amount' }],
      identification      : [{ position: 290, label: 'IGST Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      igstamt             : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 240, label: 'Material value/Unit Price' }],
      identification      : [{ position: 240, label: 'Material value/Unit Price' }]    }
      @Semantics.amount.currencyCode : 'currency'
      materialval         : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 250, label: 'Net Weight' }],
      identification      : [{ position: 250, label: 'Net Weight' }]    }
      @Semantics.quantity.unitOfMeasure : 'billingquantityunit'
      netweight           : abap.quan( 15, 3);
      @UI                 : { lineItem: [{ position: 260, label: 'Gross Weight' }],
      identification      : [{ position: 260, label: 'Gross Weight' }]    }
      @Semantics.quantity.unitOfMeasure : 'billingquantityunit'
      grossweight         : abap.quan( 15, 3);
      @UI                 : { lineItem: [{ position: 310, label: 'TCS' }],
      identification      : [{ position: 310, label: 'TCS' }]    }
      @Semantics.amount.currencyCode : 'currency'
      tcs                 : abap.curr(15,2);
      @UI                 : { lineItem: [{ position: 320, label: 'Total Tax Amount' }],
      identification      : [{ position: 320, label: 'Total Tax Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      taxamt              : abap.curr(13,2);
      @UI                 : { lineItem: [{ position: 330, label: 'Bill Amount' }],
      identification      : [{ position: 330, label: 'Bill Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      billamt             : abap.curr(13,2);
      @UI                 : { lineItem: [{ position: 300, label: 'Total Net Amount' }],
      identification      : [{ position: 300, label: 'Total Net Amount' }]    }
      @Semantics.amount.currencyCode : 'currency'
      netamt              : abap.curr(13,2);
      @UI                 : { lineItem: [{ position: 340, label: 'Currency' }],
      identification      : [{ position: 340, label: 'Currency' }]    }
      currency            : abap.cuky;
      @UI                 : { lineItem: [{ position: 350, label: 'Exchange Rate' }],
      identification      : [{ position: 350, label: 'Exchange Rate' }]    }
      exchangerate        : abap.dec( 5,4);
      @UI                 : { lineItem: [{ position: 360, label: 'Reference Doc.' }],
      identification      : [{ position: 360, label: 'Reference Doc.' }]    }
      referencedoc        : abap.numc( 10 );
      @UI                 : { lineItem: [{ position: 370, label: 'Sales Order' }],
      identification      : [{ position: 370, label: 'Sales Order' }]    }
      salesorder          : abap.numc( 10 );
      @UI                 : { lineItem: [{ position: 380, label: 'FI Invoice Number' }],
      identification      : [{ position: 380, label: 'FI Invoice Number' }]    }
      docno               : abap.char( 10 );
      @UI                 : { lineItem: [{ position: 390, label: 'Cancelled' }],
      identification      : [{ position: 390, label: 'Cancelled' }]    }
      cancell             : abap.char( 1);
      @UI                 : { lineItem: [{ position: 400, label: 'Cancelled Billing Document' }],
      identification      : [{ position: 400, label: 'Cancelled Billing Document' }]    }
      billcan             : abap.char(10);
      @UI                 : { lineItem: [{ position: 410, label: 'PO Number' }],
      identification      : [{ position: 410, label: 'PO Number' }]    }
      Ponumber            : abap.char(35);
      @UI.hidden          : true
      billingquantityunit : abap.unit(3);
};
