CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS GtSect FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~GtSect RESULT result.

    METHODS gt_section FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gt_section RESULT result.

    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_data1.
    METHODS get_jc FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~get_jc RESULT result.
    METHODS valditaion FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~valditaion RESULT result.
    "!
    METHODS porel FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~porel RESULT result.
    METHODS secpro FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~secpro RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_apps01_re IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_item1
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1)
     BY \_op
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_op).
***********************************************************************
    result = VALUE #(
      FOR ls_hdr IN lt_hdr (
        %tky = ls_hdr-%tky
        %action-gt_section = COND #(
          WHEN lt_item IS NOT INITIAL
          THEN if_abap_behv=>fc-o-disabled
          ELSE if_abap_behv=>fc-o-enabled
        )
        %update = COND #( WHEN lt_item IS NOT INITIAL
        THEN
        if_abap_behv=>fc-o-disabled
        ELSE if_abap_behv=>fc-o-enabled
        )
        %action-Valditaion =  COND #(
        WHEN ls_hdr-checkstatus IS INITIAL
        THEN if_abap_behv=>fc-o-enabled
        ELSE if_abap_behv=>fc-o-disabled
        )
        %action-get_Jc =  COND #(
        WHEN ls_hdr-CheckStatus = 'X'
        THEN if_abap_behv=>fc-o-enabled
        ELSE if_abap_behv=>fc-o-disabled
        )
        %action-porel =  COND #(
        WHEN ls_hdr-CheckStatus = 'X'
        THEN if_abap_behv=>fc-o-enabled
        ELSE if_abap_behv=>fc-o-disabled
        )
        %action-secpro =  COND #( WHEN lt_op IS  INITIAL
        THEN if_abap_behv=>fc-o-enabled
        ELSE if_abap_behv=>fc-o-disabled
        )
*        %action-porel =  COND #(
*        WHEN ls_hdr-relstatus = 'S' AND ls_hdr-checkstatus <> 'X'
*        THEN if_abap_behv=>fc-o-disabled
*        ELSE if_abap_behv=>fc-o-enabled
*        )
      )
    ).
**********************************************************************

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD GtSect.
  ENDMETHOD.

  METHOD gt_section.
    DATA: gt_item TYPE TABLE FOR CREATE zpp_apps01_re\_item.
**********************************************************************
    READ ENTITIES OF zpp_apps01_re
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT * FROM zpp_production_rep AS hdr
    WHERE hdr~Material = @ls_hdr-Material
    AND   hdr~Plant = @ls_hdr-Plant
    AND   hdr~Batch = @ls_hdr-Batch
    INTO TABLE @DATA(lt_item).
**********************************************************************
    DATA:ls_item TYPE zpp_apps01_itb.
**********************************************************************
    LOOP AT lt_item INTO DATA(ls).
      ls_item-Uuid = ls_hdr-Uuid.
      ls_item-productionorder = ls-ProductionOrder.
      ls_item-productionorderitem = ls-ProductionOrderOperation.
      ls_item-material = ls-Product.
      ls_item-rawmaterial = ls-Material.
      ls_item-batch = ls-Batch.
      ls_item-saleorder = ls-SalesOrder.
      ls_item-saleorderitem = ls-SalesOrderItem.
      ls_item-palnpc =  ls-PlannedYieldQuantity.
      ls_item-menge = ls-PlannedTotalQtyInBaseUnit.
      ls_item-meins = ls-um.
      ls_item-unitwt = ls-yy1_unit_wgt_prd.
      APPEND ls_item TO zbp_pp_apps01_re=>gt_item.
      CLEAR : ls.
    ENDLOOP.
    result = VALUE #( FOR ls2 IN lt_hdr ( %tky = ls2-%tky
      %param = ls2 ) ).
