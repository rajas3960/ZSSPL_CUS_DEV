CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS fill_hdata FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~fill_hdata.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD fill_hdata.
**********************************************************************
    DATA: lt_hdrdata TYPE TABLE OF zlc_app02_tb1,
          ls_hdrdata TYPE zlc_app02_tb1.
**********************************************************************

    READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    ls_hdrdata-applicant = ls_hdr-Applicant.
    ls_hdrdata-bankbranch = ls_hdr-BankBranch.
    ls_hdrdata-banknam = ls_hdr-Banknam.
    ls_hdrdata-lccurr = 'INR'.
    ls_hdrdata-ldd = ls_hdr-Ldd.
    ls_hdrdata-lnum = ls_hdr-Lnum.
    ls_hdrdata-stp = ls_hdr-Stp.
    ls_hdrdata-stpname = ls_hdr-StpName.
    ls_hdrdata-project = ls_hdr-Project.
    ls_hdrdata-valfrm = ls_hdr-Valfrm.
    ls_hdrdata-stpname = ls_hdr-StpName.
    ls_hdrdata-totalqty = ls_hdr-Totalqty.
    ls_hdrdata-unit = ls_hdr-Unit.
    ls_hdrdata-incoterm = ls_hdr-Incoterm.
    ls_hdrdata-popi = ls_hdr-Popi.
    ls_hdrdata-remark = ls_hdr-Remark.
    ls_hdrdata-beneficiary = ls_hdr-Beneficiary.
    ls_hdrdata-createdby = ls_hdr-Createdby.
    ls_hdrdata-createdon = ls_hdr-Createdon.

*    TRY.
*        ls_hdrdata-createdby = cl_abap_context_info=>get_user_description(  ).
*      CATCH cx_ro INTO cx.
*        DATA(ls) = 1.
*    ENDTRY.


    APPEND ls_hdrdata TO lt_hdrdata.
    zbp_lc_app02_rv=>gt_hdrdata = lt_hdrdata.

  ENDMETHOD.

  METHOD get_instance_features.
      READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(it_status).
***********************************************************************
data(ls_status) = it_status[ 1 ]-Lnum.
select single sum( Lcamount ) as lcamt,lnum from zsd_app02_irv WHERE  Lnum =  @ls_status  GROUP BY Lnum into @data(lc_amt).
*if lc_amt is NOT INITIAL.
    result = VALUE #( FOR ls_data IN It_status
          ( %tky =  ls_data-%tky
            %features-%assoc-_Lineboi = COND #( WHEN lc_amt IS NOT INITIAL

                                                THEN if_abap_behv=>fc-o-enabled

                                                ELSE if_abap_behv=>fc-o-disabled
               )

              ) ).
*endif.
**********************
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Line DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS fill_ldata FOR DETERMINE ON SAVE
      IMPORTING keys FOR Line~fill_ldata.
    METHODS updt_ldata FOR DETERMINE ON SAVE
      IMPORTING keys FOR Line~updt_ldata.

ENDCLASS.

CLASS lhc_Lineboi DEFINITION INHERITING FROM cl_abap_behavior_handler.
PRIVATE SECTION.

METHODS fill_ldata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Lineboi~fill_ldata1.
METHODS boeamt FOR DETERMINE ON MODIFY
  IMPORTING keys FOR _Lineboi~boeamt.
METHODS V1_boeamt FOR VALIDATE ON SAVE
  IMPORTING keys FOR _Lineboi~V1_boeamt.
METHODS get_instance_features FOR INSTANCE FEATURES
  IMPORTING keys REQUEST requested_features FOR _Lineboi RESULT result.
METHODS gt_updt FOR DETERMINE ON SAVE
  IMPORTING keys FOR _Lineboi~gt_updt.

ENDCLASS.
class lhc_Lineboi IMPLEMENTATION.

 METHOD fill_ldata1.
**********************************************************************
  DATA: lt_linedata TYPE TABLE OF zlc_app02_tb3,
          ls_linedata TYPE zlc_app02_tb3,
          lt_hdrupd   TYPE TABLE OF zlc_app02_tb1,
          ls_hdrupd   TYPE zlc_app02_tb1.
