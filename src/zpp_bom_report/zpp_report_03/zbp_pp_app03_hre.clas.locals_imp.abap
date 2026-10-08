CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    "!
    METHODS delde FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~delde.
    "!
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR item RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR item RESULT result.

    METHODS get_select FOR MODIFY
      IMPORTING keys FOR ACTION item~get_select RESULT result.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD delde.
  ENDMETHOD.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE
  ENTITY item
  FIELDS ( Mark )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_item).

result = VALUE #(
  FOR ls_item IN lt_item (
    %tky = ls_item-%tky

    %action-get_select = COND #(
      WHEN ls_item-Mark = 'X'
        THEN if_abap_behv=>fc-o-disabled
      ELSE
        if_abap_behv=>fc-o-enabled
    )
  )
).
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_select.
**********************************************************************
    DATA: gt_item TYPE TABLE FOR CREATE zpp_app03_hre\item.
    DATA: gs_itm TYPE zpp_app03_idb.

    READ ENTITIES OF zpp_app03_hre
    IN LOCAL MODE
    ENTITY item
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    IF lt_hdr IS INITIAL.
      RETURN.
    ENDIF.

    DATA(ls_hdr) = lt_hdr[ 1 ].

    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE ENTITY item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_itm).
*    SELECT * FROM ZPP_BOM_REP
    DATA(ls_itm)  = lt_itm[ 1 ].
    DATA:ls_item TYPE zpp_app03_idb02.
**********************************************************************
    SELECT * FROM zpp_bom_rep AS hdr
         WHERE Project = @ls_itm-Proj
         AND Towertype = @ls_itm-Towertype
         AND Towersubtype = @ls_itm-Ttsub
         INTO TABLE  @DATA(ls_item1).

    SELECT SINGLE MAX( srno )
            FROM zpp_app03_idb02
            WHERE uuid = @ls_hdr-uuid
            INTO @DATA(lv_srno).
    IF lv_srno IS INITIAL.
      lv_srno = 0.
    ENDIF.
    DATA(lv_next_srno) = lv_srno.
**********************************************************************
    LOOP AT ls_item1 INTO DATA(ls).

**********************************************************************
      lv_next_srno += 1.
      CLEAR ls_item.
**********************************************************************
      ls_item-uuid = ls_hdr-Uuid.
      ls_item-srno = lv_next_srno.
      ls_item-proj = lS-Project.
      ls_item-towertype = ls-Towertype.
      ls_item-ttdesc = ls-Towertypedesc.
      ls_item-ttsub = ls-Towersubtype.
      ls_item-ttsdesc = ls-towersubtypedesc.
      ls_item-str = ls-str.
      ls_item-strdesc = ls-strdesc.
      ls_item-mark = ls-mark.
      ls_item-bom = ls-Bomno.

**********************************************************************
*      DATA(ls_item2) = lt_itm[ 1 ].

      MOVE-CORRESPONDING ls_itm TO gs_itm .

      gs_itm-mark = 'X'.
      APPEND ls_item TO zbp_pp_app03_hre=>gt_item2.

      APPEND gs_itm  TO zbp_pp_app03_hre=>gt_item.

      CLEAR : ls.
    ENDLOOP.

    SORT zbp_pp_app03_hre=>gt_item2 BY srno  ASCENDING.

    result = VALUE #( FOR ls2 IN lt_hdr ( %tky = ls2-%tky
    %param = ls2 ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zpp_app03_hre DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zpp_app03_hre IMPLEMENTATION.

  METHOD save_modified.

**********************************************************************
* Header
**********************************************************************
    IF create-hdr IS NOT INITIAL
       AND zbp_pp_app03_hre=>gt_hdr IS NOT INITIAL.

      MODIFY zpp_app03_db
        FROM TABLE @zbp_pp_app03_hre=>gt_hdr.


    ENDIF.

**********************************************************************
* Item
**********************************************************************
    IF zbp_pp_app03_hre=>gt_item IS NOT INITIAL.

      MODIFY zpp_app03_idb
        FROM TABLE @zbp_pp_app03_hre=>gt_item.

    ENDIF.
**********************************************************************
* Sub Item
**********************************************************************
    IF zbp_pp_app03_hre=>gt_item2 IS NOT INITIAL.

      MODIFY zpp_app03_idb02
        FROM TABLE @zbp_pp_app03_hre=>gt_item2.

    ENDIF.

**********************************************************************
* Merge user updated COMBI into gt_item2
**********************************************************************
*   IF zbp_pp_app03_hre=>gt_item2 IS NOT INITIAL.