**********************************************************************
  ENDMETHOD.

  METHOD gt_data1.
    DATA: gs_hdr  TYPE zpp_apps01_tb,
          lv_numb TYPE n LENGTH 5,
          lv_last TYPE zpp_apps01_tb-jcnum.

    READ ENTITIES OF zpp_apps01_re IN LOCAL MODE ENTITY _hdr
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].

    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
    gs_hdr-grnno = ls_hdr-grnno.
    gs_hdr-remark = ls_hdr-remark.
    gs_hdr-plant_d = ls_hdr-Plantdesc.
    gs_hdr-totqty = ls_hdr-Totqty.
    gs_hdr-cdate = cl_abap_context_info=>get_system_date( ).
    SELECT SINGLE MAX( jcnum )
      FROM zpp_apps01_tb
      WHERE jcseries = @gs_hdr-jcseries
      INTO @lv_last.

    IF lv_last IS NOT INITIAL.
      lv_numb = lv_last+6(5).   " numeric part starts after -
      lv_numb = lv_numb + 1.
    ELSE.
      lv_numb = 1.
    ENDIF.

    CASE gs_hdr-jcseries.

      WHEN 'JB'.
        gs_hdr-jcnum = |JB{ sy-datum+2(2) }Y-{ lv_numb WIDTH = 5 PAD = '0' }|.

      WHEN 'JN'.
        gs_hdr-jcnum = |JN{ sy-datum+2(2) }Y-{ lv_numb WIDTH = 5 PAD = '0' }|.

      WHEN 'JQ'.
        gs_hdr-jcnum = |JQ{ sy-datum+2(2) }Y-{ lv_numb WIDTH = 5 PAD = '0' }|.

    ENDCASE.
**********************************************************************
*    SELECT SINGLE
*      FROM zpp_apps01_matnr FIELDS Supplier,Batch,mat,matnr,SupplierName
*      WHERE matnr = @ls_hdr-Material
*      AND mat = @ls_hdr-grnno
*      AND Batch = @ls_hdr-Batch
*      INTO @DATA(ls).
    SELECT SINGLE FROM zpp_supplier FIELDS Supplier,SupplierName
    WHERE Product = @ls_hdr-Material
    AND Batch = @ls_hdr-Batch
    AND BatchBySupplier = @ls_hdr-grnno
    INTO @DATA(ls).

        IF sy-subrc = 0.
      gs_hdr-supplier = ls-Supplier.
      gs_hdr-suppliername = ls-SupplierName.
    ENDIF.

**********************************************************************
*SELECT SINGLE
*    FROM zpp_apps01_operv FIELDS WorkCenter,Uuid,ProductionOrderOperationText
*    WHERE Matnr = @ls_hdr-Material
*    and batch = @ls_hdr-Batch
*    AND ProductionOrderOperationText = 'Forging'
*    INTO @DATA(LS_WC).
*     IF sy-subrc = 0.
*     gs_hdr-machine = ls_wc-WorkCenter.
*    ENDIF.
**********************************************************************

    APPEND gs_hdr TO zbp_pp_apps01_re=>gt_hdr.


  ENDMETHOD.

  METHOD get_Jc.
    READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
          ENTITY _hdr
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(hdr)
          ENTITY _hdr BY \_item1
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(item)
          FAILED DATA(failes).
    DATA(wa_header) = hdr[ 1 ].
    IF wa_header-Jcnum IS NOT INITIAL.
      TRY.
          DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
          iv_name        = 'ZTEST_CS'
          iv_service_instance_name = 'ZTEST_OS_REST' ).
          DATA(lo_fdp_util) =  cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_APPS01_SCE'
                                                                iv_root_node = 'ZPP_APPS01_HCE' ) .
          DATA : printque TYPE c LENGTH 32.
          printque = 'ADOBE_DEFAULT'.
          TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZPP_JB' ).
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
          lt_keys[ name = 'JCNUM' ]-value = hdr[ 1 ]-Jcnum .
          DATA(lt_xsd) = lo_fdp_util->get_xsd( ).
          DATA(lv_text) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).

          TRY.
              DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
              DATA(lv_test) =  cl_web_http_utility=>decode_utf8( encoded = lv_xml ).

            CATCH cx_fp_fdp_error INTO DATA(lo_exception).
              DATA(lv_var) = 1.
          ENDTRY.
*        DATA(lv_xml) = cl_web_http_utility=>decode_utf8( encoded = lv_xml ).
          DATA(ls_template) = lo_store->get_template_by_name(
          iv_get_binary    = abap_true
              iv_form_name     = 'ZPP_JB'
              iv_template_name = 'ZPP_JOBCARD'
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
          lv_name = |Invoice { wa_header-Jcnum }|.
          DATA(lv_gno) = VALUE #( hdr[ 1 ]-Jcnum OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
             iv_qname            = printque
             iv_print_data       = lv_pdf
             iv_name_of_main_doc = lv_name
             iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
           ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lv_vr) = 1.

      ENDTRY.

      DATA: gs_att TYPE zpp_form_db.

      IF lv_pdf IS NOT INITIAL.
        gs_att-jcnum = wa_header-Jcnum.
        gs_att-attachment = lv_pdf.
        gs_att-filename = wa_header-Jcnum.
        gs_att-mimetype = 'application/pdf'.

        APPEND gs_att TO zbp_pp_apps01_re=>up_attach.

      ENDIF.
    ENDIF.

    result = VALUE #( FOR ls_ord IN hdr (
    %tky = ls_ord-%tky
    %param = ls_ord ) ).
  ENDMETHOD.

  METHOD Valditaion.