**********************************************************************

 READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr)
    ENTITY Header BY \_Lineboi
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_line).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    DATA(ls_line) = lt_line[ 1 ].
**********************************************************************

    SELECT SINGLE lnum, MAX( lcline ) AS lcline FROM zlc_app02_tb3
    WHERE lnum = @ls_hdr-Lnum
    GROUP BY lnum
    INTO @DATA(ls_tab).
    IF ls_tab IS INITIAL.
      ls_linedata-lcline = 1.
    ELSE.
      ls_linedata-lcline = ls_tab-lcline + 1.
    ENDIF.
**********************************************************************
    ls_linedata-lnum = ls_hdr-Lnum.
    ls_linedata-boeamt = ls_line-Boeamt.
    ls_linedata-instdebt = ls_line-Instdebt.
    ls_linedata-fright = ls_line-Fright.
    ls_linedata-tboeamt = ls_linedata-boeamt + ls_linedata-fright + ls_linedata-instdebt.
    ls_linedata-boeqty = ls_line-Boeqty.
    ls_linedata-unit  =  ls_line-Unit.
    ls_linedata-boecurr = ls_line-Boecurr.
    ls_linedata-boedt = ls_line-Boedt.
    ls_linedata-boeno = ls_line-Boeno.
    ls_linedata-dudt = ls_line-Dudt.
    ls_linedata-createdby = ls_line-Createdby.
    ls_linedata-createdon = ls_line-Createdon.

**********************************************************************
MOVE-CORRESPONDING ls_hdr TO ls_hdrupd.
IF ls_linedata-Tboeamt IS NOT INITIAL.
ls_hdrupd-aclcamt += ls_linedata-tboeamt.
ls_hdrupd-totboeamt += ls_linedata-tboeamt.
ls_hdrupd-planlcamt = ls_hdrupd-tlcamt - ls_hdrupd-aclcamt.
*ls_hdrupd-totbalance = ls_hdrupd-totboeamt - ls_hdrupd-tlcutilz.

"aclcamt is
ENDIF.
**********************************************************************
append ls_linedata to lt_linedata.
zbp_lc_app02_rv=>gt_line2data = lt_linedata.
append ls_hdrupd to lt_hdrupd.
zbp_lc_app02_rv=>gt_hdrupd =  lt_hdrupd.



 ENDMETHOD.
  METHOD boeamt.
   READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr)
    ENTITY Header BY \_Lineboi
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_line).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    DATA(ls_line) = lt_line[ 1 ].



  ENDMETHOD.

  METHOD V1_boeamt.
**********************************************************************
     READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr)
    ENTITY Header BY \_Lineboi
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_line).
            data : lv_totv type p DECIMALS 2.

    DATA(ls_hdr) = lt_hdr[ 1 ].
*    DATA(ls_line) = lt_line[ 1 ].
    loop at lt_line INTO DATA(LS_LINE) .
    LS_LINE-Tboeamt = LS_LINE-Boeamt + LS_LINE-Fright + LS_LINE-Instdebt.
    lv_totv += LS_LINE-Tboeamt.

    endloop.

     if lv_totv > ls_hdr-TlcAmt.
    append value #( %tky = LS_LINE-%tky  ) to failed-_Lineboi.
    append value #( %tky = keys[ 1 ]-%tky
    %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
text = |Total LC Amt: { ls_hdr-TlcAmt }, BOE Exceeded: { lv_totv }|
    ) ) TO reported-_Lineboi.
    endif.
**********************************************************************

  ENDMETHOD.

  METHOD get_instance_features.
***********************************************************************
    READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY _Lineboi
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(it_status).
***********************************************************************
data(ls_status) = it_status[ 1 ]-Lnum.
select single sum( Lcamount ) as lcamt,lnum from zsd_app02_irv WHERE  Lnum =  @ls_status  GROUP BY Lnum into @data(lc_amt).
if lc_amt is NOT INITIAL.
    result = VALUE #( FOR ls_data IN It_status
          ( %tky =  ls_data-%tky
            %features-%update = COND #( WHEN lc_amt IS NOT INITIAL

                                                THEN if_abap_behv=>fc-o-enabled

                                                ELSE if_abap_behv=>fc-o-disabled
               )

              ) ).
