CLASS zpp_rel_doc_item DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZPP_REL_DOC_ITEM IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
**********************************************************************
    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
        DATA(lo_error) = 1.
    ENDTRY.
**********************************************************************
    IF NOT line_exists( lt_range[ name = 'UUID' ] ).
      "Need select parameter!
      RETURN.
    ENDIF.
**********************************************************************
    DATA rt_table TYPE TABLE OF zpp_app03_hce.
    DATA rt_item TYPE TABLE OF zpp_app03_ice.
**********************************************************************
    LOOP AT lt_range[ name = 'UUID' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).
      DATA(lv_inuuid) = <ls_range>-low.

      SELECT SINGLE Uuid FROM zpp_app03_hre WITH PRIVILEGED ACCESS
      WHERE Uuid = @lv_inuuid
      INTO @DATA(ls_hrel).

**********************************************************************
      SELECT * FROM zpp_app03_ire2 WITH PRIVILEGED ACCESS
      WHERE Uuid = @ls_hrel
      INTO TABLE @DATA(lt_item).
      IF lt_item IS NOT INITIAL.
        SORT lt_item ASCENDING BY Srno.
        LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<ls_item>).
          IF <ls_item> IS ASSIGNED.
            INSERT VALUE zpp_app03_ice( uuid = ls_hrel
                                      srno = <ls_item>-Srno
                                      proj = <ls_item>-Proj
                                      towertype = <ls_item>-towertype
                                      ttdesc = <ls_item>-Ttdesc
                                      ttsub = <ls_item>-Ttsub
                                      ttsdesc = <ls_item>-Ttsdesc
                                      str = <ls_item>-str
                                      strdesc = <ls_item>-strdesc
                                      mark = <ls_item>-mark
                                      combi = <ls_item>-Combi
                                      bom = <ls_item>-Bom
                                      )
                                      INTO TABLE rt_item.

          ENDIF.
        ENDLOOP.
        io_response->set_data( rt_item ).
        io_response->set_total_number_of_records( lines( rt_item ) ).
      ENDIF.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
