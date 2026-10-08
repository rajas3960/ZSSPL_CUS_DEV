CLASS lhc_ZNS_PKG_RV DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zns_pkg_rv RESULT result.

    METHODS uploadexcel FOR MODIFY
      IMPORTING keys FOR ACTION zns_pkg_rv~uploadexcel RESULT result.

ENDCLASS.

CLASS lhc_ZNS_PKG_RV IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD uploadexcel.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZNS_PKG_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZNS_PKG_RV IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
