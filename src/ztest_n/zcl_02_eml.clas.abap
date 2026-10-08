CLASS zcl_02_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_02_EML IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
Data: updt_tabl type table for UPDATE I_MaterialDocumentTP.
      updt_tabl = VALUE #( ( MaterialDocument = '5000000001' MaterialDocumentHeaderText = 'dkkkk' ) ).

      MODIFY ENTITIES OF   I_MaterialDocumentTP
        ENTITY MaterialDocument
        UPDATE fields ( MaterialDocumentHeaderText )
        with updt_tabl.
COMMIT ENTITIES.
  ENDMETHOD.
ENDCLASS.
