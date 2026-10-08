CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lhc__lcline DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS Gtdata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _lcline~Gtdata1.

    METHODS Gtdata2 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _lcline~Gtdata2.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _lcline RESULT result.
    METHODS valso FOR VALIDATE ON SAVE
      IMPORTING keys FOR _lcline~valso.
*    METHODS validatin FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR _lcline~validatin.

ENDCLASS.

CLASS lhc__lcline IMPLEMENTATION.

  METHOD Gtdata1.
    DATA : lt_crtdata TYPE TABLE OF zsd_app02_itb1,
           ls_crtdata TYPE zsd_app02_itb1.

    READ ENTITIES OF zsd_app02_hrv IN LOCAL MODE
     ENTITY _hdr
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_hdr)
     ENTITY _hdr BY \_litem
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_lcdata).

    DATA(ls_hdr) = lt_hdr[ 1 ].
    DATA(ls_lcdata) = lt_lcdata[ 1 ].

    ls_crtdata-Salesdocument = ls_hdr-SalesDocument.
    SELECT SINGLE MAX( lcline ) FROM zsd_app02_idt1  WHERE salesdocument = @ls_lcdata-Salesdocument INTO @DATA(wa_line).
    IF wa_line IS NOT INITIAL.
      ls_crtdata-Lcline = wa_line + 1.
    ELSE.
      ls_crtdata-Lcline = 1.
    ENDIF.
    ls_crtdata-Lnum = ls_lcdata-Lnum.
    ls_crtdata-lcamount = ls_lcdata-Lcamount.
    ls_crtdata-lcurr = ls_lcdata-Lcurr.
    ls_crtdata-createdby = ls_lcdata-Createdby.
    ls_crtdata-createdon = ls_lcdata-Createdon.
    ls_crtdata-lastchangedbyuser = ls_lcdata-Lastchangedbyuser.
    ls_crtdata-lastchangedatetime = ls_lcdata-Lastchangedatetime.

    APPEND ls_crtdata TO lt_crtdata.

    zbp_sd_app02_hrv=>gt_crtdata = lt_crtdata.

  ENDMETHOD.

  METHOD Gtdata2.
      DATA : lt_uptdata TYPE TABLE OF zsd_app02_itb1,
           ls_uptdata TYPE zsd_app02_itb1.
    READ ENTITIES OF zsd_app02_hrv IN LOCAL MODE
     ENTITY _hdr
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_hdr)
     ENTITY _hdr BY \_litem
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_lcdata).

    DATA(ls_hdr) = lt_hdr[ 1 ].


   zbp_sd_app02_hrv=>gt_uptdata = VALUE #( FOR LS IN lt_lcdata (  CORRESPONDING #( ls )   ) ).
*
*    data(lv_sales) = zbp_sd_app02_hrv=>gt_uptdata[ 1 ]-salesdocument.
*      SELECT * FROM zlc_app02_tb1
*        FOR ALL ENTRIES IN @zbp_sd_app02_hrv=>gt_uptdata
*        WHERE lnum = @zbp_sd_app02_hrv=>gt_uptdata-lnum INTO TABLE @DATA(lt_NEW).
*    SELECT * FROM zsd_app02_itb1
*    WHERE salesdocument = @lv_sales INTO TABLE @DATA(lt_OLD).
*    IF lt_old IS NOT INITIAL.
*      SELECT * FROM zlc_app02_tb1
*       FOR ALL ENTRIES IN @lt_OLD
*       WHERE lnum = @lt_OLD-lnum APPENDING TABLE @lt_new .
*    ENDIF.
*    SORT lt_new BY lnum.
*    DELETE ADJACENT DUPLICATES FROM lt_new COMPARING lnum.
*    IF lt_new IS NOT INITIAL.
*      LOOP AT lt_new ASSIGNING FIELD-SYMBOL(<ls_new>).
*        DATA(ls_old) = VALUE #( lt_old[ lnum = <ls_new>-lnum ] OPTIONAL ). " alternative of read table
*        DATA(ls_lcdata) = VALUE #( zbp_sd_app02_hrv=>gt_uptdata[ lnum = <ls_new>-lnum ] OPTIONAL ).
*        IF ls_old IS INITIAL AND ls_lcdata IS NOT INITIAL.
*          <ls_new>-tlcutilz  +=  ls_lcdata-Lcamount  .
*        ELSEIF ls_old IS NOT INITIAL AND ls_lcdata IS NOT INITIAL.
*          <ls_new>-tlcutilz  = <ls_new>-tlcutilz + ls_lcdata-Lcamount - ls_old-lcamount .
*        ELSEIF ls_old IS NOT INITIAL AND ls_lcdata IS INITIAL.
*          <ls_new>-tlcutilz  -=  ls_old-lcamount .
*        ENDIF.
*        <ls_new>-totbalance = <ls_new>-tlcamt - <ls_new>-tlcutilz.
*
*      ENDLOOP.
*
*    ENDIF.
*   zbp_sd_app02_hrv=>gt_lcdata = lt_new.



  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zsd_app02_hrv IN LOCAL MODE
     ENTITY _hdr
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_hdr)
     ENTITY _hdr BY \_litem
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_lcdata).

  DATA lv_mark TYPE c LENGTH 1.
