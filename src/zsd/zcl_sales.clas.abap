CLASS zcl_sales DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SALES IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
   IF io_request->is_data_requested( ).

      " Get paging information
      DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
      IF lv_top < 0.
        lv_top = 1.
      ENDIF.

      DATA(lv_skip) = io_request->get_paging( )->get_offset( ).
      DATA(lv_max_rows) = COND #( WHEN lv_top = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_top ).
      lv_max_rows = lv_skip + lv_top.

      " Adjust skip for loop indexing
      IF lv_skip > 0.
        lv_skip = lv_skip + 1.
      ENDIF.

      " Get sort elements
      DATA(it_short) = io_request->get_sort_elements( ).
      DATA : lv_orderby TYPE string.
      LOOP AT it_short INTO DATA(wa_short).
        IF wa_short-descending = abap_true.
          lv_orderby = |{ lv_orderby } { wa_short-element_name } DESCENDING |.
        ELSE.
          lv_orderby = |{ lv_orderby } { wa_short-element_name } ASCENDING |.
        ENDIF.
      ENDLOOP.

      IF lv_orderby IS INITIAL.
        lv_orderby = 'billdoc'.
      ENDIF.
       DATA(lv_conditions) = io_request->get_filter( )->get_as_sql_string( ).
      REPLACE 'billdoc' IN lv_conditions WITH 'bdh~BillingDocument'.

      DATA : it_table TYPE TABLE OF zce_sales .
    data :  wa_table TYPE ZCE_SALES.


      SELECT FROM i_billingdocument AS bdh
      INNER JOIN i_billingdocumentitem AS bdi ON bdi~billingdocument = bdh~billingdocument
      fields
       bdh~companycode,
        bdh~salesorganization AS salesorg,
        bdh~distributionchannel AS distchaln,
        bdh~division,
        bdh~billingdocumenttype AS billdoctype,
        bdh~billingdocument AS billdoc,
        bdh~billingdocumentdate AS billdt,
        bdh~payerparty AS payer,
        bdh~soldtoparty AS stp,
        bdi~material AS materialno,
        bdi~billingdocumentitem AS billingino,
        bdi~product,
        bdi~billingquantity AS billingqty,
        bdi~billingquantityunit AS salesunit,
        bdi~plant,
        bdi~storagelocation AS strloct,
        bdi~itemnetweight AS netweight,
        bdi~itemgrossweight AS grossweight,
        bdi~netamount AS netamt,
        bdi~taxamount AS taxamt,
        bdi~transactioncurrency AS currency,
        bdi~pricedetnexchangerate AS exchangerate,
        bdi~referencesddocument AS referencedoc,
        bdi~salesdocument AS salesorder,
        bdh~accountingdocument AS docno,
        bdh~billingdocumentiscancelled AS cancel,
        bdh~cancelledbillingdocument AS billcan,
        bdi~salesdocument
       WHERE (lv_conditions)
      ORDER BY (lv_orderby)
      INTO TABLE @DATA(lt_table).

      SELECT billingdocument ,
       billingdocumentitem ,
       conditiontype,
       conditionamount
       from i_billingdocumentitemprcgelmnt
       FOR ALL ENTRIES IN @lt_table
       where billingdocument = @lt_table-billdoc
       and billingdocumentitem = @lt_table-billingino
       into table @data(it_bdipe).

       select plant,
       consumptiontaxctrlcode
       from I_ProductPlantBasic
       for all ENTRIES IN @lt_table
       where plant = @lt_table-Plant
       into table @data(it_bdp).

       select billingdocument,
              customer as customerno ,
              partnerfunction
              from i_billingdocumentpartner
              for ALL ENTRIES IN @lt_table
              where BillingDocument = @lt_table-billdoc and PartnerFunction = 'RE'
              into table @data(it_bddp).

       select
              salesdocument,
              purchaseorderbycustomer as ponumber
              from I_SalesDocument
              FOR ALL ENTRIES IN @lt_table
              where SalesDocument = @lt_table-SalesDocument
              into table @data(it_sd).

             LOOP AT lt_table ASSIGNING FIELD-SYMBOL(<wa_value>) FROM lv_skip TO lv_max_rows.
                 wa_table-companycode = <wa_value>-companycode.
        wa_table-salesorg = <wa_value>-salesorg.
        wa_table-distchaln = <wa_value>-distchaln.
        wa_table-division = <wa_value>-division.
        wa_table-billdoctype = <wa_value>-billdoctype.
        wa_table-billdoc = <wa_value>-billdoc.
        wa_table-billdt = <wa_value>-billdt.
        wa_table-payer = <wa_value>-payer.
        wa_table-stp = <wa_value>-stp.
        wa_table-materialno = <wa_value>-materialno.
        wa_table-billingino = <wa_value>-billingino.
        wa_table-product = <wa_value>-product.
        wa_table-billingqty = <wa_value>-billingqty.
        wa_table-salesunit = <wa_value>-salesunit.
        wa_table-plant = <wa_value>-plant.
        wa_table-strloct = <wa_value>-strloct.
        wa_table-netamt = <wa_value>-netamt.
        wa_table-grossweight = <wa_value>-grossweight.
        wa_table-netweight = <wa_value>-netweight.
        wa_table-taxamt = <wa_value>-taxamt.
        wa_table-billamt = wa_table-netamt + wa_table-taxamt.
        wa_table-currency = <wa_value>-currency.
        wa_table-exchangerate = <wa_value>-exchangerate.
        wa_table-referencedoc = <wa_value>-referencedoc.
        wa_table-salesorder = <wa_value>-salesorder.
        wa_table-docno = <wa_value>-docno.
        wa_table-cancell = <wa_value>-cancel.
        wa_table-billcan = <wa_value>-billcan.
        read table it_bdipe into data(wa_bdipe) with key billingdocument = <wa_value>-billdoc billingdocumentitem = <wa_value>-billingino.
        if sy-subrc = 0.
        CASE wa_bdipe-conditiontype.
          WHEN 'ZKF0'. " Freight
            wa_table-freight = wa_bdipe-conditionamount.
          WHEN 'ZPR1'.
            wa_table-materialval = wa_bdipe-conditionamount.
          WHEN 'JOIG'.
            wa_table-igstamt = wa_bdipe-conditionamount.
          WHEN 'JOCG'.
            wa_table-cgstamt = wa_bdipe-conditionamount.
          WHEN 'JOSG'.
            wa_table-sgstamt = wa_bdipe-conditionamount.
          WHEN 'JTC1'.
            wa_table-tcs = wa_bdipe-conditionamount.
        ENDCASE.
        endif.

        read table it_bddp into data(wa_bddp) with key billingdocument = <wa_value>-billdoc PartnerFunction = 'RE'.
        IF sy-SUBRC = 0.
        wa_table-customerno = wa_bddp-customerno.
        ENDIF.

        read table it_bdp into data(wa_bdp) with key  plant = <wa_value>-Plant.
        if sy-subrc = 0.
        wa_table-hsncode = wa_bdp-ConsumptionTaxCtrlCode.
        endif.

          read table it_sd into data(wa_sd) with key salesdocument = <wa_value>-SalesDocument.
        if sy-subrc = 0.
        wa_table-Ponumber = wa_sd-ponumber.
        endif.

        append wa_table to it_table.
        clear wa_table.

              endloop.
               IF io_request->is_total_numb_of_rec_requested(  ).
        io_response->set_total_number_of_records( 5000 ).

        io_response->set_data( it_table ).
      ENDIF.
              endif.


  ENDMETHOD.
ENDCLASS.
