CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR header RESULT result.

    METHODS preview FOR MODIFY
      IMPORTING keys FOR ACTION header~preview RESULT result.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD preview.
*DATA: ls_xmldata     TYPE zmm_s_binding.
DATA: lv_system_date TYPE d.

" Get the current system date using the recommended method
lv_system_date = cl_abap_context_info=>get_system_date( ).
    READ ENTITIES OF zmm_purreq_hrv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_data)
    ENTITY Header BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_item).

    DATA(lt_items) = lt_item[].
    SORT lt_items BY purreq_itno ASCENDING.

    DATA(ls_data1) = lt_data[ 1 ].
    zbp_mm_purreq_hrv=>gv_indtno = ls_data1-indentno.

    DATA : lv_xml TYPE string.
    REPLACE ALL OCCURRENCES OF '&' IN ls_data1-Costname WITH 'and'.
    REPLACE ALL OCCURRENCES OF '&' IN ls_data1-Req_type WITH 'and'.
    REPLACE ALL OCCURRENCES OF '<' IN ls_data1-Costname WITH 'LT'.
    REPLACE ALL OCCURRENCES OF '<' IN ls_data1-Req_type WITH 'LT'.
    REPLACE ALL OCCURRENCES OF '>' IN ls_data1-Costname WITH 'GT'.
    REPLACE ALL OCCURRENCES OF '>' IN ls_data1-Req_type WITH 'GT'.
    REPLACE ALL OCCURRENCES OF '%' IN ls_data1-Costname WITH 'Pec'.
    REPLACE ALL OCCURRENCES OF '%' IN ls_data1-Req_type WITH 'Pec'.
    REPLACE ALL OCCURRENCES OF '#' IN ls_data1-Costname WITH 'Has'.
    REPLACE ALL OCCURRENCES OF '#' IN ls_data1-Req_type WITH 'Has'.

lv_xml = |<?xml version="1.0" encoding="UTF-8"?>| &&
    |<form1>| &&
    |<Indent>| &&
    |<Header>| &&
    |<ADD1>| && ls_data1-Plant && |</ADD1>| &&
    |<ADD1>Email :</ADD1>| &&
    |<docno>| && ls_data1-Name && |</docno>| &&
    |<printedno>| && lv_system_date && |</printedno>| &&
    |<pageno></pageno>| &&
    |</Header>| &&
    |<mainheader>| &&
    |<headersub1>| &&
    |<dept>| && ls_data1-dept && |</dept>| &&
    |<costcenter>| && ls_data1-Costname && |</costcenter>| &&
    |<Purpose>| && ls_data1-Req_type && |</Purpose>| &&
*    |<Purpose>| && ls_data1-Req_type && |</Purpose>| &&
    |</headersub1>| &&
    |<headersub2>| &&
    |<Indentno>| && ls_data1-indentno && |</Indentno>| &&
    |<Indentdate>| && ls_data1-indentdate && |</Indentdate>| &&
    |</headersub2>| &&
    |</mainheader>| .

    LOOP AT lt_items INTO DATA(ls_item).


*    REPLACE ALL OCCURRENCES OF ' & ' IN ls_item-lastgrnpov WITH 'and'.
    REPLACE ALL OCCURRENCES OF ' | ' IN ls_item-stock WITH cl_abap_char_utilities=>newline.

DATA(lv_text) = ls_item-itemdecs.

REPLACE ALL OCCURRENCES OF '&' IN lv_text WITH 'and'.
REPLACE ALL OCCURRENCES OF PCRE '[^\x09\x0A\x0D\x20-\x7F]'
  IN lv_text WITH ' '.

ls_item-itemdecs = lv_text.
     lv_xml = lv_xml &&
     |<item>| &&
     |<Table1>| &&
      |<HeaderRow/>| &&
        |<Row1>| &&
        |<islno>| && | { ls_item-purreq_itno ALPHA = OUT } | && |</islno>| &&
        |<iitemdes>| && ls_item-itemdecs && |</iitemdes>| &&
        |<idiv>| && ls_item-div && |</idiv>| &&
        |<ium>| && ls_item-BaseUnit && |</ium>| &&
        |<ireq>| && ls_item-req && |</ireq>| &&
        |<iqtyappr>| && | | && |</iqtyappr>| &&
        |<istockdiv>| && ls_item-stock && |</istockdiv>| &&   ""| && ls_item-stock && |
        |<irate>| && ls_item-perprice && |</irate>| &&
        |<ivalue>| && ls_item-net_amt && |</ivalue>| &&
        |<igrnno>| && ls_item-lastgrnpov && |</igrnno>| &&
        |</Row1>| &&
         |</Table1>| &&
    |</item>| .
    ENDLOOP.

    lv_xml = lv_xml  &&
    |</Indent>| &&
    |</form1>|.




