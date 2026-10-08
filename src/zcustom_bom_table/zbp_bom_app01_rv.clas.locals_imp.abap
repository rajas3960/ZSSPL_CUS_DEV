CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS loadexcl FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~loadexcl RESULT result.

    METHODS gtdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gtdata.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD loadexcl.

*      TYPES : BEGIN OF ty_excel,
*               materialnumber          type matnr ,
*               plant                   type werks_d,
*               bomusage                type string,
*               alternativebom          type string,
*               itemid                  type stlkn ,
*               bomitemnumber           type posnr ,
*               itemcategory            type postp ,
*               bomcomponent            type string ,
*               componentquantity       type menge_d ,
*               componentunitofmeasure  type meins ,
*               wtpcinkg                type string,
*               productwidthinmm        type string,
*               totalweightinkg         type string,
*               unitweightinkgm         type string,
*               productlengthinmm       type string,
*
*       END OF ty_excel.
*    TYPES :  zchar18 TYPE c LENGTH 18.
*
*    DATA : lt_excel       TYPE STANDARD TABLE OF ty_excel,
*           lt_itd         TYPE TABLE OF zbom_htb,
*           ls_itd         TYPE  zbom_htb,
*           lo_table_desc  TYPE REF TO cl_abap_tabledescr,
*           lo_struc_descr TYPE REF TO cl_abap_structdescr,
*           lv_index       TYPE sy-index.
****************************************************************
*READ ENTITIES OF zbom_app01_rv IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_attac).
*    DATA(ls_hdr) = lt_attac[ 1 ].
*    DATA(lv_suid) = lt_attac[ 1 ]-Suid.
*    DATA(lv_attach) = lt_attac[ 1 ]-attachment.
*    IF lv_attach IS NOT INITIAL.
*      DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attach )->read_access(  ).
*      DATA(lo_worksheet) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
*      DATA(lo_select_patrn) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->get_pattern(  ).
*      DATA(lo_execute) = lo_worksheet->select( lo_select_patrn )->row_stream(  )->operation->write_to( REF #( lt_excel ) ).
*      lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).
*    ENDIF.
*
*    TRY .
*        lo_table_desc ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel ).
*        lo_struc_descr ?= lo_table_desc->get_table_line_type(  ).
*        DATA(lv_no_of_cols) = lines( lo_struc_descr->components ).
*      CATCH cx_sy_move_cast_error.
*
*   ENDTRY.

  ENDMETHOD.


  METHOD gtdata.

*   DATA : gsdata TYPE zbom_htb.
*    READ ENTITIES OF zbom_app01_rv IN LOCAL MODE ENTITY _hdr
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_result).
*    DATA(ls_result) = lt_result[ 1 ].
*
*    MOVE-CORRESPONDING ls_result TO gsdata.
*    gsdata-status = 'Inactive'.
*
*    APPEND gsdata TO zbp_bom_app01_rv=>gtdata.

*****************************************************************

  ENDMETHOD.

ENDCLASS.

CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS gtdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item~gtdata.

ENDCLASS.

CLASS lhc__item IMPLEMENTATION.

  METHOD gtdata.

*  DATA : gsdata TYPE zbom_itb.
*    READ ENTITIES OF zbom_app01_rv IN LOCAL MODE ENTITY _item
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_result).
*    DATA(ls_result) = lt_result[ 1 ].
*
*    MOVE-CORRESPONDING ls_result TO gsdata.
*
*    APPEND gsdata TO zbp_bom_app01_rv=>gtdata2.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZBOM_APP01_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZBOM_APP01_RV IMPLEMENTATION.

  METHOD save_modified.

*  IF zbp_bom_app01_rv=>gtdata IS NOT INITIAL.
*      MODIFY  zbom_htb FROM TABLE @zbp_bom_app01_rv=>gtdata.
*  ENDIF.

*  IF zbp_bom_app01_rv=>gtdata2 IS NOT INITIAL.
*      MODIFY  zbom_itb FROM TABLE @zbp_bom_app01_rv=>gtdata2.
*  ENDIF.

*  IF delete-_hdr IS NOT INITIAL.
*      LOOP AT delete-_hdr INTO DATA(ls_dele).
*        DELETE FROM  zbom_htb   WHERE suid = @ls_dele-Suid.
*        DELETE FROM zbom_itb WHERE suid = @ls_dele-Suid.
*      ENDLOOP.
*  ENDIF.

*  IF delete-_item IS NOT INITIAL.
*      LOOP AT delete-_item INTO DATA(lsi_dele).
**  DELETE FROM  zmm_app01_tb1   WHERE suid = @ls_dele-Suid.
*        DELETE FROM zbom_itb WHERE suid = @lsi_dele-suid AND suid = @lsi_dele-suid.
*      ENDLOOP.
*    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
