CLASS lhc__ITEM DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS gtdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item~gtdata.

ENDCLASS.

CLASS lhc__ITEM IMPLEMENTATION.

  METHOD gtdata.
************************************************************
  DATA : gsdata TYPE zbom_app02_itb2.
    READ ENTITIES OF zbom_app02_rv IN LOCAL MODE ENTITY _item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).
    DATA(ls_result) = lt_result[ 1 ].

    MOVE-CORRESPONDING ls_result TO gsdata.

    APPEND gsdata TO zbp_bom_app02_rv=>gtdata3.

  ENDMETHOD.

ENDCLASS.

CLASS lhc__HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS loadexcl FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~loadexcl RESULT result.

    METHODS gtdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gtdata.

    METHODS create_bom FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~create_bom RESULT result.

ENDCLASS.

CLASS lhc__HDR IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

**********************************************************************
  METHOD loadexcl.

   TYPES : BEGIN OF ty_excel_i,
   materialnumber                        type string,
   plant                                 type string,
   bomusage                              type string,
   alternativebom                        type string,
   validfromdate                         type string,
   itemid                                type string,
   Internalitemidentification            type string,
   bomstatus                             type string,
   changenumber                          type string,
   basequantity                          type string,
   baseunitofmeasureforbom               type string,
   bomdescription                        type string,
   bomitemnumber                         type string,
   itemcategory                          type string,
   bomcomponent                          type string,
   componentquantity                     type string,
   componentunitofmeasure                type string,
   indicatorrelevancytocosting           type c LENGTH 2,
   productionrelevant                    type c LENGTH 1,
   indicatoritemrelevanttosales          type c LENGTH 2,
   itemrelevanttoengineering             type string,
   operationscrap                        type string,
   componentscrapinpercent               type string,
   indicatornetscrap                     type string,
   alternativeitemgroup                  type string,
   alternativeitemrankingorder           type string,
   alternativeitemstrategy               type string,
   alternativeitemusageprobabilit        type string,
   storagelocation                       type string,

   END OF ty_excel_i.
  TYPES :  zchar18 TYPE c LENGTH 18.

   DATA :  lt_excel_i       TYPE STANDARD TABLE OF ty_excel_i,
           lt_itd         TYPE TABLE OF zbom_app02_htb1,
           ls_itd         TYPE  zbom_app02_htb1,
           gs_data3       type zbom_app02_itb2,
           gs_data2       type zbom_app02_ht2,
           lo_table_desc_h  TYPE REF TO cl_abap_tabledescr,
           lo_struc_descr_h TYPE REF TO cl_abap_structdescr,
           lo_table_desc_i  TYPE REF TO cl_abap_tabledescr,
           lo_struc_descr_i TYPE REF TO cl_abap_structdescr,
           lv_index       TYPE sy-index.
   FIELD-SYMBOLS : <lfs_col_header> TYPE any.

   READ ENTITIES OF zbom_app02_rv IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_attac).
    DATA(ls_hdr) = lt_attac[ 1 ].
    DATA(lv_suid) = lt_attac[ 1 ]-suid.
    DATA(lv_attach) = lt_attac[ 1 ]-attachment.
    IF lv_attach IS NOT INITIAL.
      DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lv_attach )->read_access(  ).
      DATA(lo_worksheet_i) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
      DATA(lo_select_patrn_i) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->get_pattern(  ).
      DATA(lo_execute_i) = lo_worksheet_i->select( lo_select_patrn_i )->row_stream(  )->operation->write_to( REF #( lt_excel_i  ) ).
      lo_execute_i->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).

**********************************************************************
******************EXCEL UPLOAD VALIDATION MESSAGE*****************

     IF lt_excel_i IS NOT INITIAL.

     APPEND VALUE #(
      %tky = ls_hdr-%tky
      %msg = new_message_with_text(
             severity = if_abap_behv_message=>severity-success
             text     = |Excel uploaded successfully ({ lines( lt_excel_i ) } records)|
           )
    ) TO reported-_hdr.

     ENDIF.

****************************************************************

      DATA(lo_select_patrn_h) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->get_pattern(  ).
   ENDIF.

    TRY .
        lo_table_desc_i ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel_i ).
        lo_struc_descr_i ?= lo_table_desc_i->get_table_line_type(  ).
        DATA(lv_no_of_cols_i) = lines( lo_struc_descr_i->components ).

      CATCH cx_sy_move_cast_error.

    ENDTRY.

    DELETE lt_excel_i INDEX 1.

    DATA: lv_alpha    TYPE c LENGTH 1,
      lv_numeric  TYPE string,
      lv_mesg TYPE c LENGTH 150,
      lv_count TYPE c LENGTH 3.

    loop at  lt_excel_i into data(ls_i).

    CLEAR gs_data3.

    gs_data3-suid = lv_suid.
    gs_data3-materialnumber                            = ls_i-materialnumber.
    gs_data3-plant                                     = ls_i-plant.

