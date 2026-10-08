CLASS lhc_ZPP_APPS05_COT01 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zpp_apps05_cot01 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpp_apps05_cot01 RESULT result.

    METHODS contract FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps05_cot01~contract .

    METHODS nocontract FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps05_cot01~nocontract RESULT result.

ENDCLASS.

CLASS lhc_ZPP_APPS05_COT01 IMPLEMENTATION.

  METHOD get_instance_features.
  READ ENTITIES OF zpp_apps05_cot01 IN LOCAL MODE
ENTITY zpp_apps05_cot01
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(LT_HDR).
 result = VALUE #( FOR ls_data IN Lt_hdr
        (   %tky =  ls_data-%tky
         %action-contract         =            COND #( WHEN ls_data-contract = 'C'
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled )
         %action-nocontract         =            COND #( WHEN ls_data-contract = 'C'
                                                    THEN
                                                     if_abap_behv=>fc-o-enabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-disabled

     ) ) ) .


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD contract.
**********************************************************************
READ ENTITIES OF zpp_apps05_cot01 IN LOCAL MODE
ENTITY zpp_apps05_cot01
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(LT_HDR).
DATA(LS_HDR) = lt_hdr[ 1 ].
DATA: GS_HDR TYPE zpp_apps05_cohb.
**********************************************************************
IF lt_hdr IS NOT INITIAL.
MOVE-CORRESPONDING ls_hdr TO gs_hdr.
gs_hdr-contract = 'C'.
ENDIF.
APPEND gs_hdr TO zbp_pp_apps05_cot01=>gt_hdr .


  ENDMETHOD.

  METHOD nocontract.
READ ENTITIES OF zpp_apps05_cot01 IN LOCAL MODE
ENTITY zpp_apps05_cot01
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(LT_HDR).
DATA(LS_HDR) = lt_hdr[ 1 ].
DATA: GS_HDR TYPE zpp_apps05_cohb.
**********************************************************************
IF lt_hdr IS NOT INITIAL.
MOVE-CORRESPONDING ls_hdr TO gs_hdr.
gs_hdr-contract = ' '.
ENDIF.
APPEND gs_hdr TO zbp_pp_apps05_cot01=>gt_hdr .

 result = VALUE #(
       FOR ls1 IN lt_hdr (
         %tky   = ls1-%tky
         %param = ls1
       )
     ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS05_COT01 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS05_COT01 IMPLEMENTATION.

  METHOD save_modified.
  IF zbp_pp_apps05_cot01=>gt_hdr IS NOT INITIAL.
  MODIFY zpp_apps05_cohb FROM TABLE @zbp_pp_apps05_cot01=>gt_hdr.
  ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
