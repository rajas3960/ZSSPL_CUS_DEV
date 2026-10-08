CLASS ztest_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA:
      mo_http_destination TYPE REF TO if_http_destination,
      mv_client           TYPE REF TO if_web_http_client.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZTEST_CLASS IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    TRY.
*        "Initialize Template Store Client
*        DATA(lo_client) = NEW zcl_fp_client(
*          iv_name = 'restapi'
*          iv_service_instance_name = 'YY1_MMADSBTP001_REST'
*        ).
*
*        "Get form template data
*        DATA(ls_template) = lo_client->get_template_by_name(
*          iv_get_binary     = abap_true
*          iv_form_name      = 'Invoice'
*          iv_template_name  = 'InvoiceTemplate'
*        ).
*
* CATCH zcx_fp_tmpl_store_error
*      INTO DATA(ls_excep).
*        out->write( ls_template-template_name ).
*    ENDTRY.
*  ENDMETHOD.
*ENDCLASS.
try.
      "Initialize Template Store Client
      data(lo_store) = new zcl_fp_client(
        iv_name = 'restapi'
        iv_service_instance_name = 'YY1_MMADSBTP001_REST'
      ).
      "Initialize Template Store Client (using custom comm scenario)
      "data(lo_store) = new ZCL_FP_TMPL_STORE_CLIENT(
      "  iv_service_instance_name = 'ZADSTEMPLSTORE'
      "  iv_use_destination_service = abap_false
      ").
      out->write( 'Template Store Client initialized' ).
      "Initialize class with service definition
      data(lo_fdp_util) = cl_fp_fdp_services=>get_instance( 'ZMM_PURCHASE_REQ_ROOT' ).
      out->write( 'Dataservice initialized' ).

      try.
        lo_store->get_schema_by_name( iv_form_name = 'YY1_INDENTFORM01' ).
        out->write( 'Schema found in form' ).
      catch zcx_fp_tmpl_store_error into data(lo_tmpl_error).
        out->write( 'No schema in form found' ).
        if lo_tmpl_error->mv_http_status_code = 404.
          "Upload service definition
          lo_store->set_schema(
            iv_form_name = 'YY1_INDENTFORM01'
            is_data = value #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd(  )  )
          ).
        else.
          out->write( lo_tmpl_error->get_longtext(  ) ).
        ENDIF.
      endtry.
      "Get initial select keys for service
      data(lt_keys)     = lo_fdp_util->get_keys( ).
      lt_keys[ name = 'ID' ]-value = '1'.

      data(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
      out->write( 'Service data retrieved' ).

      data(ls_template) = lo_store->get_template_by_name(
        iv_get_binary     = abap_true
        iv_form_name      = 'YY1_INDENTFORM01'
        iv_template_name  = 'TEMPLATE01'
      ).
      out->write( 'Form Template retrieved' ).

      cl_fp_ads_util=>render_4_pq(
        EXPORTING
          iv_locale       = 'en_US'
          iv_pq_name      = 'PRINT_QUEUE'
          iv_xml_data     = lv_xml
          iv_xdp_layout   = ls_template-xdp_template
          is_options      = value #(
            trace_level = 4 "Use 0 in production environment
          )
        IMPORTING
          ev_trace_string = data(lv_trace)
          ev_pdl          = data(lv_pdf)
      ).
      out->write( 'Output was generated' ).

      cl_print_queue_utils=>create_queue_item_by_data(
        iv_qname = 'PRINT_QUEUE'
        iv_print_data = lv_pdf
        iv_name_of_main_doc = 'DSAG DEMO Output'
      ).
      out->write( 'Output was sent to print queue' ).

    catch cx_fp_fdp_error zcx_fp_tmpl_store_error cx_fp_ads_util into data(lo_err).
      out->write( 'Exception occurred.' ).
    endtry.
    out->write( 'Finished processing.' ).
      ENDMETHOD.
ENDCLASS.
