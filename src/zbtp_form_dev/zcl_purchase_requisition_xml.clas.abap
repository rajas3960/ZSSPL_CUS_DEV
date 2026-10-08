CLASS zcl_purchase_requisition_xml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_purchase_req,
        item_text          TYPE string,
        base_unit          TYPE string,
        requested_quantity TYPE string,
        per_price          TYPE string,
        net_amount         TYPE string,
      END OF ty_purchase_req,
      tt_purchase_req TYPE STANDARD TABLE OF ty_purchase_req WITH DEFAULT KEY.

    CLASS-METHODS:
      generate_xml
        IMPORTING
          it_data         TYPE tt_purchase_req
        RETURNING
          VALUE(rv_xml)   TYPE string.

  PRIVATE SECTION.
    CLASS-METHODS:
      escape_xml_value
        IMPORTING
          iv_value        TYPE string
        RETURNING
          VALUE(rv_value) TYPE string.
ENDCLASS.



CLASS ZCL_PURCHASE_REQUISITION_XML IMPLEMENTATION.


  METHOD escape_xml_value.
    " Simple XML escaping (for basic requirements)
    rv_value = iv_value.

    " Replace special characters
    REPLACE ALL OCCURRENCES OF '&' IN rv_value WITH '&amp;'.
    REPLACE ALL OCCURRENCES OF '<' IN rv_value WITH '&lt;'.
    REPLACE ALL OCCURRENCES OF '>' IN rv_value WITH '&gt;'.
    REPLACE ALL OCCURRENCES OF '"' IN rv_value WITH '&quot;'.
    REPLACE ALL OCCURRENCES OF '''' IN rv_value WITH '&apos;'.
  ENDMETHOD.


  METHOD generate_xml.
      " XML Header
    rv_xml = '<?xml version="1.0" encoding="UTF-8"?>' && cl_abap_char_utilities=>newline.

    " Root element
    rv_xml = rv_xml && '<form1>' && cl_abap_char_utilities=>newline.
    rv_xml = rv_xml && '  <form>' && cl_abap_char_utilities=>newline.

    " Heading section
    rv_xml = rv_xml && '    <headingname>' && cl_abap_char_utilities=>newline.
    rv_xml = rv_xml && '      <Headingname>' &&
            escape_xml_value( 'SHILPASTEEL POWER LIMITED' ) &&
            '</Headingname>' && cl_abap_char_utilities=>newline.
    rv_xml = rv_xml && '      <DateField1>' &&
            sy-datum && 'T' && sy-uzeit &&
            '</DateField1>' && cl_abap_char_utilities=>newline.
    rv_xml = rv_xml && '    </headingname>' && cl_abap_char_utilities=>newline.

    " Empty Details node
    rv_xml = rv_xml && '    <Details/>' && cl_abap_char_utilities=>newline.

    " Purchase requisition items
    LOOP AT it_data INTO DATA(ls_data).
      rv_xml = rv_xml && '    <PurchaseRequestionNode>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '      <ItemText>' && escape_xml_value( ls_data-item_text ) && '</ItemText>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '      <BaseUnit>' && escape_xml_value( ls_data-base_unit ) && '</BaseUnit>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '      <RequestedQuantity>' && escape_xml_value( ls_data-requested_quantity ) && '</RequestedQuantity>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '      <PerPrice>' && escape_xml_value( ls_data-per_price ) && '</PerPrice>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '      <NetAmount>' && escape_xml_value( ls_data-net_amount ) && '</NetAmount>' && cl_abap_char_utilities=>newline.
      rv_xml = rv_xml && '    </PurchaseRequestionNode>' && cl_abap_char_utilities=>newline.
    ENDLOOP.

    " Closing tags
    rv_xml = rv_xml && '  </form>' && cl_abap_char_utilities=>newline.
    rv_xml = rv_xml && '</form1>'.
  ENDMETHOD.
ENDCLASS.
