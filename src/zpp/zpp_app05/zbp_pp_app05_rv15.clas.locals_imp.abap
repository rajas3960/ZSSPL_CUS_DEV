CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS Closejob FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~Closejob RESULT result.

    METHODS gtdata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gtdata1.
    METHODS matval FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~matval RESULT result.

    METHODS salvalje FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~salvalje RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Closejob.
  ENDMETHOD.

  METHOD gtdata1.
  ENDMETHOD.

  METHOD matval.

  ENDMETHOD.

  METHOD salvalje.
  ENDMETHOD.

ENDCLASS.

CLASS lhc__item1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item1 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item1 RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _item1 RESULT result.

    METHODS addmat FOR MODIFY
      IMPORTING keys FOR ACTION _item1~addmat RESULT result.

    METHODS matvh FOR MODIFY
      IMPORTING keys FOR ACTION _item1~matvh RESULT result.

    METHODS sovh FOR MODIFY
      IMPORTING keys FOR ACTION _item1~sovh RESULT result.

    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item1~gtidata1.

ENDCLASS.

CLASS lhc__item1 IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD addmat.
  ENDMETHOD.

  METHOD matvh.
  ENDMETHOD.

  METHOD sovh.
  ENDMETHOD.

  METHOD gtidata1.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP05_RV1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP05_RV1 IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
