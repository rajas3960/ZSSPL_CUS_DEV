CLASS lhc_hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR hdr RESULT result.

    METHODS active FOR MODIFY
      IMPORTING keys FOR ACTION hdr~active.

    METHODS inactive FOR MODIFY
      IMPORTING keys FOR ACTION hdr~inactive.

    METHODS price FOR MODIFY
      IMPORTING keys FOR ACTION hdr~price.

ENDCLASS.

CLASS lhc_hdr IMPLEMENTATION.

  METHOD get_instance_features.
   READ ENTITIES OF zpp_appr_09_rv IN LOCAL MODE
ENTITY hdr
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(LT_HDR).
 result = VALUE #( FOR ls_data IN Lt_hdr
        (   %tky =  ls_data-%tky
         %action-active         =            COND #( WHEN ls_data-Mark = 'X'
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled )
         %action-inactive         =            COND #( WHEN ls_data-Mark = 'X'
                                                    THEN
                                                     if_abap_behv=>fc-o-enabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-disabled

     ) ) ) .

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD active.
**********************************************************************
    DATA : gs_hdr TYPE zpp_appr_09_htb.

    READ ENTITIES OF zpp_appr_09_rv IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) =  lt_hdr[ 1 ]  .

    MOVE-CORRESPONDING ls_hdr TO gs_hdr.

    gs_hdr-mark = 'X'.

    APPEND gs_hdr TO zbp_pp_appr_09_rv=>gt_hdr.

**********************************************************************

  ENDMETHOD.

  METHOD inactive.
**********************************************************************
    DATA : gs_hdr TYPE zpp_appr_09_htb.

    READ ENTITIES OF zpp_appr_09_rv IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) =  lt_hdr[ 1 ]  .

    MOVE-CORRESPONDING ls_hdr TO gs_hdr.

    gs_hdr-mark = ' '.

    APPEND gs_hdr TO zbp_pp_appr_09_rv=>gt_hdr.

**********************************************************************

  ENDMETHOD.

  METHOD price.
**********************************************************************
    DATA : gs_hdr TYPE zpp_appr_09_htb.

    READ ENTITIES OF zpp_appr_09_rv IN LOCAL MODE
    ENTITY hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) =  lt_hdr[ 1 ]  .

    MOVE-CORRESPONDING ls_hdr TO gs_hdr.

    gs_hdr-price = keys[ 1 ]-%param-Rate.

    APPEND gs_hdr TO zbp_pp_appr_09_rv=>gt_hdr.
**********************************************************************
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPR_09_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPR_09_RV IMPLEMENTATION.

  METHOD save_modified.
    IF zbp_pp_appr_09_rv=>gt_hdr IS NOT INITIAL.
    MODIFY zpp_appr_09_htb from table @zbp_pp_appr_09_rv=>gt_hdr.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
