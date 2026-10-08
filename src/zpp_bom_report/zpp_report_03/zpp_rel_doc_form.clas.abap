CLASS zpp_rel_doc_form DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_REL_DOC_FORM IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
        DATA(lv_error5) = 1.
    ENDTRY.

    IF NOT line_exists( lt_range[ name = 'RELDOCNO' ] ).
      "Need select parameter!
      RETURN.
    ENDIF.

    DATA rt_table TYPE TABLE OF zpp_app03_hce.
    DATA: lv_billing TYPE zpp_app03_hce-reldocno.
*    "" ++ 28.07.25 BY SP
    DATA lvgateno TYPE c LENGTH 10 .
    DATA: lv_billno TYPE zpp_app03_hce-reldocno.
*    DATA : lv_grnno1 TYPE i_materialdocumentitemtp-materialdocument.

    LOOP AT lt_range[ name = 'RELDOCNO' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).

      DATA(lv_bill) = <ls_range>-low.
      SELECT SINGLE * FROM zpp_app03_hre
        WHERE Reldocno = @lv_bill
         INTO @DATA(ls_bom).

      INSERT VALUE zpp_app03_hce(
      uuid = ls_bom-Uuid
      matnr = ls_bom-Matnr
      maktx = ls_bom-Maktx
      project = ls_bom-Project
      reldocno = ls_bom-Reldocno
      reldocs = ls_bom-reldocs
      realeasdt = ls_bom-Realeasdt
      preparedby = ls_bom-Preparedby
      contractor = ls_bom-Contractor
                 )
                 INTO TABLE rt_table.

      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