**********************************************************************
    READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
ENTITY _hdr
FIELDS ( Uuid Totqty )
WITH CORRESPONDING #( keys )
RESULT DATA(gt_totqty).

    READ TABLE gt_totqty INTO DATA(gs_totqty) INDEX 1.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.
**********************************************************************
    SELECT SINGLE toty
      FROM zpp_apps01_tqty
      WHERE uuid = @gs_totqty-Uuid
      INTO @DATA(lv_toty).

      SELECT SINGLE
      FROM zpp_apps01_irv FIELDS
      Uuid
      WHERE Uuid = @gs_totqty-Uuid
      INTO @DATA(lv_item).


**********************************************************************
        IF lv_item IS INITIAL.
          DATA(lv_msg1) = |Please Click On The Fetch So Button|.
          APPEND VALUE #( %tky = gs_totqty-%tky )
                      TO failed-_hdr.

          APPEND VALUE #( %tky           = gs_totqty-%tky
                          %state_area    = 'Validate_Header'
                          %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg1 )   )
                 TO reported-_hdr.
        ELSEIF lv_toty IS INITIAL.
          DATA(lv_msg2) = |Please Click On The Select Button|.
          APPEND VALUE #( %tky = gs_totqty-%tky )
                      TO failed-_hdr.

          APPEND VALUE #( %tky           = gs_totqty-%tky
                          %state_area    = 'Validate_Header'
                          %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg2 )   )
                 TO reported-_hdr.

        ELSEIF lv_toty > gs_totqty-Totqty.

          APPEND VALUE #( %tky = gs_totqty-%tky )
            TO failed-_hdr.

          APPEND VALUE #(
              %tky = gs_totqty-%tky
              %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text     = |Planned Qty is exceeding the required qty|
                     )
              %element-Totqty = if_abap_behv=>mk-on
            )
            TO reported-_hdr.

        ELSE.

          READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
      ENTITY _hdr
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdr).

          READ TABLE lt_hdr INTO DATA(ls_hdr) INDEX 1.

          IF sy-subrc = 0.
            ls_hdr-checkstatus = 'X'.

            APPEND CORRESPONDING #( ls_hdr ) TO zbp_pp_apps01_re=>gt_hdr.
          ENDIF.

        ENDIF.

***********************************************************************
        result = VALUE #(
    FOR ls IN gt_totqty
    (
    %tky   = ls-%tky
    %param = ls
    )
    ).
      ENDMETHOD.

      METHOD porel.
**********************************************************************
        DATA : gs_hdr TYPE zpp_apps01_tb.
**********************************************************************
        READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
        ENTITY _hdr
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_hdr)
        BY \_item
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_item)
        BY \_item1
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_item1).
        DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
        IF lt_item1 IS NOT INITIAL.
          LOOP AT lt_item1 INTO DATA(ls_item1).

            MODIFY ENTITY PRIVILEGED  i_productionordertp
       EXECUTE release
       FROM VALUE #( ( %key-productionorder = ls_item1-Productionorder
                       %param-ordrelispmtddsptmisgparts = abap_true ) )
       REQUEST VALUE #(  )
       RESULT DATA(result1)
       FAILED DATA(failed1)
       REPORTED DATA(reported1).
          ENDLOOP.
          IF failed1 IS INITIAL.

            IF reported1-productionorder IS NOT INITIAL.

              APPEND VALUE #(
                  %tky = ls_item1-%tky
                  %msg = new_message_with_text(
                            severity = if_abap_behv_message=>severity-success
                            text     = 'PRODUCTION ORDER RELEASED'
                         )
              ) TO reported-_item1.

            ENDIF.

          ELSE.

            LOOP AT failed1-productionorder INTO DATA(ls_rep1).
              APPEND VALUE #(
                  %tky  = ls_item1-%tky
                  %fail = ls_rep1-%fail
              ) TO failed-_item1.
              APPEND VALUE #(
                    %tky = ls_item1-%tky
                    %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Production Order already released'
                 )
              ) TO reported-_item1.
            ENDLOOP.


