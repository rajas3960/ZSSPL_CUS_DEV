CLASS ztab_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES:
      if_amdp_marker_hdb,
      if_sadl_exit_calc_element_read.
*      if_sadl_exit.

    METHODS:
      constructor
        IMPORTING
          iv_field_name_bo_key  TYPE string
          iv_field_name_item_id TYPE string.

*   CLASS-METHODS:
*     get_text FOR TABLE FUNCTION ztb_function.
  PROTECTED SECTION.
  PRIVATE SECTION.
  DATA:
      mv_field_name_bo_key  TYPE string,
      mv_field_name_item_id TYPE string,
      mo_text_api           TYPE REF TO zlif_text_api.
ENDCLASS.



CLASS ZTAB_CLASS IMPLEMENTATION.


  METHOD constructor.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~calculate.

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.

  ENDMETHOD.
ENDCLASS.
