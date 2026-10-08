CLASS zcl_hello_world_c DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HELLO_WORLD_C IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.

    DATA(It_params) = request->get_form_fields(  ).

      READ TABLE it_params REFERENCE INTO  DATA(ls_params) WITH KEY name = 'cmd'.
    IF sy-subrc <> 0.

      response->set_status( i_code = 400
                          i_reason = 'Bad request' ).
      RETURN.
    ENDIF.
    CASE ls_params->value.
      WHEN 'Hello'.
        response->set_text( |Hello World| ).

      WHEN 'timestamp'.
        response->set_text( |Hello World ! application Excuted By {
          cl_abap_context_info=>get_user_technical_name(  )  }|
           && |on { cl_abap_context_info=>get_system_date(  ) DATE = ENVIRONMENT  }|
           && |at { cl_abap_context_info=>get_system_time(  ) TIME = ENVIRONMENT }| ).

      when 'getbankdetails'.
      response->set_content_type( 'application/json' ).
        response->set_text( NEW zcl_apihub_manager(  )->get_bank_details(  ) ).
      WHEN OTHERS .
        response->set_status( i_code = 400 i_reason = 'Bad Request'
                        ).
     ENDCASE.
*  RESPONSE->SET_TEXT( |'Hello Word'| ).

  ENDMETHOD.
ENDCLASS.