*    lv_mark = 'X'.
    DATA(ls_hdr) = Lt_hdr[ 1 ].
**********************************************************************
    TRY.
        DATA(lv_user) = cl_abap_context_info=>get_user_business_partner_id(  ).
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        DATA(lv_1) = 1.
    ENDTRY.
**********************************************************************

        IF lv_user = '9980000010' or lv_user = '9980000000' or  lv_user = '9980000013' .
          lv_mark = 'X'.
          else.
          lv_mark = ' '.
        ENDIF.




    result = VALUE #( FOR ls_key IN keys
  ( %tky =  ls_key-%tky
    %delete  = COND #(  WHEN lv_mark IS NOT INITIAL
                                   THEN if_abap_behv=>fc-o-enabled
                                   ELSE if_abap_behv=>fc-o-disabled ) ) ).

  ENDMETHOD.

*  METHOD validatin.
*  READ ENTITIES OF zsd_app02_hrv IN LOCAL MODE
*     ENTITY _hdr
*     ALL FIELDS WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_hdr)
*     ENTITY _hdr BY \_litem
*     ALL FIELDS WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_lcdata).
*     IF lt_lcdata IS NOT INITIAL.
*     LOOP AT lt_lcdata INTO DATA(LS_LCDATA).
*     DATA(LS_HDR) = LT_HDR[ 1 ].
*
*     SELECT SINGLE totbalance FROM zlc_app02_rv WHERE Lnum = @ls_lcdata-Lnum INTO @DATA(LS_TOT).
*     IF SY-subrc = 0.
*     IF ls_lcdata-Lcamount > LS_TOT.
*      APPEND VALUE #( %tky = ls_hdr-%tky
*      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
*      text = |Total bal { ls_hdr-TotalNetAmount } LC amt { LS_TOT }| ) ) TO reported-_hdr.
*     ENDIF.
*     ENDIF.
*     ENDLOOP.
*     ENDIF.
*  ENDMETHOD.

  METHOD valso.
    READ ENTITIES OF zsd_app02_hrv IN LOCAL MODE
     ENTITY _hdr
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_hdr)
     ENTITY _hdr BY \_litem
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_lcdata).

DATA(LS_DATA) = lt_lcdata[ 1 ].

*     loop at lt_lcdata into data(ls_data).
     select single balance , lnum ,TlcAmt  from zlc_app02_vvh where   Lnum =  @ls_data-Lnum into @data(wa) .
     if sy-subrc = 0.
     if ls_data-Lcamount > WA-Balance .

    append value #( %tky = ls_data-%tky  ) to failed-_lcline.
    append value #( %tky = keys[ 1 ]-%tky
    %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
text = |Sales Order Amt: { wa-Balance }, LC Amt: { ls_data-Lcamount }|
    ) ) TO reported-_lcline.
    ENDIF.
     endif.
*     endloop.



  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZSD_APP02_HRV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZSD_APP02_HRV IMPLEMENTATION.

  METHOD save_modified.
*     IF zbp_sd_app02_hrv=>gt_uptdata IS NOT INITIAL.
*     if zbp_sd_app02_hrv=>gt_lcdata is not INITIAL.
*   MODIFY zlc_app02_tb1 FROM TABLE @zbp_sd_app02_hrv=>gt_lcdata  .
*   endif.
*    ENDIF.

    IF create-_lcline IS NOT INITIAL.
      IF zbp_sd_app02_hrv=>gt_crtdata IS NOT INITIAL.
        MODIFY zsd_app02_itb1 FROM TABLE @zbp_sd_app02_hrv=>gt_crtdata.
      ENDIF.
    ENDIF.



    if update-_lcline is not INITIAL.
    if zbp_sd_app02_hrv=>gt_uptdata is not INITIAL.
    modify zsd_app02_itb1 from table @zbp_sd_app02_hrv=>gt_uptdata.
    endif.
    endif.


     IF DELETE-_lcline IS NOT INITIAL.
    LOOP AT delete-_lcline INTO DATA(ls_gipentry).
    DELETE FROM zsd_app02_itb1 WHERE salesdocument = @ls_gipentry-Salesdocument AND lcline = @ls_gipentry-Lcline.
    ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
