CLASS zpp_jc_form DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_JC_FORM IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
      dATA(lv_var) = 1.
    ENDTRY.

    IF NOT line_exists( lt_range[ name = 'JCNUM' ] ).
      "Need select parameter!
      RETURN.
    ENDIF.

    DATA rt_table TYPE TABLE OF ZPP_APPS01_HCE.
    DATA: lv_billing TYPE ZPP_APPS01_HCE-JCNUM.
*    "" ++ 28.07.25 BY SP
    DATA lvgateno TYPE c LENGTH 10 .
    DATA: lv_billno TYPE ZPP_APPS01_HCE-JCNUM.
*    DATA : lv_grnno1 TYPE i_materialdocumentitemtp-materialdocument.

    LOOP AT lt_range[ name = 'JCNUM' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).

      DATA(lv_bill) = <ls_range>-low.
      SELECT SINGLE * FROM zpp_apps01_re
        WHERE Jcnum = @lv_bill
         INTO @DATA(ls).

      INSERT VALUE ZPP_APPS01_HCE(
      material = LS-Material
      machine = ls-machine
      makts = ls-makts
      plant = LS-Plant
      plant_d = LS-Plantdesc
      jcnum = LS-Jcnum
      UUID = LS-Uuid
      batch = LS-Batch
      grnno = LS-grnno
      remark = ls-remark
      length = ls-length
      supplier = ls-supplier
      cdate = ls-cdate
*      createdon = LS-Createdon
      totqty = LS-Totqty
      uom = LS-Uom
      unitwt = LS-Unitwt
      suppliername = ls-suppliername
                 )
                  INTO TABLE rt_table.

      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