**********************************************************************
    gs_data3-bomusage                                  = ls_i-bomusage.
**********************BOM Usage validation*******************************

        IF gs_data3-alternativebom IS NOT INITIAL.
    IF strlen( gs_data3-bomusage ) <> 2.
      lv_mesg = |({ gs_data3-materialnumber }) Material Bom Usage Should be Single-digit|.
      APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.

      APPEND VALUE #(
        %tky = ls_hdr-%tky
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = lv_mesg )
      ) TO reported-_hdr.
      CONTINUE.
    ENDIF.
  ENDIF.

***************ALTERNATIVE BOM MESSAGE************************************
    gs_data3-alternativebom    = ls_i-alternativebom.
****************************************************************************

    IF gs_data3-alternativebom IS NOT INITIAL.
    IF strlen( gs_data3-alternativebom ) <> 2.
      lv_mesg = |({ gs_data3-materialnumber }) Material Alternative BOM Should be 2-digit|.
      APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.

      APPEND VALUE #(
        %tky = ls_hdr-%tky
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = lv_mesg )
      ) TO reported-_hdr.
      CONTINUE.
    ENDIF.
  ENDIF.

***********************ALTERNATIVE BOM MESSAGE**********************************

    gs_data3-validfromdate                             = ls_i-validfromdate.
    gs_data3-itemid                                    = ls_i-itemid.
    gs_data3-Internalitemidentification                = ls_i-Internalitemidentification.
    gs_data3-bomstatus                                 = ls_i-bomstatus.
    gs_data3-changenumber                              = ls_i-changenumber.
    gs_data3-basequantity                              = ls_i-basequantity.
    gs_data3-baseunitofmeasureforbom                   = ls_i-baseunitofmeasureforbom.
    gs_data3-bomdescription                            = ls_i-bomdescription.
    gs_data3-bomitemnumber                             = ls_i-bomitemnumber.
    gs_data3-itemcategory                              = ls_i-itemcategory.
    gs_data3-bomcomponent                              = ls_i-bomcomponent.
    gs_data3-componentquantity                         = ls_i-componentquantity.
    gs_data3-componentunitofmeasure                    = ls_i-componentunitofmeasure.
    gs_data3-indicatorrelevancytocosting               = ls_i-indicatorrelevancytocosting.
    gs_data3-productionrelevant                        = ls_i-productionrelevant.
    gs_data3-indicatoritemrelevanttosales              = ls_i-indicatoritemrelevanttosales.
    gs_data3-itemrelevanttoengineering                 = ls_i-itemrelevanttoengineering.
    gs_data3-operationscrap                            = ls_i-operationscrap.
    gs_data3-componentscrapinpercent                   = ls_i-componentscrapinpercent.
    gs_data3-indicatornetscrap                         = ls_i-indicatornetscrap.
    gs_data3-alternativeitemgroup                      = ls_i-alternativeitemgroup.
    gs_data3-alternativeitemrankingorder               = ls_i-alternativeitemrankingorder.
    gs_data3-alternativeitemstrategy                   = ls_i-alternativeitemstrategy.
    gs_data3-alternativeitemusageprobabilit            = ls_i-alternativeitemusageprobabilit.
    gs_data3-storagelocation                           = ls_i-storagelocation.

  IF gs_data3-bomcomponent IS INITIAL.
  CONTINUE.
  ENDIF.

**********************************************************************
********** MATERIAL NUMBER VALIDATION MESSAGE

SELECT SINGLE Material ,Plant,BillOfMaterialVariantUsage,BillOfMaterialVariant
  FROM I_BillOfMaterialTP_2
     WHERE Material                     = @gs_data3-materialnumber
     AND Plant                          = @gs_data3-plant
     AND BillOfMaterialVariantUsage     = @gs_data3-bomusage
     AND BillOfMaterialVariant          = @gs_data3-alternativebom

  INTO @DATA(lv_matnr).

  IF sy-subrc = 0.
    lv_mesg = |({ gs_data3-materialnumber }) Material BOM already exist|.
    APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.
    APPEND VALUE #(
      %tky = ls_hdr-%tky
      %msg = new_message_with_text(
               severity = if_abap_behv_message=>severity-error
               text     = lv_mesg )
    ) TO reported-_hdr.
    CONTINUE.
  ENDIF.

**********************************************************************
 APPEND gs_data3  TO zbp_bom_app02_rv=>gtdata3.

ENDLOOP.

    MOVE-CORRESPONDING ls_hdr TO ls_itd.
    ls_itd-status = 'Active'.
    APPEND ls_itd TO lt_itd.
    zbp_bom_app02_rv=>gtdata = lt_itd.


    result = VALUE #( FOR ls_ord IN lt_attac
                   ( %tky = ls_ord-%tky
                   %param = ls_ord ) ).

  ENDMETHOD.

  METHOD gtdata.

  DATA : gsdata TYPE zbom_app02_htb1.
    READ ENTITIES OF zbom_app02_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).


    DATA(ls_result) = lt_result[ 1 ].

    MOVE-CORRESPONDING ls_result TO gsdata.
    gsdata-status = 'Inactive'.

    APPEND gsdata TO zbp_bom_app02_rv=>gtdata.

  ENDMETHOD.

