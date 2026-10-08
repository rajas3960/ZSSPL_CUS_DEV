CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS GetData FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~GetData.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GetData.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZRCV_LC_DLV_H DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZRCV_LC_DLV_H IMPLEMENTATION.

  METHOD save_modified.

**********************************************************************
*************** Delete Root entity records ***************************
    IF delete-header IS NOT INITIAL.
      LOOP AT delete-header INTO DATA(ls_grdel).
        DELETE FROM ztb1_lc_dlv_h WHERE recguid = @ls_grdel-Recguid.
      ENDLOOP.
    ENDIF.
**********************************************************************

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
