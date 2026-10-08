CLASS zpp_bom_print_imp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_BOM_PRINT_IMP IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
      data(lv_error5) = 1.
    ENDTRY.

    IF NOT line_exists( lt_range[ name = 'BOMNUM' ] ).
      "Need select parameter!
      RETURN.
    ENDIF.

    DATA rt_table TYPE TABLE OF zpp_bom_h_ce.
    DATA: lv_billing TYPE zpp_bom_h_ce-bomnum.
*    "" ++ 28.07.25 BY SP
    DATA lvgateno TYPE c LENGTH 10 .
    DATA: lv_billno TYPE zpp_bom_h_ce-bomnum.
*    DATA : lv_grnno1 TYPE i_materialdocumentitemtp-materialdocument.

    LOOP AT lt_range[ name = 'BOMNUM' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).

      DATA(lv_bill) = <ls_range>-low.
      SELECT SINGLE * FROM zpp_bom_hre
        WHERE Bomnumber = @lv_bill
         INTO @DATA(ls_bom).

      INSERT VALUE zpp_bom_h_ce(
      projectno = ls_bom-Projectno
      purchaser = ls_bom-Purchaser
      bomnum = ls_bom-Bomnumber
      projectname = ls_bom-Projectname
      refdocno      = ls_bom-Refdocno
      drawingno     = ls_bom-Drawingno
    bomno        = ls_bom-Bomno
    towertypedesc = ls_bom-towertypedesc
    structuredesc = ls_bom-structuredesc
    bomversion = ls_bom-bomversion
    bomdat       = ls_bom-Bomdate

                 )
                  INTO TABLE rt_table.

      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
