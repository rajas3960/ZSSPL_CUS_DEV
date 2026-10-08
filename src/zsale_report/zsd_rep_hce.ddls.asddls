@EndUserText.label: 'Custom Entity Of Sales Report'
@ObjectModel.query.implementedBy: 'ABAP:ZSD_FORM'
define custom entity ZSD_REP_HCE
{
  key SalesDocument             : abap.char( 10 );
      SalesDocumentType         : auart;
      SalesDocumentDate         : abap.dats;
      PurchaseOrderByCustomer   : abap.char( 35 );
      CustomerPurchaseOrderDate : abap.dats;
      Project                   : abap.char( 12 );
      Galva                     : abap.char( 150 );
      SoldtoParty               : abap.char( 10 );
      CustomerName              : abap.char( 80 );
      BPAddrStreetName          : abap.char( 100 );
      PostalCode                : abap.char( 10 );
      CityName                  : abap.char( 35 );
      YY1_Gstno_sd_SDH          : abap.char( 15 );
      YY1_Statename_Sd_SDH      : abap.char( 20 );
      ShipToCustomer            : abap.char( 10 );
      Customer_Name             : abap.char( 80 );
      StreetName                : abap.char( 30 );
      Postal_Code               : abap.char( 10 );
      City_Name                 : abap.char( 35 );
      bstreet1                  : abap.char( 40 );
      bstreet2                  : abap.char( 40 );
      sstreet1                  : abap.char( 40 );
      sstreet2                  : abap.char( 40 );      
      Creationdate              : erdat;
      @ObjectModel.filter.enabled  : false
      item                      : association [1..*] to ZSD_REP_ICE on item.salesdocument = $projection.SalesDocument;
      @ObjectModel.filter.enabled  : false
      item1                      : association [1..*] to ZSD_REP_001_CE on item1.SalesDocument = $projection.SalesDocument;
}
