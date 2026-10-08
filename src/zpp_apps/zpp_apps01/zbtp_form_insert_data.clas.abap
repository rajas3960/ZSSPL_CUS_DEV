CLASS zbtp_form_insert_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBTP_FORM_INSERT_DATA IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  data: wa_db TYPE TABLE of zbtp_adobe_tb.

        " Populate the structure with data
        wa_db = VALUE #( (
                         parameters = 'ADS_URL'
                         value = 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com'
                         )
                         (
                         parameters = 'ADS_OAUTH_URL'
                         value = 'https://sdw23jrhgbs90ydm.authentication.eu10.hana.ondemand.com/oauth/token?grant_type=client_credentials'
                         )
                         (
                         parameters = 'ADS_CLIENTSECRET'
                         value = 'b97db0d2-f193-468f-82b2-40d488e21c38$bXf9pZ-SLfgynmq8d4fnXYpLiD3gZjMYafYvOiBanp4='
                         )
                         (
                         parameters = 'ADS_CLIENTID'
                         value = 'sb-8d1f4a81-96fb-46a1-a05a-6aae03f376e1!b496715|ads-xsappname!b102452'
                         )
                          ).

        " Delete the data into the database table
*            DELETE FROM ZBTP_ADOBE_TB.
*
*        " Insert the data into the database table
*            INSERT ZBTP_ADOBE_TB from table @wa_db.
*
*        " Fetch the data from database table
*            select * from ZBTP_ADOBE_TB into table @wa_db.

        " this is used to display the inserted records in the table as output.
*            out->write( EXPORTING data = wa_db ).

  ENDMETHOD.
ENDCLASS.