*  LOOP AT update-item2 INTO DATA(ls_upd).
*
*    READ TABLE zbp_pp_app03_hre=>gt_item2
*      ASSIGNING FIELD-SYMBOL(<fs_item2>)
*      WITH KEY
*        uuid = ls_upd-uuid.
*
*    IF sy-subrc = 0.
*
*      <fs_item2>-combi = ls_upd-combi.
*
*    ENDIF.
*
*  ENDLOOP.

    DATA: gs_upitem2 TYPE zpp_app03_idb02.

    LOOP AT update-item2 INTO DATA(ls_upd).

      SELECT SINGLE * FROM zpp_app03_idf02 WITH PRIVILEGED ACCESS
          WHERE uuid = @ls_upd-Uuid
          AND srno = @ls_upd-Srno
          INTO @DATA(ls_up).

      MOVE-CORRESPONDING ls_up TO gs_upitem2.

      MODIFY zpp_app03_idb02 FROM @gs_upitem2.

    ENDLOOP.
    IF zbp_pp_app03_hre=>up_attach IS NOT INITIAL.

      MODIFY zpp_rel_db FROM TABLE @zbp_pp_app03_hre=>up_attach.
    ENDIF.

*  MODIFY zpp_app03_idb02
*      FROM TABLE @zbp_pp_app03_hre=>gt_item2.

*ENDIF.

**********************************************************************
* Delete
**********************************************************************
    IF delete-hdr IS NOT INITIAL.

      LOOP AT delete-hdr INTO DATA(ls_del).

        DELETE FROM zpp_app03_db
          WHERE uuid = @ls_del-uuid.

        DELETE FROM zpp_app03_idb
          WHERE uuid = @ls_del-uuid.

        DELETE FROM zpp_app03_idb02
          WHERE uuid = @ls_del-uuid.

      ENDLOOP.

    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR hdr RESULT result.

    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR hdr~gt_data1.
    "!
    METHODS gt_section FOR MODIFY
      IMPORTING keys FOR ACTION hdr~gt_section RESULT result.
    "!
    METHODS gen_pt FOR MODIFY
      IMPORTING keys FOR ACTION hdr~gen_pt RESULT result.


ENDCLASS.

CLASS lhc_hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1) .

**********************************************************************
    result = VALUE #(
      FOR ls_data IN lt_hdr (
        %tky = ls_data-%tky

        %action-gt_section = COND #(
          WHEN ls_data-Reldocno IS NOT INITIAL
          THEN if_abap_behv=>fc-o-enabled
          ELSE if_abap_behv=>fc-o-disabled )
      )
    ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
****************************************************************
    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1) .

**********************************************************************
    result = VALUE #(
     FOR ls_hdr IN lt_hdr (
       %tky = ls_hdr-%tky
       %action-gt_section = COND #(
         WHEN lt_item IS NOT INITIAL
           THEN if_abap_behv=>fc-o-disabled
         ELSE if_abap_behv=>fc-o-enabled
       )
     )
   ).
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD gt_data1.
**********************************************************************
    DATA : gs_hdr   TYPE zpp_app03_db,
           gs_item2 TYPE zpp_app03_idb02,
           lv_numb  TYPE n LENGTH 3,
           lv_last  TYPE zpp_app03_db-reldocno.

    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item2).

    DATA(ls_hdr) = lt_hdr[ 1 ].

    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
    gs_hdr-realeasdt = cl_abap_context_info=>get_system_date( ).
    SELECT SINGLE MAX( reldocno )
    FROM zpp_app03_db
    WHERE reldocs = @gs_hdr-reldocs
    INTO @lv_last.

    IF lv_last IS NOT INITIAL.
      lv_numb = lv_last+5(3).   " Gets 001 from M2606001
      lv_numb = lv_numb + 1.
    ELSE.
      lv_numb = 1.
    ENDIF.
**********************************************************************
*    SELECT
*    p~Material,
*    bom~YY1_BOM_Number_BMH,
*    bom~YY1_Drawing_Number_BMH,
*    bom~YY1_Reference_Doc_No_BMH
*     FROM zpp_rp01_rv as p
*     LEFT JOIN zpp_rp01_rv AS _shdr ON _shdr~Material = p~BillOfMaterialComponent
*     LEFT JOIN I_BILLOFMATERIALTP_2 as bom on bom~Material = _shdr~BillOfMaterialComponent
*    where p~Material = @gs_hdr-matnr
*    and p~Plant = '1030'
*    into TABLE @data(lt_bom).



    IF gs_hdr-reldocs IS NOT INITIAL.
      CASE gs_hdr-reldocs.
        WHEN 'P'.
          gs_hdr-reldocno = |P{ sy-datum+2(2) }{ sy-datum+4(2) }{ lv_numb WIDTH = 5 PAD = '0' }|.
        WHEN 'M'.
          gs_hdr-reldocno = |M{ sy-datum+2(2) }{ sy-datum+4(2) }{ lv_numb WIDTH = 5 PAD = '0' }|.
      ENDCASE.
    ELSE.
      DATA: lv_text TYPE string.
      lv_text = 'You Dont have the Structure'.
      APPEND VALUE #(  %tky = ls_hdr-%tky
        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
    text = lv_text )
          ) TO reported-hdr.
      APPEND VALUE #( %tky = ls_hdr-%tky  ) TO lt_hdr.

    ENDIF.
    APPEND gs_hdr TO zbp_pp_app03_hre=>gt_hdr.
