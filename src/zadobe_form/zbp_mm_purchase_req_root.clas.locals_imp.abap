CLASS lhc_ZMM_PURCHASE_REQ_Root DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PUBLIC SECTION.
    CLASS-METHODS : send_to_print.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZMM_PURCHASE_REQ_Root RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZMM_PURCHASE_REQ_Root RESULT result.

    METHODS previewvd FOR MODIFY
      IMPORTING keys FOR ACTION ZMM_PURCHASE_REQ_Root~preview RESULT result.

ENDCLASS.

CLASS lhc_ZMM_PURCHASE_REQ_Root IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD previewvd.

    DATA: ls_data     TYPE ztest_s_binding,
          ls_req      TYPE ztest_s_body,
          ls_response TYPE ztest_rp_body.

    TRY.

        DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
        comm_scenario = 'ZTEST_CS'
        comm_system_id = 'ZTEST'
        service_id = 'ZTEST_OS_REST'

        ).


      CATCH cx_http_dest_provider_error INTO DATA(lx_error).
    ENDTRY.

    TRY.

        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

      CATCH cx_web_http_client_error INTO DATA(lx_client_error).

    ENDTRY.
    DATA(lo_request) = lo_client->get_http_request(  ).
    lo_request->set_header_fields( VALUE #(
    ( name = 'Accept' value = 'application/json, text/plain, */*' )
    ( name = 'Content-Type' value = 'application/json;charset=utf-8' )
     ) ).

    ls_data = VALUE #( Textfield1 = 'Test form'
                        Datefield1 = '20250312'
                        Decimalfield1 = '55.89' ).
    TRY.
        CALL TRANSFORMATION ztest_tr_binding
        SOURCE form = ls_data
        RESULT XML  DATA(lv_xml).

      CATCH cx_root INTO DATA(lo_root).

    ENDTRY.
    DATA(lv_base64_data) = cl_web_http_utility=>encode_x_base64( unencoded = lv_xml ).

    ls_req-xdp_template = 'YY1_INDENTFORM01/TEMPLATE01'.
    ls_req-xml_data     = lv_base64_data.
    ls_req-form_type    = 'print'.
    ls_req-form_locale  = 'tr_TR'.
    ls_req-tagged_pdf = 1.
    ls_req-embed_font = 0.
    ls_req-change_not_allowed = abap_false.
    ls_req-print_not_allowed = abap_false.

    TRY.
        CALL METHOD /ui2/cl_json=>serialize
          EXPORTING
            data        = ls_req
            pretty_name = /ui2/cl_json=>pretty_mode-camel_case
          RECEIVING
            r_json      = DATA(lv_body).

      CATCH cx_root INTO DATA(lx_root).
    ENDTRY.
    lo_request->set_text(
    EXPORTING
    i_text = lv_body ).


    TRY.

        DATA(lo_response) = lo_client->execute(
        i_method = if_web_http_client=>post
        i_timeout = 0  ).

      CATCH cx_web_http_client_error INTO lx_client_error.
    ENDTRY.
    DATA(lv_response) = lo_response->get_text(  ).
    DATA(ls_status) = lo_response->get_status(  ).

    TRY.
        CALL METHOD /ui2/cl_json=>deserialize
          EXPORTING
            json          = lv_response
            assoc_arrays  = abap_true
            name_mappings = VALUE #( ( json = 'filecontent' abap = 'FILECONTENT' ) )
          CHANGING
            data          = ls_response.
      CATCH cx_root INTO lx_root.

    ENDTRY.

*  out->write( ls_response-filecontent ).
    DATA(lv_print_data) = cl_web_http_utility=>decode_x_base64( encoded = ls_response-filecontent  ).
    DATA(lv_qitem_id)  = cl_print_queue_utils=>create_queue_itemid(  ).

    cl_print_queue_utils=>create_queue_item_by_data(
    EXPORTING
             iv_qname = 'ZTEST'
             iv_print_data = lv_print_data
             iv_name_of_main_doc = 'ZTEST'
              iv_itemid = lv_qitem_id
        IMPORTING
        ev_err_msg = DATA(lv_error_msg)

     ).


  ENDMETHOD.

  METHOD send_to_print.

*    DATA: lv_err_msg TYPE cl_print_queue_utils=>ty_msg,
*          re_status  TYPE i.
*
*    DATA(lv_qitem_id) = cl_print_queue_utils=>create_queue_itemid( ).
*
*    IF lv_qitem_id IS NOT INITIAL.
*      cl_print_queue_utils=>create_queue_item_by_data(
*        EXPORTING
*          iv_itemid = lv_qitem_id
*          iv_qname = 'PRINT_QUEUE'
*          iv_print_data = zbp_mm_purchase_req_root=>gv_pdf_data " Pass xstring value as PDF content
*          iv_number_of_copies = 1
*          iv_name_of_main_doc = |{ '0010000009' }|
*        IMPORTING
*          ev_err_msg = lv_err_msg ).
*      IF lv_err_msg IS INITIAL.
*        re_status = 0.
*      ELSE.
*        re_status = 4.
*        DATA(lv_error) = lv_err_msg.
*      ENDIF.
*    ELSE.
*      re_status = 4.
*    ENDIF.
***********************************************************************
*    IF re_status NE 0 .
*
*    ENDIF.



  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMM_PURCHASE_REQ_ROOT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMM_PURCHASE_REQ_ROOT IMPLEMENTATION.

  METHOD save_modified.

    DATA: lv_err_msg TYPE cl_print_queue_utils=>ty_msg,
          re_status  TYPE i.

    DATA(lv_qitem_id) = cl_print_queue_utils=>create_queue_itemid( ).

    IF lv_qitem_id IS NOT INITIAL.
      cl_print_queue_utils=>create_queue_item_by_data(
        EXPORTING
          iv_itemid = lv_qitem_id
          iv_qname = 'PRINT_QUEUE'
          iv_print_data = zbp_mm_purchase_req_root=>gv_pdf_data " Pass xstring value as PDF content
          iv_number_of_copies = 1
          iv_name_of_main_doc = |{ '0010000009' }|
        IMPORTING
          ev_err_msg = lv_err_msg ).
      IF lv_err_msg IS INITIAL.
        re_status = 0.
      ELSE.
        re_status = 4.
        DATA(lv_error) = lv_err_msg.
      ENDIF.
    ELSE.
      re_status = 4.
    ENDIF.
**********************************************************************
    IF re_status NE 0 .

    ENDIF.


*** Send the document to print QUEUE
*    IF zbp_mm_purchase_req_root=>gv_pdf_data IS NOT INITIAL.
*      CALL METHOD zbp_mm_purchase_req_root=>.
**
**      IF lv_status NE 0. "error
**        MESSAGE s004(zmsg_op01) WITH lo_obj->ls_record-materialdocument
**          INTO DATA(lv_message).
**        reported-zi_qm_ret_slip_root = VALUE #(
**          (%msg = new_message_with_text(severity = if_abap_behv_message=>severity-error text =
**          lv_message && space && lo_obj->lv_error)) ). " Print Task returned Error !!!
**      ELSE. "success
**        MESSAGE s005(zmsg_op01) WITH lo_obj->ls_record-materialdocument
**          INTO lv_message.
**        reported-zi_qm_ret_slip_root = VALUE #(
**          (%msg = new_message_with_text(severity = if_abap_behv_message=>severity-success text =
**          lv_message)) ). "Print Task successful. Please check Queue."
**      ENDIF.
**    ENDIF.
**  ENDMETHOD.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