**********************************************************************
    ZBP_MM_PURREQ_HRV=>gs_xmldata = lv_xml.

    DATA: ls_data     TYPE ztestt_s_binding,
          ls_req      TYPE zmm_s_body,
          ls_response TYPE zmm_rp_body.
    DATA : ls_maindoc TYPE STANDARD TABLE OF zmm_purreq_hpv.

    TRY.

        DATA(lo_dest) = cl_http_destination_provider=>create_by_comm_arrangement(
        comm_scenario = 'ZTEST_CS'
        comm_system_id = 'ZTEST'
        service_id = 'ZTEST_OS_REST'

        ).


      CATCH cx_http_dest_provider_error INTO DATA(lx_error).
      DATA(error_msg) = lx_error->get_text( ).
    ENDTRY.

    TRY.

        DATA(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

      CATCH cx_web_http_client_error INTO DATA(lx_client_error).
      DATA(error_msgeq) = lx_client_error->get_text( ).

    ENDTRY.
    DATA(lo_request) = lo_client->get_http_request(  ).
    lo_request->set_header_fields( VALUE #(
    ( name = 'Accept' value = 'application/json, text/plain, */*' )
    ( name = 'Content-Type' value = 'application/json;charset=utf-8' )
     ) ).

*    TRY.
*        CALL TRANSFORMATION ZDEMO_TS
*        SOURCE form = zbp_mm_pur_ind_r=>gs_xmldata
*        RESULT XML  DATA(lv_xml).
*
*      CATCH cx_root INTO DATA(lo_root).
*
*    ENDTRY.
    DATA(lv_base64_data) = cl_web_http_utility=>encode_base64( unencoded = ZBP_MM_PURREQ_HRV=>gs_xmldata ).

*    ls_req-xdp_template = 'ZINDENTV1/IndentTemplate'.
*    ls_req-xdp_template = 'ZINDENTV2/Template'.
     ls_req-xdp_template = 'ZINDENTV3/Template'.
    ls_req-xml_data     = lv_base64_data.
    ls_req-form_type    = 'print'.
    ls_req-form_locale  = 'en_US'.
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
    DATA(msg) = lx_root->get_text( ).
    ENDTRY.
    lo_request->set_text(
    EXPORTING
    i_text = lv_body ).


    TRY.

        DATA(lo_response) = lo_client->execute(
        i_method = if_web_http_client=>post
        i_timeout = 0  ).


      CATCH cx_web_http_client_error INTO lx_client_error.
      DATA(error_msge) = lx_client_error->get_text( ).
    ENDTRY.
    DATA(lv_response) = lo_response->get_text(  ).
    DATA(ls_status) = lo_response->get_status(  ).

    IF ls_status-reason = 'OK' AND ls_status-code = '200'.

      APPEND VALUE #( %tky = ls_data1-%tky
      %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                              text = 'Printed Successfully' )
                               ) TO reported-header.
    ELSE.
      APPEND VALUE #( %tky = ls_data1-%tky ) TO failed-header.
      APPEND VALUE #( %tky = ls_data1-%tky
      %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text = 'Not Printed Successfully' )
                               ) TO reported-header.

    ENDIF.

    TRY.
        CALL METHOD /ui2/cl_json=>deserialize
          EXPORTING
            json          = lv_response
            assoc_arrays  = abap_true
            name_mappings = VALUE #( ( json = 'filecontent' abap = 'FILECONTENT' ) )
          CHANGING
            data          = ls_response.
      CATCH cx_root INTO lx_root.
     DATA(msg1) = lx_root->get_text( ).
    ENDTRY.

*  out->write( ls_response-filecontent ).
    DATA(lv_print_data) = cl_web_http_utility=>decode_x_base64( encoded = ls_response-filecontent  ).
    DATA(lv_qitem_id)  = cl_print_queue_utils=>create_queue_itemid(  ).

    zbp_mm_purreq_hrv=>gv_print_data = lv_print_data.
    zbp_mm_purreq_hrv=>gv_qitem_id = lv_qitem_id.

    result = VALUE #( FOR ls in lt_data ( %tky = ls-%tky
    %param = ls )  ).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZMM_PURREQ_HRV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZMM_PURREQ_HRV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
data : gs_hdr type zmm_app_attch.
    IF zbp_mm_purreq_hrv=>gv_print_data IS NOT INITIAL.
      DATA(lv_print_data) = zbp_mm_purreq_hrv=>gv_print_data.
      DATA(lv_qitem_id) = zbp_mm_purreq_hrv=>gv_qitem_id.
      DATA(lv_docno) = zbp_mm_purreq_hrv=>gv_indtno.
      cl_print_queue_utils=>create_queue_item_by_data(
      EXPORTING
               iv_qname = 'ZPQUEUE'
*               iv_qname         = 'DEV_PRINT_QUEUE'
               iv_print_data = lv_print_data
               iv_name_of_main_doc = 'IndentForm-' && lv_docno
                iv_itemid = lv_qitem_id
          IMPORTING
          ev_err_msg = DATA(lv_error_msg)
       ).
     gs_hdr-purreq = lv_docno.
     gs_hdr-attachment = lv_print_data.
     gs_hdr-filename = 'IndentForm-' && lv_docno.
     gs_hdr-minetype = 'application/pdf'.
       MODIFY zmm_app_attch from @gs_hdr.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