**********************************************************************
  ENDMETHOD.



  METHOD gt_section.
**********************************************************************
    DATA : gs_hdr  TYPE zpp_app03_db,
           gs_item TYPE zpp_app03_idb.
**********************************************************************
    READ ENTITIES OF zpp_app03_hre
    IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT * FROM zpp_bom_re AS _hdr
    WHERE Project = @ls_hdr-Matnr
    INTO TABLE @DATA(lt_item).

    SELECT SINGLE MAX( srno )
        FROM zpp_app03_idb
        WHERE uuid = @ls_hdr-uuid
        INTO @DATA(lv_srno).
    IF lv_srno IS INITIAL.
      lv_srno = 1.
    ENDIF.
**********************************************************************

    IF lt_item IS NOT INITIAL.
      LOOP AT lt_item INTO DATA(ls).
        " Generate UNIQUE CID every time

        gs_item-Uuid = ls_hdr-Uuid.
        gs_item-srno = lv_srno + gs_item-srno.
        gs_item-Proj = ls-Project.
        gs_item-Towertype = ls-Towertype.
        gs_item-Ttdesc = ls-Towertypedesc.
        gs_item-Ttsub = ls-Towersubtype.
        gs_item-Ttsdesc = ls-towersubtypedesc.
        APPEND gs_item TO zbp_pp_app03_hre=>gt_item.
        CLEAR : ls.
      ENDLOOP.
    ELSE.
*      DATA: lv_text TYPE string.
*      lv_text = 'You Dont have the Structure'.
*      APPEND VALUE #(  %tky = ls_hdr-%tky
*        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
*    text = lv_text )
*          ) TO reported-hdr.
*      APPEND VALUE #( %tky = ls_hdr-%tky  ) TO failed-hdr.

    ENDIF.
    result = VALUE #( FOR ls2 IN lt_hdr ( %tky = ls2-%tky
    %param = ls2 ) ).
  ENDMETHOD.

  METHOD Gen_pt.

    READ ENTITIES OF zpp_app03_hre IN LOCAL MODE
     ENTITY hdr
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(hdr)
     ENTITY hdr BY \item2
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(item)
     FAILED DATA(failes).
    DATA(wa_header) = hdr[ 1 ].

    IF wa_header-Uuid IS NOT INITIAL.
      TRY.
          DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
          iv_name        = 'ZTEST_CS'
          iv_service_instance_name = 'ZTEST_OS_REST' ).
          DATA(lo_fdp_util) =  cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_APP03_HCE_UI'
                                                                iv_root_node = 'ZPP_APP03_HCE' ) .
          DATA : printque TYPE c LENGTH 32.
          printque = 'ADOBE_DEFAULT'.
          TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZPP_RELEASE' ).
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
          lt_keys[ name = 'RELDOCNO' ]-value = hdr[ 1 ]-Reldocno .
          DATA(lt_xsd) = lo_fdp_util->get_xsd( ).
          DATA(lv_text) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).

          TRY.
              DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
              DATA(lv_test) =  cl_web_http_utility=>decode_utf8( encoded = lv_xml ).

            CATCH cx_fp_fdp_error INTO DATA(lo_exception).
              DATA(lv_error) = 1.
          ENDTRY.
*        DATA(lv_xml) = cl_web_http_utility=>decode_utf8( encoded = lv_xml ).
          DATA(ls_template) = lo_store->get_template_by_name(
          iv_get_binary    = abap_true
              iv_form_name     = 'ZPP_RELEASE'
              iv_template_name = 'ZPP_REL'
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
          lv_name = |Invoice { wa_header-Reldocno }|.
          DATA(lv_gno) = VALUE #( hdr[ 1 ]-Reldocno OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
             iv_qname            = printque
             iv_print_data       = lv_pdf
             iv_name_of_main_doc = lv_name
             iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
           ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lv_error2) = 1.

      ENDTRY.

      DATA: gs_att TYPE zpp_rel_db.

      IF lv_pdf IS NOT INITIAL.
        gs_att-reldocno = wa_header-Reldocno.
        gs_att-attachment = lv_pdf.
        gs_att-filename = wa_header-Reldocno.
        gs_att-mimetype = 'application/pdf'.

        APPEND gs_att TO zbp_pp_app03_hre=>up_attach.

      ENDIF.
    ENDIF.

    result = VALUE #( FOR ls_ord IN hdr (
    %tky = ls_ord-%tky
    %param = ls_ord ) ).

  ENDMETHOD.

ENDCLASS.