**********************************************************************

          ENDIF.

**********************************************************************
        ENDIF.
**********************************************************************
        result = VALUE #(
          FOR ls1 IN lt_hdr (
            %tky   = ls1-%tky
            %param = ls1
          )
        ).



      ENDMETHOD.

      METHOD secpro.
**********************************************************************
        DATA : gs_hdr TYPE zpp_apps01_tb.
**********************************************************************
        READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
        ENTITY _hdr
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_hdr)
        BY \_item
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_item)
        BY \_item1
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_item1).
        DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
        DATA:ls_op TYPE zpp_operation_db.
**********************************************************************
        SELECT
        FROM zpp_apps01_operv
        FIELDS Uuid ,
        ProductionOrderOperationText,
        WorkCenter,
        ProductionOrderOperation
        WHERE Uuid = @ls_hdr-Uuid
        INTO TABLE @DATA(lt_op).
**********************************************************************
          LOOP AT lt_op INTO DATA(ls).
            ls_op-Uuid = ls_hdr-Uuid.
            ls_op-process = ls-ProductionOrderOperationText.
            ls_op-processno = ls-ProductionOrderOperation.
            ls_op-machine = ls-WorkCenter.
            APPEND ls_op TO zbp_pp_apps01_re=>gt_item3.
            CLEAR : ls.
          ENDLOOP.
          SORT zbp_pp_apps01_re=>gt_item3 BY processno ASCENDING.
***********************************************************************
          result = VALUE #( FOR ls2 IN lt_hdr ( %tky = ls2-%tky
          %param = ls2 ) ).

        ENDMETHOD.

ENDCLASS.

CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.
PRIVATE SECTION.

  METHODS get_instance_features FOR INSTANCE FEATURES
    IMPORTING keys REQUEST requested_features FOR _item RESULT result.

  METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
    IMPORTING keys REQUEST requested_authorizations FOR _item RESULT result.

  METHODS gt_selection FOR MODIFY
    IMPORTING keys FOR ACTION _item~gt_selection RESULT result.

ENDCLASS.

CLASS lhc__item IMPLEMENTATION.
METHOD get_instance_features.
**********************************************************************
  READ ENTITIES OF zpp_apps01_re IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr)
  BY \_item
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_item).
**********************************************************************
  result = VALUE #( FOR ls IN lt_item ( %tky = ls-%tky
     %action-gt_selection =  COND #( WHEN ls-Mark IS NOT INITIAL
                                                                     THEN if_abap_behv=>fc-o-disabled
                                                                     ELSE
                                                                     if_abap_behv=>fc-o-enabled
                                                                     )
      ) ).
***********************************************************************
ENDMETHOD.

METHOD get_instance_authorizations.
ENDMETHOD.

METHOD gt_selection.
  DATA : gt_item TYPE TABLE FOR CREATE zpp_apps01_re\_item.
  DATA : gs_itm  TYPE zpp_apps01_itb.
  READ ENTITIES OF zpp_apps01_re
  IN LOCAL MODE
  ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_hdr).

  READ ENTITIES OF zpp_apps01_re IN LOCAL MODE ENTITY _item
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(lt_itm).

*  DATA(LV) = lines( lt_itm ).
**********************************************************************
  DATA(ls_hdr) = lt_hdr[ 1 ].

**********************************************************************
*SELECT * FROM ZPP_PRODUCTION_REP AS hdr
*WHERE HDR~Material = @ls_hdr-Material
*AND   HDR~Plant = @ls_hdr-Plant
*INTO TABLE @DATA(LT_ITEM).
**********************************************************************
  DATA:ls_item TYPE zpp_apps01_itb01.
**********************************************************************
  LOOP AT lt_itm INTO DATA(ls).
    SELECT SINGLE * FROM zpp_production_rep AS hdr
    WHERE ProductionOrder = @ls-Productionorder
*AND   HDR~Plant = @ls_hdr-Plant
    INTO @DATA(Ls_ITEM1).
**********************************************************************

      SELECT FROM zpp_apps01_process AS pc FIELDS
      StandardTextInternalID,ManufacturingOrder,ManufacturingOrderOperation
      WHERE ManufacturingOrder = @ls-Productionorder
      INTO TABLE @DATA(ls_itm).
        SORT ls_itm BY ManufacturingOrderOperation ASCENDING.
