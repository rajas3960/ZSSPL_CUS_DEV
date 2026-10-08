CLASS lsc_zlc_app_rv DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zlc_app_rv IMPLEMENTATION.

  METHOD save_modified.
  if create-lc is not INITIAL.
  if zbp_lc_app_rv=>gt_crtdt is not INITIAL.
  data(lt_gtenrty) = zbp_lc_app_rv=>gt_crtdt.
  modify zlc_app_tb FROM  TABLE @lt_gtenrty.
  endif.
  endif.

  if update-lc is not INITIAL.
  if zbp_lc_app_rv=>gt_uprdt is not INITIAL.
  DATA(lt_gtupdt) = zbp_lc_app_rv=>gt_uprdt.
  MODIFY zlc_app_tb from table @lt_gtupdt.
  ENDIF.
  endif.

   IF delete-lc IS NOT INITIAL.
      LOOP AT delete-lc INTO DATA(ls_gpentry).
        DELETE FROM zlc_app_tb WHERE lnum = @ls_gpentry-Lnum.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.



ENDCLASS.

CLASS lhc_LC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR lc RESULT result.
    METHODS gtdata2 FOR DETERMINE ON SAVE
      IMPORTING keys FOR lc~gtdata2.

    METHODS gtdata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR lc~gtdata1.

ENDCLASS.

CLASS lhc_LC IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GtData2.
  DATA : lt_gtupdt type table of zlc_app_tb,
       ls_gtupdt type zlc_app_tb.

READ ENTITIES OF zlc_app_rv IN LOCAL MODE ENTITY lc
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT data(it_data).
data(ls_data) =  it_data[ 1 ].

       MOVE-CORRESPONDING ls_data to ls_gtupdt.
        ls_gtupdt-tot_balance = ls_gtupdt-lc_amt - ls_gtupdt-lc_utilz.

        APPEND ls_gtupdt to lt_gtupdt.
        zbp_lc_app_rv=>gt_uprdt = lt_gtupdt.


  ENDMETHOD.

  METHOD GtData1.
DATA : lt_gtentry type table of zlc_app_tb,
       ls_gtentry type zlc_app_tb.

READ ENTITIES OF zlc_app_rv IN LOCAL MODE ENTITY lc
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT data(it_data).
data(ls_data) =  it_data[ 1 ].

ls_gtentry-lnum     =  ls_data-Lnum.
ls_gtentry-valfrm    =  ls_data-valfrm.
ls_gtentry-valto     =  ls_data-valto.
ls_gtentry-lcissdt    =  ls_data-lcissdt.
ls_gtentry-banknam      =  ls_data-banknam.
ls_gtentry-bank_branch  =  ls_data-bank_branch.
ls_gtentry-stp          =  ls_data-stp.
ls_gtentry-stp_name     =  ls_data-stp_name.
ls_gtentry-lc_expdt     =  ls_data-lc_expdt.
ls_gtentry-lc_amt       =  ls_data-lc_amt.
ls_gtentry-lc_utilz     =  ls_data-lc_utilz.
ls_gtentry-tot_balance  =  ls_gtentry-lc_amt - ls_gtentry-lc_utilz.
ls_gtentry-lc_curr      =  ls_data-lc_curr.
ls_gtentry-createdby    =  ls_data-createdby.
ls_gtentry-createdon    =  ls_data-createdon.
ls_gtentry-lastchangedby =  ls_data-lastchangedby.
ls_gtentry-lastchangedon =  ls_data-lastchangedon.
ls_gtentry-status       =  ls_data-status.
ls_gtentry-zattachment  =  ls_data-zattachment.
ls_gtentry-project      =  ls_data-project.
ls_gtentry-applicant    =  ls_data-applicant.
ls_gtentry-ldd          =  ls_data-ldd.
ls_gtentry-boeno        =  ls_data-boeno.
ls_gtentry-boedt        =  ls_data-boedt.
ls_gtentry-dudt  =  ls_data-dudt.
ls_gtentry-minetype =  ls_data-minetype.
ls_gtentry-filename =  ls_data-filename.
ls_gtentry-boeamt   =  ls_data-boeamt.
ls_gtentry-boecurr =  ls_data-boecurr.
ls_gtentry-noofdays =  ls_data-noofdays.
ls_gtentry-accbstus       =  ls_data-accbstus.

append ls_gtentry to lt_gtentry.
zbp_lc_app_rv=>gt_crtdt = lt_gtentry.


  ENDMETHOD.

ENDCLASS.