endif.
**********************

  ENDMETHOD.

  METHOD gt_updt.
  DATA : gs_item type  zlc_app02_tb3.
      READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr)
    ENTITY Header BY \_Lineboi
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_line).

 data(ls_item) = lt_line[ 1 ].

 select single * from zlc_app02_tb3 WHERE lnum = @ls_item-Lnum and lcline = @ls_item-Lcline into @data(ls_item2).

 MOVE-CORRESPONDING ls_item2 to gs_item.
 gs_item-dudt  = ls_item-Dudt.

 APPEND gs_item to zbp_lc_app02_rv=>gt_line2data.






  ENDMETHOD.

ENDCLASS.

CLASS lhc_Line IMPLEMENTATION.

  METHOD fill_ldata.
**********************************************************************
    DATA: lt_linedata TYPE TABLE OF zlc_app02_tb2,
          LT_LINE2 TYPE TABLE OF zlc_app02_tb2,
          ls_linedata TYPE zlc_app02_tb2,
          lt_hdrupd   TYPE TABLE OF zlc_app02_tb1,
          ls_hdrupd   TYPE zlc_app02_tb1.
**********************************************************************

    READ ENTITIES OF zlc_app02_rv IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_hdr)
    ENTITY Header BY \_Line
    ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT FINAL(lt_line).
    DATA(ls_hdr) = lt_hdr[ 1 ].
    DATA(ls_line) = lt_line[ 1 ].

**********************************************************************

    SELECT SINGLE lnum, MAX( lcline ) AS lcline FROM zlc_app02_tb2
    WHERE lnum = @ls_hdr-Lnum
    GROUP BY lnum
    INTO @DATA(ls_tab).
    IF ls_tab IS INITIAL.
      ls_linedata-lcline = 1.
    ELSE.
      ls_linedata-lcline = ls_tab-lcline + 1.
    ENDIF.
    ls_linedata-lnum = ls_hdr-Lnum.
    ls_linedata-accbstus = ls_line-Accbstus.
    ls_linedata-boeamt = ls_line-Boeamt.
    ls_linedata-instdebt = ls_line-Instdebt.
    ls_linedata-fright = ls_line-Fright.
    ls_linedata-tboeamt = ls_linedata-boeamt + ls_linedata-fright + ls_linedata-instdebt.
    ls_linedata-boeqty = ls_line-Boeqty.
    ls_linedata-unit  =  ls_line-Unit.
    ls_linedata-boecurr = ls_line-Boecurr.
    ls_linedata-boedt = ls_line-Boedt.
    ls_linedata-boeno = ls_line-Boeno.
    ls_linedata-dudt = ls_line-Dudt.
    ls_linedata-lcamt = ls_line-LcAmt.
    ls_linedata-lccurr = 'INR'.
    ls_linedata-noofdays = ls_line-Noofdays.
    ls_linedata-remark = ls_line-Remark.
    ls_linedata-valfrm = cl_abap_context_info=>get_system_date(  ).
    ls_linedata-valto = ls_line-Valto.
    ls_linedata-createdby = ls_line-Createdby.
    ls_linedata-createdon = ls_line-Createdon.
    ls_linedata-inst = ls_line-Inst.
**********************************************************************
*  IF ls_line-LcAmt IS NOT INITIAL.
*    SELECT SINGLE lnum, MAX( amtno ) AS lcline FROM zlc_app02_tb2
*    WHERE lnum = @ls_hdr-Lnum and lcamt is not INITIAL
*    GROUP BY lnum
*    INTO @DATA(ls_tab1).
*    IF ls_tab1 is not INITIAL and sy-subrc = 0.
*    ls_linedata-amtno = ls_tab1-lcline + 1.
*    else .
*    ls_linedata-amtno = 1.
*    endif.
*    ls_linedata-amtdt = 'LCAMD' && ls_linedata-amtno.
*
*    ENDIF.
**********************************************************************
IF ls_line-Torlce IS NOT INITIAL AND ls_line-LcAmt IS NOT INITIAL.
  ls_linedata-torlce = ls_line-Torlce.
  ls_linedata-tlcamt = ls_line-lcamt + ( ls_line-lcamt * ls_line-torlce / 100 ).
ELSEIF ls_line-LcAmt IS NOT INITIAL AND ls_line-Torlce IS INITIAL.
ls_linedata-tlcamt = ls_line-LcAmt.
ENDIF.
**********************************************************************





    APPEND ls_linedata TO lt_linedata.

