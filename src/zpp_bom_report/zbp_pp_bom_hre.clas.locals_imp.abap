CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.


    METHODS printBom FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~printBom RESULT result.

    METHODS seltitem FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~seltitem RESULT result.

    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_data1.
    METHODS validation FOR VALIDATE ON SAVE
      IMPORTING keys FOR _hdr~validation.
    METHODS bomdate FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~bomdate.
    METHODS selsec FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~selsec RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_item1
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1) .

**********************************************************************
    result = VALUE #(
      FOR ls_data IN lt_hdr (
        %tky = ls_data-%tky

        %action-seltitem = COND #(
          WHEN ls_data-Bomnumber IS NOT INITIAL
           AND lt_item IS INITIAL
          THEN if_abap_behv=>fc-o-enabled
          ELSE if_abap_behv=>fc-o-disabled )

        %action-selsec = COND #(
          WHEN lt_item IS NOT INITIAL
          AND lt_item1 IS INITIAL
          THEN if_abap_behv=>fc-o-enabled
          ELSE if_abap_behv=>fc-o-disabled )

        %action-printBom = COND #(
          WHEN lt_item1 IS NOT INITIAL
          THEN if_abap_behv=>fc-o-enabled
          ELSE if_abap_behv=>fc-o-disabled )
      )
    ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD seltitem.

********************************************************************************************************************************************
    DATA:gs_hdr TYPE zpp_bom_htb.
    DATA : gs_item TYPE zpp_bom_itb.
**********************************************************************
    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( Keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].

***********************************************************************
*  SELECT BillOfMaterialComponent FROM   ZPP_RP01_RV
*  WHERE Material = @ls_hdr-Structure
*  AND Plant = '1030'
*  INTO TABLE @DATA(LS_DATA).
***********************************************************************
*if ls_data is not inITIAL.
*  SELECT  BillOfMaterialComponent FROM ZPP_RP01_RV
*  FOR ALL ENTRIES IN @LS_DATA
*  WHERE Material = @ls_data-BillOfMaterialComponent
*  INTO TABLE @DATA(LS_DATA1).
*  endif.
*
*if ls_data1 is not initial.
*  SELECT Product,ProductGroup FROM I_Product
*  FOR ALL ENTRIES IN @LS_DATA1
*  WHERE Product = @ls_data1-BillOfMaterialComponent
*        AND ( ProductGroup = 'PLATE'
*        OR ProductGroup = 'ANGLE')
*  INTO TABLE @DATA(LT_PORD).
*  endif.
***********************************************************************
*if ls_data is not inITIAL.
*  SELECT BillOfMaterialComponent,ComponentDescription,
*  YY1_matlength_BMI,YY1_matwidth_BMI,yy1_untwgt_bmi,BillOfMaterialItemQuantity,yy1_totwgt_bmi,yy1_wgtpc_bmi
*   FROM I_BillOfMaterialItemTP_2
*  FOR ALL ENTRIES IN @LS_DATA
*  WHERE Material = @LS_DATA-BillOfMaterialComponent
*  INTO TABLE @DATA(lt_item).
*  endif.

    SELECT
ptc~Product,
 ptc~ProductGroup,
 bom~BillOfMaterialComponent,
 bom~ComponentDescription,
 bom~YY1_matlength_BMI,
 bom~YY1_matwidth_BMI,
 bom~yy1_untwgt_bmi,
 bom~BillOfMaterialItemQuantity,
 bom~yy1_totwgt_bmi,
 bom~yy1_wgtpc_bmi
FROM zpp_rp01_rv AS _hdr
LEFT JOIN zpp_rp01_rv AS _shdr ON _shdr~Material = _hdr~BillOfMaterialComponent
LEFT JOIN i_product AS ptc ON ptc~Product = _Shdr~BillOfMaterialComponent
LEFT JOIN I_BillOfMaterialItemTP_2 AS bom ON bom~Material = _shdr~Material
                                         AND bom~BillOfMaterialComponent = _shdr~BillOfMaterialComponent