**********************************************************************

  METHOD create_bom.

 DATA lt_items TYPE TABLE OF zbom_app02_itb2.

 READ ENTITIES OF zbom_app02_rv IN LOCAL MODE
 ENTITY _hdr
 ALL FIELDS WITH CORRESPONDING #( keys )
 RESULT DATA(LT_HDR).

  READ ENTITIES OF zbom_app02_rv IN LOCAL MODE
    ENTITY _hdr
      BY \_item
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_item_result).

loop at lt_item_result into data(ls_item) GROUP BY ( materialnumber = ls_item-materialNumber ) into data(ls_gtp).
ls_item = VALUE #( lt_item_result[ materialNumber = ls_gtp-materialnumber ] OPTIONAL ).
DATA(LV) = + 1 .
  MODIFY ENTITIES OF I_BillOfMaterialTP_2 PRIVILEGED
        ENTITY BillOfMaterial
          CREATE
            SET FIELDS WITH VALUE
              #( (
               %cid =  'CID0' && LV
                   Material   = ls_item-materialNumber
                   BillOFMaterialVariant = ls_item-alternativebom
                   BillOfMaterialVariantUsage = ls_item-bomusage
                   Plant = ls_item-plant
                   BillOfMaterialCategory = 'M'
                   HeaderValidityStartDate = ls_item-validfromdate

               ) )

            MAPPED DATA(ls_mapped)
            FAILED DATA(ls_failed)
            REPORTED DATA(ls_reported).

DATA(LV_BOM) = ls_mapped-billofmaterial.


LOOP AT GROUP ls_gtp INTO DATA(LW_GRP).

 MODIFY ENTITIES OF I_BillOfMaterialTP_2 PRIVILEGED
        ENTITY billofmaterial
          CREATE BY \_billofmaterialitem
          AUTO FILL CID
            SET FIELDS WITH VALUE
              #( (

                    Billofmaterial            =   LV_BOM[ 1 ]-BillOfMaterial
                    BillOfMaterialCategory    = 'M'
                    BillOfMaterialVariant     = ls_item-alternativebom
*                   BillOfMaterialVersion     = ''
*                   EngineeringChangeDocument = ''
                    Material                  = ls_item-materialNumber
                    Plant                     = ls_item-plant

                  %target = VALUE #(

                     (
                      ValidityStartDate          = lw_grp-validfromdate
                      billofmaterialitemcategory = lw_grp-itemcategory
                      billofmaterialitemquantity = lw_grp-componentquantity
                      billofmaterialitemunit     = lw_grp-uom
                      billofmaterialcomponent    = lw_grp-bomcomponent
                      BOMItemIsSalesRelevant     = lw_grp-indicatoritemrelevanttosales
                      BOMItemIsCostingRelevant   = lw_grp-indicatorrelevancytocosting
                      ProdOrderIssueLocation     = lw_grp-storageLocation
                      IsProductionRelevant = COND #(
                      WHEN lw_grp-productionrelevant = 'X'
                               THEN abap_true
                               ELSE abap_false
                                  )
                      )

                    )

               ) )

            MAPPED DATA(ls_mapped1)
            FAILED DATA(ls_failed1)
            REPORTED DATA(ls_reported1).

ENDLOOP.

ENDLOOP.


RESULT = VALUE #(   FOR ls_ord IN lt_hdr
                   ( %tky = ls_ord-%tky
                   %param = ls_ord ) ).
  ENDMETHOD.

**********************************************************************

ENDCLASS.

CLASS lsc_ZBOM_APP02_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZBOM_APP02_RV IMPLEMENTATION.

  METHOD save_modified.
      IF zbp_bom_app02_rv=>gtdata IS NOT INITIAL.
      MODIFY  zbom_app02_htb1 FROM TABLE @zbp_bom_app02_rv=>gtdata.
    ENDIF.

     IF zbp_bom_app02_rv=>gtdata3 IS NOT INITIAL.
      MODIFY  zbom_app02_itb2 FROM TABLE @zbp_bom_app02_rv=>gtdata3.
    ENDIF.

    IF delete-_hdr IS NOT INITIAL.
    LOOP AT delete-_hdr INTO DATA(ls_dele).
        DELETE FROM  zbom_app02_htb1   WHERE suid = @ls_dele-suid.
        DELETE FROM zbom_app02_itb2 WHERE suid = @ls_dele-suid.
      ENDLOOP.
    ENDIF.

    IF delete-_item IS NOT INITIAL.
      LOOP AT delete-_item INTO DATA(lsi_dele).
        DELETE FROM zbom_app02_itb2 WHERE suid = @lsi_dele-suid AND materialnumber = @lsi_dele-materialNumber.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