* CLEAR ls_hdrupd.
MOVE-CORRESPONDING ls_hdr TO ls_hdrupd.
 IF ls_hdrupd-valto < ls_line-valto.
    ls_hdrupd-valto = ls_line-valto.
  ENDIF.
   ls_hdrupd-tlcamt += ls_linedata-tlcamt.
   ls_hdrupd-planlcamt = ls_hdrupd-tlcamt - ls_hdrupd-aclcamt.  "

" Step 1: Filter entries where Torlce is not initial
lt_line2 = VALUE #(
  FOR ls IN lt_line
  WHERE ( torlce IS NOT INITIAL )
  ( CORRESPONDING #( ls ) )
).

" Step 2: Sort by lcnumber and lcline in descending order (latest first)
SORT lt_line2 BY lnum DESCENDING createdon DESCENDING.

" Step 3: Read the first entry (latest)
IF lt_line2 IS NOT INITIAL.
  DATA(ls_line2) = lt_line2[ 1 ].

  " Step 4: Assign torlce value
  IF ls_line2-torlce IS NOT INITIAL.
    ls_hdrupd-torlce = ls_line2-torlce.
  ELSE.
    ls_hdrupd-torlce = 0.
  ENDIF.
ELSE.
  ls_hdrupd-torlce = 0.
ENDIF.



   APPEND ls_hdrupd TO lt_hdrupd.
zbp_lc_app02_rv=>gt_hdrupd = lt_hdrupd.


    zbp_lc_app02_rv=>gt_lindata = lt_linedata.
  ENDMETHOD.

  METHOD updt_ldata.


  ENDMETHOD.

ENDCLASS.



CLASS lsc_ZLC_APP02_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZLC_APP02_RV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
    IF create-header IS NOT INITIAL.
      IF zbp_lc_app02_rv=>gt_hdrdata IS NOT INITIAL.
        MODIFY zlc_app02_tb1 FROM TABLE @zbp_lc_app02_rv=>gt_hdrdata.
      ENDIF.
    ENDIF.
**********************************************************************
    IF create-line IS NOT INITIAL.
      IF zbp_lc_app02_rv=>gt_lindata IS NOT INITIAL.
        MODIFY zlc_app02_tb2 FROM TABLE @zbp_lc_app02_rv=>gt_lindata.
      ENDIF.
    ENDIF.

         IF zbp_lc_app02_rv=>gt_hdrupd IS NOT INITIAL.
        MODIFY zlc_app02_tb1 FROM TABLE @zbp_lc_app02_rv=>gt_hdrupd.
      ENDIF.
**********************************************************************
*     if create-line2 is not INITIAL.
     if zbp_lc_app02_rv=>gt_line2data is not INITIAL.
     MODIFY zlc_app02_tb3 from table @zbp_lc_app02_rv=>gt_line2data.
     endif.
     if zbp_lc_app02_rv=>gt_hdrupd is not INITIAL.
     modify zlc_app02_tb1 from table @zbp_lc_app02_rv=>gt_hdrupd.
     endif.
*          endif.
**********************************************************************

    IF delete-header IS NOT INITIAL.
      LOOP AT delete-header INTO DATA(ls_gpentry).
        DELETE FROM zlc_app02_tb1 WHERE lnum = @ls_gpentry-Lnum.
        DELETE FROM zlc_app02_tb2 WHERE lnum = @ls_gpentry-Lnum.
        DELETE from zlc_app02_tb3 where lnum = @ls_gpentry-Lnum.
      ENDLOOP.
    ENDIF.
*     IF DELETE-line IS NOT INITIAL.
*    LOOP AT delete-line INTO DATA(ls_gipentry).
*    DELETE FROM zlc_app02_tb2 WHERE lnum = @ls_gipentry-Lnum AND lcline = @ls_gipentry-Lcline.
*    ENDLOOP.
*    ENDIF.
*     IF DELETE-line2 IS NOT INITIAL.
*    LOOP AT delete-line2 INTO DATA(ls_gipentry2).
*    DELETE FROM zlc_app02_tb3 WHERE lnum = @ls_gipentry2-Lnum AND lcline = @ls_gipentry2-Lcline  .
*    ENDLOOP.
*    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
