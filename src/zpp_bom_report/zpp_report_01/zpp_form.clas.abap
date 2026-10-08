CLASS zpp_form DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_FORM IMPLEMENTATION.


METHOD if_rap_query_provider~select.
    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
      data(lv_error6) = 1.
    ENDTRY.
    IF NOT line_exists( lt_range[ name = 'MATERIAL' ] ).
      "Need select parameter!
      RETURN.

    ENDIF.
    DATA rt_table TYPE TABLE OF ZPP_REP_HCE.
    DATA: lv_billing TYPE ZPP_REP_HCE-Material.
    LOOP AT lt_range[ name = 'MATERIAL' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).
      DATA(lv_bill) = <ls_range>-low.
      SELECT SINGLE * FROM ZPP_REPORT_HRV
    WHERE Material = @lv_bill
     INTO @DATA(ls_so).
      INSERT VALUE ZPP_REP_HCE(
       Material = ls_so-Material
       ProductName = ls_so-Desc_name
        ) INTO TABLE rt_table.

      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
