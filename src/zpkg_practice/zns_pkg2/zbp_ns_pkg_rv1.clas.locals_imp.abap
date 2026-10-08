CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.
    METHODS ondata FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~ondata.

    METHODS ondata2 FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~ondata2.
    METHODS loadexl FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~loadexl RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD ondata.
  READ ENTITIES OF zns_pkg_rv1  IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT data(Lt_header).
  data(ls_header) = lt_header[ 1 ].

  MODIFY ENTITIES OF zns_pkg_rv1  IN LOCAL MODE
  ENTITY _hdr UPDATE
 FIELDS ( Decs )
 WITH VALUE
  #( ( %tky = ls_header-%tky
       %data-Decs = 'File Not Selected'
       %control-Decs = if_abap_behv=>mk-on  ) )
       MAPPED Data(lt_mapped)
       FAILED data(lt_failed)
       REPORTED data(lt_reported).

  ENDMETHOD.

  METHOD ondata2.
    READ ENTITIES OF zns_pkg_rv1  IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT data(Lt_header).
  data(ls_header) = lt_header[ 1 ].

  data : gt_hdr type table of zns_pkg_tb1,
         gs_hdr type zns_pkg_tb1.

  MOVE-CORRESPONDING ls_header to gs_hdr.
 if gs_hdr-attachment  is not INITIAL.
  gs_hdr-status = 'C'.
  gs_hdr-decs = 'File Selected'.
  else .
  gs_hdr-status = 'X'.
  gs_hdr-decs = 'File Not Selected'.
  endif.

  APPEND gs_hdr to gt_hdr.
  zbp_ns_pkg_rv1=>gt_crtdat = gt_hdr.






  ENDMETHOD.

  METHOD loadexl.

  data : lt_excel type STANDARD TABLE OF zbp_ns_pkg_rv1=>gt_gx_ls,
         LT_ITD TYPE TABLE OF zns_pkg_tb2,
         LS_ITD TYPE  zns_pkg_tb2,
         lo_table_desc type ref to cl_abap_tabledescr,
         lo_struc_descr type ref to cl_abap_structdescr,
         lv_index type sy-index.

         FIELD-SYMBOLS : <lfs_col_header> type ANY.

  READ ENTITIES OF zns_pkg_rv1 IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) result data(lt_attac).
  data(lv_attach) = lt_attac[ 1 ]-Attachment.
  if lv_attach is not INITIAL.
  data(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attach )->read_access(  ).
  data(lo_worksheet) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
  data(lo_select_patrn) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->get_pattern(  ).
  data(lo_execute) = lo_worksheet->select( lo_select_patrn )->row_stream(  )->operation->write_to( REF #( lt_excel ) ).
  lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).
  endif.

  TRY .
  lo_table_desc ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel ).
  lo_struc_descr ?= lo_table_desc->get_table_line_type(  ).
  data(lv_no_of_cols) = lines( lo_struc_descr->components ).
  CATCH cx_sy_move_cast_error.

  ENDTRY.

  data(ls_excel) = VALUE #( lt_excel[ 1 ] optional ).

  if ls_excel is not INITIAL.
  do lv_no_of_cols Times.
  ASSIGN COMPONENT lv_index of STRUCTURE ls_excel to <lfs_col_header>.
  check <lfs_col_header> is ASSIGNED .
