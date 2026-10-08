CLASS lhc_hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hdr RESULT result.

*    "!
*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR hdr RESULT result.

    METHODS PrintBom FOR MODIFY
      IMPORTING keys FOR ACTION hdr~PrintBom RESULT result.

ENDCLASS.

CLASS lhc_hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*  ENDMETHOD.

  METHOD PrintBom.
**********************************************************************
  READ ENTITIES OF ZPP_REPORT_HRV IN LOCAL MODE
        ENTITY hdr
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(hdr)
        ENTITY hdr by \Item
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(item)
        FAILED DATA(failes).
        DATA(wa_header) = hdr[ 1 ].
        if wa_header-Material is NOT INITIAL.
           try.
            DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
            iv_name        = 'ZTEST_CS'
            iv_service_instance_name = 'ZTEST_OS_REST' ).
            DATA(lo_fdp_util) =  cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_REP_CEUI'
                                                                  iv_root_node = 'ZPP_REP_HCE' ) .
           DATA : PRINTQUE TYPE C LENGTH 32.
           printque = 'ADOBE_DEFAULT'.
           TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZPP_PROJECT_SUMMARY' ).
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
          lt_keys[ name = 'MATERIAL' ]-value = hdr[ 1 ]-Material .
          DATA(lt_xsd) = lo_fdp_util->get_xsd( ).
           data(lv_text) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).

           try.
           data(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
           DATA(lv_test) =  cl_web_http_utility=>decode_utf8( encoded = lv_xml ).

           CATCH cx_fp_fdp_error INTO data(lo_exception).
           data(lv_error3) = 1.
           ENDTRY.
*        DATA(lv_xml) = cl_web_http_utility=>decode_utf8( encoded = lv_xml ).
        DATA(ls_template) = lo_store->get_template_by_name(
        iv_get_binary    = abap_true
            iv_form_name     = 'ZPP_PROJECT_SUMMARY'
            iv_template_name = 'ZPP_PROJECT_SUMMARY_WISE'
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
         lv_name = |Invoice { wa_header-Material }|.
         data(lv_gno) = value #( hdr[ 1 ]-Material OPTIONAL ).


         cl_print_queue_utils=>create_queue_item_by_data(
            iv_qname            = printque
            iv_print_data       = lv_pdf
            iv_name_of_main_doc = lv_name
            iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
          ).

           CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
           data(lv_error4) = 1.

        ENDTRY.

        data: gs_att TYPE ZPP_REP_TB.

            if lv_pdf is NOT INITIAL.
            gs_att-material = wa_header-Material.
            gs_att-attachment = lv_pdf.
            gs_att-filename = wa_header-Material.
            gs_att-mimetype = 'application/pdf'.

            APPEND gs_att to zbp_pp_report_hrv=>up_attach.

        ENDIF.
        ENDIF.

        result = VALUE #( For ls_ord in hdr (
        %tky = ls_ord-%tky
        %param = ls_ord ) ).
**********************************************************************

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_REPORT_HRV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_REPORT_HRV IMPLEMENTATION.

  METHOD save_modified.
              MODIFY ZPP_REP_TB FROM TABLE @zbp_pp_report_hrv=>up_attach.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