**********************************************************************
        ls_item-Uuid = ls_hdr-Uuid.
        ls_item-productionorder = ls-ProductionOrder.
        ls_item-productionorderitem = Ls_ITEM1-ProductionOrderOperation.
        ls_item-saleorder = Ls_ITEM1-SalesOrder.
        ls_item-saleorderitem = Ls_ITEM1-SalesOrderItem.
        ls_item-matnr = Ls_ITEM1-Product.
        ls_item-maktx = Ls_ITEM1-ProductName.
        ls_item-duedate = Ls_ITEM1-PlannedOrderPlannedDeliveryDte.
        ls_item-pcs =  Ls_ITEM1-PlannedYieldQuantity.
        ls_item-customer = ls_item1-CustomerName.
        ls_item-menge = Ls_ITEM1-PlannedTotalQtyInBaseUnit.
        ls_item-meins = Ls_ITEM1-um.
        ls_item-batch = ls_item1-Batch.
        ls_item-rawmatnr = ls_item1-Material.
        ls_item-mark = 'X'.
        ls_item-party = ls_item1-PurchaseOrderByCustomer.
        ls_item-unitwt = Ls_ITEM1-yy1_unit_wgt_prd.
        ls_item-process = REDUCE string(
            INIT result1 TYPE string
            FOR ls2 IN ls_itm
            WHERE ( ManufacturingOrder = ls-Productionorder )
            NEXT result1 = result1 && ls2-StandardTextInternalID
          ).
**********************************************************************
        DATA(ls_item2) = lt_itm[ 1 ].

        MOVE-CORRESPONDING ls_item2 TO gs_itm .

        gs_itm-mark = 'X'.

**********************************************************************


        APPEND ls_item TO zbp_pp_apps01_re=>gt_item2.

        APPEND gs_itm  TO zbp_pp_apps01_re=>gt_item.

        CLEAR : ls.
      ENDLOOP.

    ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS01_RE DEFINITION INHERITING FROM cl_abap_behavior_saver.
PROTECTED SECTION.

  METHODS save_modified REDEFINITION.

  METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS01_RE IMPLEMENTATION.

METHOD save_modified.
*    IF create-_hdr IS NOT INITIAL.
  IF zbp_pp_apps01_re=>gt_hdr IS NOT INITIAL.
************************************************************************
    DATA(lt_atch) = zbp_pp_apps01_re=>gt_hdr[ 1 ].
    DELETE FROM zpp_form_db WHERE jcnum = @lt_atch-jcnum.
    MODIFY zpp_apps01_tb FROM TABLE @zbp_pp_apps01_re=>gt_hdr.

  ENDIF.

  IF zbp_pp_apps01_re=>gt_item IS NOT INITIAL.
    MODIFY zpp_apps01_itb FROM TABLE @zbp_pp_apps01_re=>gt_item.
  ENDIF.
  IF zbp_pp_apps01_re=>gt_item2 IS NOT INITIAL.
    MODIFY zpp_apps01_itb01 FROM TABLE @zbp_pp_apps01_re=>gt_item2.
  ENDIF.
  IF zbp_pp_apps01_re=>gt_item3 IS NOT INITIAL.
    MODIFY zpp_operation_db FROM TABLE @zbp_pp_apps01_re=>gt_item3.
  ENDIF.
***********************************************************************
  IF delete-_hdr IS NOT INITIAL.
    LOOP AT delete-_hdr INTO DATA(ls_hdr).
      DELETE FROM zpp_apps01_tb WHERE uuid = @ls_hdr-Uuid.
      DELETE FROM zpp_apps01_itb WHERE uuid = @ls_hdr-Uuid.
      DELETE FROM zpp_apps01_itb01 WHERE uuid = @ls_hdr-Uuid.
      DELETE FROM zpp_operation_db WHERE uuid = @ls_hdr-Uuid.
    ENDLOOP.
  ENDIF.
**********************************************************************
  IF zbp_pp_apps01_re=>up_attach IS NOT INITIAL.


    MODIFY zpp_form_db FROM TABLE @zbp_pp_apps01_re=>up_attach.
  ENDIF.
***********************************************************************
ENDMETHOD.

METHOD cleanup_finalize.
ENDMETHOD.

ENDCLASS.
