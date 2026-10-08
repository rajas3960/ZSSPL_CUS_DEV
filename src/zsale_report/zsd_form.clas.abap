CLASS zsd_form DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSD_FORM IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    DATA(lo_filter) = io_request->get_filter(  ).
    TRY.
        DATA(lt_range) = lo_filter->get_as_ranges(  ).
      CATCH cx_rap_query_filter_no_range.
       data(lver) = 1.
    ENDTRY.
    IF NOT line_exists( lt_range[ name = 'SALESDOCUMENT' ] ).
      "Need select parameter!
      RETURN.

    ENDIF.
    DATA rt_table TYPE TABLE OF zsd_rep_hce.
    DATA: lv_billing TYPE zsd_rep_hce-SalesDocument.
    LOOP AT lt_range[ name = 'SALESDOCUMENT' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).
      DATA(lv_bill) = <ls_range>-low.
      SELECT SINGLE * FROM zsd_rep_rv
    WHERE SalesDocument = @lv_bill
     INTO @DATA(ls_so).
      INSERT VALUE zsd_rep_hce(
        SalesDocument = ls_so-SalesDocument
        SalesDocumentType = ls_so-SalesDocumentType
        SalesDocumentDate = ls_so-SalesDocument
        PurchaseOrderByCustomer = ls_so-PurchaseOrderByCustomer
        CustomerPurchaseOrderDate = ls_so-CustomerPurchaseOrderDate
        SoldtoParty = ls_so-SoldToParty
        CustomerName = ls_so-CustomerName
        Project = ls_so-YY1_PriorityPONos_SDH
        Galva = ls_so-YY1_GalvaCoating_SDH
        BPAddrStreetName = ls_so-BPAddrStreetName
        PostalCode = ls_so-PostalCode
        CityName = ls_so-CityName
        YY1_Gstno_sd_SDH = ls_so-YY1_Gstno_sd_SDH
        YY1_Statename_Sd_SDH = ls_so-YY1_Statename_Sd_SDH
        ShipToCustomer = ls_so-ShipToCustomer
        Customer_Name = ls_so-Customer_Name
        StreetName = ls_so-StreetName
        Postal_Code = ls_so-Postal_Code
        City_Name = ls_so-City_Name
        bstreet1 = ls_so-StreetPrefixName1
        bstreet2 = ls_so-StreetPrefixName2
        sstreet1 = ls_so-street1
        sstreet2 = ls_so-street2
        Creationdate = ls_so-CreationDate
        ) INTO TABLE rt_table.

      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
