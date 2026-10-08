CLASS zcl_02_emle DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_02_EMLE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  DATA connection TYPE REF TO lcl_connection.
  Data connection2 TYPE REF TO lcl_connection.
  connection = NEW #( ).

  connection = new #(  ).
  connection->carrier_id = 'LH'.
  connection->connection_id = '1234'.
  connection2 = connection.

  ENDMETHOD.
ENDCLASS.