WHERE _hdr~Material = @ls_hdr-Structure AND _hdr~Plant = '1030' AND (  ptc~ProductGroup = 'PLATE' OR ptc~ProductGroup = 'ANGLE' )
INTO TABLE @DATA(lt_item).


    SORT lt_item BY billofmaterialcomponent. DELETE ADJACENT DUPLICATES FROM lt_item COMPARING billofmaterialcomponent .


**********************************************************************
*DATA: lv_num TYPE string.
*
*LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).
*
*  lv_num = <ls_item>-BillOfMaterialComponent.
*
*  "Extract numeric part only
*  REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN lv_num WITH ''.
*
*  IF lv_num IS NOT INITIAL.
*    <ls_item>-BillOfMaterialComponent = lv_num.
*  ELSE.
*    <ls_item>-BillOfMaterialComponent = 0.
*  ENDIF.
*
*ENDLOOP.
*
**"Sort using numeric helper field
**SORT lt_item BY BillOfMaterialComponent ASCENDING.

**********************************************************************
    SELECT SINGLE MAX( srno )
        FROM zpp_bom_itb
        WHERE uuid = @ls_hdr-uuid
        INTO @DATA(lv_srno).
    IF lv_srno IS INITIAL.
      lv_srno = 1.
    ENDIF.
    LOOP AT lt_item INTO DATA(ls).
*   LOOP AT LT_PORD INTO DATA(LT) WHERE Product = ls-BillOfMaterialComponent.

**********************************************************************
      DATA: lv_num TYPE string.

      lv_num = ls-BillOfMaterialComponent.

      "Extract numeric part only
      REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN lv_num WITH ''.

      IF lv_num IS NOT INITIAL.
        ls-Product = lv_num.
      ELSE.
        ls-Product = 0.
      ENDIF.
**********************************************************************
      gs_item-uuid = ls_hdr-Uuid.
      gs_item-srno = lv_srno + gs_item-srno.
      gs_item-bomnum = ls_hdr-Bomnumber.
      gs_item-markno = ls-BillOfMaterialComponent.
      gs_item-member = ls-ProductGroup.
      gs_item-markdesc = ls-ComponentDescription.
      gs_item-leng = ls-YY1_matlength_BMI.
      gs_item-width_s = ls-YY1_matwidth_BMI.
      gs_item-unit_s = ls-yy1_untwgt_bmi.
      gs_item-quantitys = ls-BillOfMaterialItemQuantity.
      gs_item-totalwt = ls-yy1_totwgt_bmi.
      gs_item-unitperpcs = ls-yy1_wgtpc_bmi.
      gs_item-markshortno = ls-Product.
      APPEND gs_item TO zbp_pp_bom_hre=>gt_item.
      CLEAR :  ls.
*ENDLOOP.
    ENDLOOP.

    SORT zbp_pp_bom_hre=>gt_item BY  markshortno markno ASCENDING.

    result = VALUE #( FOR ls2 IN lt_hdr ( %tky = ls2-%tky
    %param = ls2 ) ).
**********************************************************************
  ENDMETHOD.

  METHOD gt_data1.
    DATA : gs_hdr TYPE  zpp_bom_htb.
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE ENTITY _hdr
      ALL FIELDS WITH CORRESPONDING #( Keys )
      RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
*
    MOVE-CORRESPONDING  ls_hdr TO gs_hdr.

    SELECT SINGLE FROM zpp_bom_htb FIELDS MAX( srno ) WHERE uuid  IS NOT INITIAL INTO  @DATA(ls_sr).
    IF ls_sr IS INITIAL.
      gs_hdr-srno = 1.
      gs_hdr-bomnum = |BOM{ gs_hdr-srno } |.
      gs_hdr-bomdat = cl_abap_context_info=>get_system_date( ).
    ELSE.
      gs_hdr-srno = ls_sr + 1.

      gs_hdr-bomnum = |BOM{ gs_hdr-srno } |.
      gs_hdr-bomdat = cl_abap_context_info=>get_system_date( ).

    ENDIF.

    SELECT SINGLE FROM i_billofmaterialtp_2 AS bp
    FIELDS YY1_Reference_Doc_No_BMH,YY1_Drawing_Number_BMH,YY1_BOM_Number_BMH
    WHERE Material = @ls_hdr-Structure
    INTO @DATA(lt_bom).

    IF lt_bom IS NOT INITIAL.
      gs_hdr-drawingno = lt_bom-YY1_Drawing_Number_BMH.
      gs_hdr-bomno = lt_bom-YY1_BOM_Number_BMH.

    ENDIF.

    APPEND gs_hdr TO zbp_pp_bom_hre=>gt_hdr.



  ENDMETHOD.

  METHOD Validation.

    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE
