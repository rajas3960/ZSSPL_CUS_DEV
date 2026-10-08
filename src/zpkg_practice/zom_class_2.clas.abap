CLASS zom_class_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACEs if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZOM_CLASS_2 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
 data : ls_ztest_tb type ztest_tb.

        ls_ztest_tb-client = '100'.
        ls_ztest_tb-studentno = '00002'.
        ls_ztest_tb-student_name = 'Ratan Kumar'.
        ls_ztest_tb-class = 'X'.
        ls_ztest_tb-sec = 'B'.
        ls_ztest_tb-gender = 'M'.
        ls_ztest_tb-prt_mobile = '8789394454'.
        ls_ztest_tb-email = 'Ratansharma0110@gmail.com'.
        ls_ztest_tb-address = 'Bihar'.

        Insert into ztest_tb values @ls_ztest_tb.

            IF sy-subrc = 0.
     OUT->WRITE( 'insterted' ).
    ELSE.
      Out->WRITE( 'not Insterted' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
