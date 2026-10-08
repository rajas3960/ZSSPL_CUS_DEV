CLASS zcl_hide_virt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_HIDE_VIRT IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
**********************************************************************
  DATA lt_original_data1 TYPE STANDARD TABLE OF zpp_apps05_ipv5 WITH DEFAULT KEY.
    lt_original_data1 = CORRESPONDING #( it_original_data ).

data: ls_vr type zpp_apps05_htb-vrcuting.
**********************************************************************
**********************************************************************
 LOOP AT lt_original_data1 ASSIGNING FIELD-SYMBOL(<fs_original_data>).

      IF <fs_original_data>-Uuid IS NOT INITIAL.
**********************************************************************

        SELECT SINGLE
        FROM zpp_apps05_dthb
        FIELDS
        vrcuting
        WHERE uuid = @<fs_original_data>-Uuid
        INTO @ls_vr.
        if sy-subrc = 0.
         IF ls_vr = 'CR'.
         <fs_original_data>-ishide = abap_false.
         ELSE.
          <fs_original_data>-ishide = abap_true.
         ENDIF.

        else.
                SELECT SINGLE
        FROM zpp_apps05_htb
        FIELDS
        vrcuting
        WHERE uuid = @<fs_original_data>-Uuid
        INTO @ls_vr.

       if sy-subrc = 0.
          IF ls_vr = 'CR'.
         <fs_original_data>-ishide = abap_false.
         ELSE.
          <fs_original_data>-ishide = abap_true.
         ENDIF.

       endif.


        endif.


*********************************************************************








        ENDIF.
**********************************************************************
ENDLOOP.
 ct_calculated_data = CORRESPONDING #( lt_original_data1 ).



  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