ENTITY _hdr
FIELDS ( Uuid Projectno Towertype Structure )
WITH CORRESPONDING #( keys )
RESULT DATA(gt_project).

    DATA(gs_project) = gt_project[ 1 ].
    DATA: gs_proj TYPE zpp_bom_htb-projectno.
    DATA: gs_structure TYPE zpp_bom_htb-structure.
    DATA : gs_towertype TYPE zpp_bom_htb-towertype.

    gs_proj = to_upper( gt_project[ 1 ]-Projectno ).
    gs_structure = to_upper( gt_project[ 1 ]-Structure ).
    gs_towertype = to_upper( gt_project[ 1 ]-Towertype ).
    SELECT
         FROM zpp_bom_htb
         FIELDS uuid
         WHERE projectno = @gs_proj
         AND structure = @gs_structure
         AND towertype = @gs_towertype
         INTO TABLE @DATA(gt_proj).

    IF gt_proj IS NOT INITIAL.
      APPEND VALUE #( %tky = gs_project-%tky )
      TO failed-_hdr.
      APPEND VALUE #( %tky = gs_project-%tky
                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                      text = 'Project is already exits' && gs_project-projectno )
                      %element-Projectno =  if_abap_behv=>mk-on )
                      TO reported-_hdr.
    ELSE.
    ENDIF.



  ENDMETHOD.

  METHOD Bomdate.

  ENDMETHOD.

  METHOD printbom.

    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE
   ENTITY _hdr
   ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(hdr)
   ENTITY _hdr BY \_item
   ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(item)
   FAILED DATA(failes).
    DATA(wa_header) = hdr[ 1 ].
    IF wa_header-Bomnumber IS NOT INITIAL.
      TRY.
          DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
          iv_name        = 'ZTEST_CS'
          iv_service_instance_name = 'ZTEST_OS_REST' ).
          DATA(lo_fdp_util) =  cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_BOM_HD_CE'
                                                                iv_root_node = 'ZPP_BOM_H_CE' ) .
          DATA : printque TYPE c LENGTH 32.
          printque = 'ADOBE_DEFAULT'.
          TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZBOM' ).
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
          lt_keys[ name = 'BOMNUM' ]-value = hdr[ 1 ]-Bomnumber .
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
              iv_form_name     = 'ZBOM'
              iv_template_name = 'zpp_bom'
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
          lv_name = |Invoice { wa_header-Bomnumber }|.
          DATA(lv_gno) = VALUE #( hdr[ 1 ]-Bomnumber OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
             iv_qname            = printque
             iv_print_data       = lv_pdf
             iv_name_of_main_doc = lv_name
             iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
           ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lv_error2) = 1.

      ENDTRY.

      DATA: gs_att TYPE zpp_bom_from.

      IF lv_pdf IS NOT INITIAL.
        gs_att-bomnum = wa_header-Bomnumber.
        gs_att-attachment = lv_pdf.
        gs_att-filename = wa_header-Bomnumber.
        gs_att-mimetype = 'application/pdf'.

        APPEND gs_att TO zbp_pp_bom_hre=>up_attach.

