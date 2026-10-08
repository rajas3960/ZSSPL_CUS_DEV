CLASS zcl_apps05_printcarm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APPS05_PRINTCARM IMPLEMENTATION.


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

    IF NOT line_exists( lt_range[ name = 'VRNO' ] ).
      "Need select parameter!
      RETURN.
    ENDIF.

    DATA rt_table TYPE TABLE OF ZPP_APPS05_RMCAV.
    DATA: lv_billing TYPE zpp_apps05_rmcav-vrno.
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.

*    "" ++ 28.07.25 BY SP
    DATA lvgateno TYPE c LENGTH 10 .
    DATA: lv_billno TYPE zpp_apps05_rmcav-vrno.

*    DATA : lv_grnno1 TYPE i_materialdocumentitemtp-materialdocument.

    LOOP AT lt_range[ name = 'VRNO' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).

      DATA(lv_bill) = <ls_range>-low.
**********************************************************************
      SELECT SINGLE FROM  zpp_apps05_htb as _hdr
      left outer join I_ProductDescription as prd on prd~Product = _hdr~sectmat
      left outer join I_ProductDescription as prd2 on prd2~Product = _hdr~project
      left outer join i_plant as plt on plt~Plant = _hdr~werks
      left outer join I_BusinessUserBasic as bas on bas~UserID = _hdr~createdby
      FIELDS
      _hdr~project,
      _hdr~sectmat,
      _hdr~purno,
      _hdr~vrno,
      _hdr~unitwet,
      prd~ProductDescription as Sectionmat,
      prd2~ProductDescription as Projectname,
      plt~PlantName,
      _hdr~werks,
      _hdr~plndt,
      _hdr~contrname,
      bas~PersonFullName,
      _hdr~relusr


      WHERE vrno = @lv_bill

         INTO  @DATA(ls_jobse).

GET TIME STAMP FIELD data(ts).
    CONVERT TIME STAMP ts TIME ZONE 'INDIA' INTO DATE data(lv_date) TIME data(lv_time).

        INSERT VALUE ZPP_APPS05_RMCAV(
         vrno = ls_jobse-Vrno
         werks = ls_jobse-PlantName
         project = ls_jobse-Project && ' - ' && ls_jobse-Projectname
         projectname = ls_jobse-Projectname
         purno = ls_jobse-Purno
         sectmat = ls_jobse-sectionmat
         unitwet = ls_jobse-Unitwet
         plndt = ls_jobse-plndt
         currdate = lv_date
         currtime = lv_time
         contract = ls_jobse-contrname
         Approvedby = ls_jobse-relusr
         Preparedby = ls_jobse-PersonFullName
                    )
                     INTO TABLE rt_table.



**********************************************************************



      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
      endloop.
  ENDMETHOD.
ENDCLASS.
