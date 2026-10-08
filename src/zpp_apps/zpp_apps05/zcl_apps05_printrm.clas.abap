CLASS zcl_apps05_printrm DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_APPS05_PRINTRM IMPLEMENTATION.


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

    DATA rt_table TYPE TABLE OF ZPP_APPS05_RM.
    DATA: lv_billing TYPE ZPP_APPS05_RM-vrno.
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.

*    "" ++ 28.07.25 BY SP
    DATA lvgateno TYPE c LENGTH 10 .
    DATA: lv_billno TYPE ZPP_APPS05_RM-vrno.

*    DATA : lv_grnno1 TYPE i_materialdocumentitemtp-materialdocument.

    LOOP AT lt_range[ name = 'VRNO' ]-range ASSIGNING FIELD-SYMBOL(<ls_range>).

      DATA(lv_bill) = <ls_range>-low.
**********************************************************************
      SELECT SINGLE  FROM  zpp_apps05_htb  as _hdr
      left join zpp_apps05_rmitm AS _item on _item~vrno = _hdr~vrno
        left outer join I_ProductDescription as prd on prd~Product = _hdr~sectmat
      left outer join I_ProductDescription as prd2 on prd2~Product = _hdr~project
      left outer join i_plant as plt on plt~Plant = _hdr~werks
      FIELDS
      _hdr~Vrno,
      _hdr~Werks,
      _hdr~Project,
      _hdr~Projectname,
      _hdr~Purno,
      _hdr~Sectmat,
      _hdr~Unitwet,
      prd~ProductDescription as Secmaterial,
      prd2~ProductDescription as Projectnames,
      plt~PlantName,
      _hdr~totwithmk,
      _hdr~plndt,
      _hdr~contrname,
      sum( _item~quanwt ) as quanwt
      WHERE _hdr~vrno = @lv_bill
      GROUP BY
        _hdr~Vrno,
      _hdr~Werks,
      _hdr~Project,
      _hdr~Projectname,
      _hdr~Purno,
      _hdr~Sectmat,
      _hdr~Unitwet,
      prd~ProductDescription,
        plt~PlantName,
        _hdr~totwithmk,
        _hdr~contrname,
        _hdr~plndt,
       prd2~ProductDescription
         INTO  @DATA(ls_jobse).

   select single from  zpp_apps05_htb as hdr
   left join I_BusinessUserBasic as bas on bas~UserID = hdr~createdby

    FIELDS hdr~createdby,hdr~relusr , bas~PersonFullName ,
    hdr~matno where hdr~vrno = @lv_bill into @data(ls_usr).

GET TIME STAMP FIELD data(ts).
    CONVERT TIME STAMP ts TIME ZONE 'INDIA' INTO DATE data(lv_date) TIME data(lv_time).

        INSERT VALUE ZPP_APPS05_RM(
         vrno = ls_jobse-Vrno
         werks = ls_jobse-PlantName
         project = ls_jobse-Project
         projectname = ls_jobse-projectnames
         purno = ls_jobse-Purno
         sectmat = ls_jobse-secmaterial
         unitwet = ls_jobse-Unitwet
         totwithst = ls_jobse-quanwt
         requestdt = ls_jobse-plndt
         currdate = lv_date
         currtime = lv_time
         totwithmk = ls_jobse-totwithmk
         contract = ls_jobse-contrname
         preparedby = ls_usr-PersonFullName
         Approvedby = ls_usr-relusr
         Matno      = ls_usr-matno



                    )
                     INTO TABLE rt_table.



**********************************************************************



      io_response->set_data( rt_table ).
      io_response->set_total_number_of_records( lines( rt_table ) ).
    ENDLOOP.





  ENDMETHOD.
ENDCLASS.