*        MODIFY zpp_bom_from FROM TABLE @zbp_pp_bom_hre=>up_attach.
      ENDIF.
    ENDIF.

    result = VALUE #( FOR ls_ord IN hdr (
    %tky = ls_ord-%tky
    %param = ls_ord ) ).

  ENDMETHOD.

  METHOD selsec.

    DATA: gs_sec TYPE zpp_bom_itb1.

    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE ENTITY _hdr
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].

    CLEAR zbp_pp_bom_hre=>gt_item1.

    SELECT FROM zpp_bom_section
      FIELDS uuid,
             bomnum,
             BillOfMaterialComponent,
             markdesc,
             total_weight,
             yy1_unit_wgt_prd,
             uom,
             mat_type
      WHERE uuid = @ls_hdr-Uuid
        AND bomnum = @ls_hdr-Bomnumber
      INTO TABLE @DATA(lt_sec).

    LOOP AT lt_sec INTO DATA(ls_sec).

      CLEAR gs_sec.

      gs_sec-uuid     = ls_hdr-Uuid.
      gs_sec-bomnum   = ls_hdr-Bomnumber.
      gs_sec-matnr    = ls_sec-BillOfMaterialComponent.
      gs_sec-maktx    = ls_sec-markdesc.
      gs_sec-unitwt   = ls_sec-yy1_unit_wgt_prd.
      gs_sec-totalqty = ls_sec-total_weight.
      gs_sec-mat_type = ls_sec-mat_type.


      APPEND gs_sec TO zbp_pp_bom_hre=>gt_item1.

    ENDLOOP.

    SORT zbp_pp_bom_hre=>gt_item1 BY mat_type maktx  ASCENDING.

    result = VALUE #(
      FOR ls2 IN lt_hdr
      (
        %tky   = ls2-%tky
        %param = ls2
      )
    ).

**********************************************************************

  ENDMETHOD.

ENDCLASS.

CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item RESULT result.

    METHODS selectim FOR MODIFY
      IMPORTING keys FOR ACTION _item~selectim RESULT result.

    METHODS delde FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _item~delde.

    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item~gtidata1.

ENDCLASS.

CLASS lhc__item IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD selectim.

  ENDMETHOD.

  METHOD delde.
  ENDMETHOD.

  METHOD gtidata1.
    READ ENTITIES OF zpp_bom_hre IN LOCAL MODE
    ENTITY _item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
    zbp_pp_bom_hre=>gt_item = VALUE #( FOR ls IN lt_item ( CORRESPONDING #( ls ) ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_BOM_HRE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_BOM_HRE IMPLEMENTATION.

  METHOD save_modified.
***********************************************************************
    IF create-_hdr IS NOT INITIAL.
      IF zbp_pp_bom_hre=>gt_hdr IS NOT INITIAL.
        DATA(lt_atch) = zbp_pp_bom_hre=>gt_hdr[ 1 ].
        DELETE FROM zpp_bom_from WHERE bomnum = @lt_atch-bomnum.
        MODIFY zpp_bom_htb FROM TABLE @zbp_pp_bom_hre=>gt_hdr.

      ENDIF.
    ENDIF.
**********************************************************************
    IF zbp_pp_bom_hre=>up_attach IS NOT INITIAL.

      MODIFY zpp_bom_from
        FROM TABLE @zbp_pp_bom_hre=>up_attach.
         CLEAR zbp_pp_bom_hre=>up_attach.

    ENDIF.
* **********************************************************************
    IF zbp_pp_bom_hre=>gt_item IS NOT INITIAL.
      MODIFY zpp_bom_itb FROM TABLE @zbp_pp_bom_hre=>gt_item.
    ENDIF.
**********************************************************************
    IF zbp_pp_bom_hre=>gt_item1 IS NOT INITIAL.
      MODIFY zpp_bom_itb1 FROM TABLE @zbp_pp_bom_hre=>gt_item1.
    ENDIF.
**********************************************************************
    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(ls_del).
        DELETE FROM zpp_bom_htb WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_bom_itb WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_bom_itb1 WHERE uuid = @ls_del-Uuid.
      ENDLOOP.
    ENDIF.
*  DELETE FROM zpp_bom_htb WHERE UUID is not INITIAL.
*    DELETE FROM zpp_bom_itb WHERE UUID is not INITIAL.
**********************************************************************
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
