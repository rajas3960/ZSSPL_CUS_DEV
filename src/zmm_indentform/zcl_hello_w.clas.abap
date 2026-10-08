class ZCL_HELLO_W definition
  public
  create public .

public section.

  interfaces IF_HTTP_SERVICE_EXTENSION .
protected section.
private section.
METHODS : get_bank_details RETURNING VALUE(r_json) type string.
ENDCLASS.



CLASS ZCL_HELLO_W IMPLEMENTATION.


  METHOD GET_BANK_DETAILS.

 DATA: lv_url TYPE string VALUE 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/'.
    DATA: lo_http_client TYPE REF TO  if_web_http_client.

    lo_http_client = cl_web_http_client_manager=>create_by_http_destination(
              i_destination = cl_http_destination_provider=>create_by_url( lv_url ) ).

    DATA(lo_request) = lo_http_client->get_http_request( ).

    lo_request->set_header_fields( VALUE #(
       (  name = 'Content-Type' value = 'application/json' )
       (  name = 'Accept' value = 'application/json' )
       (  name = 'APIKey' value = 'R24VsOpz01dZQOaQ5Zng081XnVM1l8XA') ) ).  "<<-- API KEY!

    lo_request->set_uri_path(
       i_uri_path = lv_url && 'API_GLACCOUNTINCHARTOFACCOUNTS_SRV/get_A_GLAccountInChartOfAccounts?$top=01&$format=json'  ).

    TRY.
        DATA(lv_response) = lo_http_client->execute( i_method = if_web_http_client=>get )->get_text(  ).
      CATCH cx_web_http_client_error.
    ENDTRY.



  ENDMETHOD.


  method IF_HTTP_SERVICE_EXTENSION~HANDLE_REQUEST.

   DATA(lt_params) = request->get_form_fields(  ).
    READ TABLE lt_params REFERENCE INTO DATA(lr_params) WITH KEY name = 'cmd'.
    IF sy-subrc <> 0.
      response->set_status( i_code = 400
                       i_reason = 'Bad request' ).
      RETURN.
    ENDIF.
    CASE lr_params->value.
      WHEN `timestamp`.
        response->set_text( |HTTP Service Application executed by {
                             cl_abap_context_info=>get_user_technical_name( ) } | &&
                              | on { cl_abap_context_info=>get_system_date( ) DATE = ENVIRONMENT } | &&
                              | at { cl_abap_context_info=>get_system_time( ) TIME = ENVIRONMENT } | ).

     when 'getbankdetails'.
      response->set_content_type( 'application/json' ).
        response->set_text( get_bank_details(  ) ).

      WHEN OTHERS.
        response->set_status( i_code = 400 i_reason = 'Bad request' ).
    ENDCASE.




  endmethod.
ENDCLASS.
