CLASS lhc__HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS Printso FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~Printso RESULT result.

ENDCLASS.

CLASS lhc__HDR IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Printso.
**********************************************************************
    DATA : lt_item TYPE TABLE OF zsd_apps_item,
           ls_item TYPE zsd_apps_item.

    READ ENTITIES OF zsd_rep_rv IN LOCAL MODE
          ENTITY _hdr
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(hdr)
          ENTITY _hdr BY \Item
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(item)
          FAILED DATA(failes).
    DATA(wa_header) = hdr[ 1 ].

    SORT item BY SalesDocument MainItemPricingRefProduct  ASCENDING.

    lt_item = VALUE #( FOR LS IN item ( CORRESPONDING #( LS ) ) ).

    DELETE  from zsd_apps_item where salesdocument = @wa_header-SalesDocument.
    MODIFY zsd_apps_item FROM TABLE @lt_item.



    IF wa_header-SalesDocument IS NOT INITIAL.
      TRY.
          DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
          iv_name        = 'ZTEST_CS'
          iv_service_instance_name = 'ZTEST_OS_REST' ).
          DATA(lo_fdp_util) =  cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZSD_REP_CE'
                                                                iv_root_node = 'ZSD_REP_HCE' ) .
          DATA : printque TYPE c LENGTH 32.
          printque = 'ADOBE_DEFAULT'.
          TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZSD_REP' ).
              "   out->write( 'Schema found in form' ).
            CATCH zcx_fp_tmpl_store_error1 INTO DATA(lo_tmpl_error).
              "  out->write( 'No schema in form found' ).
              IF lo_tmpl_error->mv_http_status_code = 404 OR lo_tmpl_error->mv_http_status_code = 403 .
                "Upload service definition
*                  lo_store->set_schema(
*                    iv_form_name = 'GATEFORM'
*                    is_data      = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd( ) )
*                  ).
              ELSE.

              ENDIF.
          ENDTRY.
          TYPES:BEGIN OF ty_schema_body,
                  xsd_schema  TYPE xstring,
                  schema_name TYPE c LENGTH 30,
                  note        TYPE c LENGTH 280,
                END OF ty_schema_body.
          DATA lv_xdp TYPE ty_schema_body.
          lv_xdp = VALUE #( note        = ''
                           schema_name = 'schema'
                           xsd_schema  = lo_fdp_util->get_xsd( ) ).
          DATA(lt_keys)     = lo_fdp_util->get_keys( ).
          lt_keys[ name = 'SALESDOCUMENT' ]-value = hdr[ 1 ]-SalesDocument .
          DATA(lt_xsd) = lo_fdp_util->get_xsd( ).
          DATA(lv_text) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).

          TRY.
              DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
              DATA(lv_test) =  cl_web_http_utility=>decode_utf8( encoded = lv_xml ).

            CATCH cx_fp_fdp_error INTO DATA(lo_exception).
              DATA(lver) = 1.
          ENDTRY.
*        DATA(lv_xml) = cl_web_http_utility=>decode_utf8( encoded = lv_xml ).
          DATA(ls_template) = lo_store->get_template_by_name(
          iv_get_binary    = abap_true
              iv_form_name     = 'ZSD_REP'
              iv_template_name = 'ZSD_SALES_REPORT'
          ).

          cl_fp_ads_util=>render_pdf( EXPORTING iv_locale       = 'en_US'
                                 "  iv_pq_name      = CONV zde_pqname( ls_queue-printque )"'YYRESV' "'PRINT_QUEUE'
                                           iv_xml_data     = lv_xml
                                           iv_xdp_layout   = ls_template-xdp_template
                                           is_options      = VALUE #( trace_level = 4 ) " Use 0 in production environment
                                 IMPORTING
                                 " TODO: variable is assigned but never used (ABAP cleaner)
                                           ev_trace_string = DATA(lv_trace)
                                           ev_pdf          = DATA(lv_pdf) ).
          DATA: lv_name TYPE c LENGTH 120.
          lv_name = |Invoice { wa_header-SalesDocument }|.
          DATA(lv_gno) = VALUE #( hdr[ 1 ]-SalesDocument OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
             iv_qname            = printque
             iv_print_data       = lv_pdf
             iv_name_of_main_doc = lv_name
             iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
           ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lver1) = 1.
      ENDTRY.

      DATA: gs_att TYPE zpp_bom_from.

      IF lv_pdf IS NOT INITIAL.
        gs_att-bomnum = wa_header-SalesDocument.
        gs_att-attachment = lv_pdf.
        gs_att-filename = wa_header-SalesDocument.
        gs_att-mimetype = 'application/pdf'.

        APPEND gs_att TO zbp_sd_rep_rv=>up_attach.

        MODIFY zsd_rep_db FROM TABLE @zbp_sd_rep_rv=>up_attach.
      ENDIF.
    ENDIF.

    result = VALUE #( FOR ls_ord IN hdr (
    %tky = ls_ord-%tky
    %param = ls_ord ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR item RESULT result.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZSD_REP_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZSD_REP_RV IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