*  DATA(LV_VALUE) = to_upper( <lfs_col_header> ).
  DATA(LV_HAS_ERROR) = abap_false.
  case lv_index.
  when 1.
  lv_has_error = COND #( when <lfs_col_header> <> 'CLIENT' then abap_true else lv_has_error ).
    when 2.
  lv_has_error = COND #( when <lfs_col_header> <> 'UUID' then abap_true else lv_has_error ).
    when 3.
  lv_has_error = COND #( when <lfs_col_header> <> 'ITEM' then abap_true else lv_has_error ).
    when 4.
  lv_has_error = COND #( when <lfs_col_header> <> 'SONUM' then abap_true else lv_has_error ).
    when 5.
  lv_has_error = COND #( when <lfs_col_header> <> 'PLANT' then abap_true else lv_has_error ).
    when 6.
  lv_has_error = COND #( when <lfs_col_header> <> 'SOLD' then abap_true else lv_has_error ).
    when 7.
  lv_has_error = COND #( when <lfs_col_header> <> 'PHONENO' then abap_true else lv_has_error ).
  when 8.
  lv_has_error = COND #( when <lfs_col_header> <> 'EMAIL' then abap_true else lv_has_error ).
  when 9.
  lv_has_error = abap_true.
  endcase.
  if lv_has_error = abap_true.
  APPEND VALUE #( %tky = lt_attac[ 1 ]-%tky ) to failed-_hdr.
  append value #( %tky = lt_attac[ 1 ]-%tky
  %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
  text = 'Wrong file Format' )
  ) TO reported-_hdr.
  UNASSIGN <lfs_col_header>.
  EXIT.
  endif.
  UNASSIGN <lfs_col_header>.

  ENDDO.
  endif.
  CHECK lv_has_error = abap_false.

  DELETE lt_excel INDEX 1.
  delete lt_excel where sonumber is INITIAL.


*  zbp_ns_pkg_rv1=>gt_crtidat = lt_excel.
LOOP AT lt_excel INTO DATA(LS_ExCL).

MOVE-CORRESPONDING ls_excl  TO LS_ITD.
LS_ITD-uuid = lt_attac[ 1 ]-Uuid.
APPEND  ls_itd TO lt_itd.
ENDLOOP.
  zbp_ns_pkg_rv1=>gt_crtidat = lt_itd.

  READ ENTITIES OF zns_pkg_rv1 IN LOCAL MODE ENTITY _hdr
  ALL FIELDS WITH CORRESPONDING #( keys )
  RESULT DATA(LT_HDR).
*  ENTITY _hdr BY \_item
*  ALL FIELDS WITH CORRESPONDING #( keys )
*  RESULT DATA(LT_ITM).

      result = VALUE #( FOR ls_ord IN LT_HDR
                    ( %tky = ls_ord-%tky
                    %param = ls_ord ) ).
*result = VALUE #( FOR ls_ors IN lt_itm
*                    ( %tky = ls_ors-%tky
*                    %param = ls_oRS ) ).
DATA: c_sender type cl_bcs_mail_message=>ty_address value 'noreply@shilpatl.com',
      c_receiver1 type cl_bcs_mail_message=>ty_address value 'omkarmistry0@gmail.com',
      c_receiver2 type cl_bcs_mail_message=>ty_address value 'fworkout592@gmail.com'.


try.

DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).

    lo_mail->set_sender( c_sender ).

    lo_mail->add_recipient( iv_address = c_receiver1
                            iv_copy    = cl_bcs_mail_message=>to ).
    lo_mail->add_recipient( iv_address = c_receiver2
                            iv_copy    = cl_bcs_mail_message=>cc ).

    lo_mail->set_subject( 'Test from ABAP Cloud' ).

    DATA(ld_content) = `<h2>Hello World</h2><p>This is my HTML Mail from <strong>ABAP Cloud</strong>.</p>`.
    lo_mail->set_main( cl_bcs_mail_textpart=>create_instance( iv_content      = ld_content
                                                              iv_content_type = 'text/html' ) ).

    lo_mail->send( IMPORTING et_status      = DATA(lt_status)
                             ev_mail_status = DATA(ld_mail_status) ).
    catch cx_bcs_mail into data(lx_mail).

ENDTRY.

*    io_out->write( lt_status ).
*    io_out->write( |Mail status: { ld_mail_status }| ).


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZNS_PKG_RV1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZNS_PKG_RV1 IMPLEMENTATION.

  METHOD save_modified.
  IF zbp_ns_pkg_rv1=>gt_crtdat is not INITIAL.
  MODIFY zns_pkg_tb1 from table @zbp_ns_pkg_rv1=>gt_crtdat.

  endif.
*    if zbp_ns_pkg_rv1=>gt_crtdat[ 1 ]-attachment is not INITIAL.
  if zbp_ns_pkg_rv1=>gt_crtidat is not INITIAL.
  MODIFY zns_pkg_tb2 from TABLE @zbp_ns_pkg_rv1=>gt_crtidat.

  endif.
*  endif.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
