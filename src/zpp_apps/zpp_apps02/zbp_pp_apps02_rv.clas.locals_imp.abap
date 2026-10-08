CLASS lhc__Hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.
    METHODS seltitem FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~seltitem RESULT result.

    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_data1.

ENDCLASS.

CLASS lhc__Hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD seltitem.
**********************************************************************
    DATA : gs_item TYPE zpp_apps02_itb1.
**********************************************************************
    READ ENTITIES OF zpp_apps02_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT * FROM zpp_apps02_se WHERE BillOfMaterialComponent = @ls_hdr-Sectmat AND PlannedOrder IS NOT INITIAL INTO TABLE @DATA(lt_table).

    zbp_pp_apps02_rv=>gt_item  = VALUE #( FOR ls IN lt_table INDEX INTO lv ( uuid = ls_hdr-Uuid
    orderno = ls-PlannedOrder
*    sno = lv
    length = ls-yy1_length_mm_prd
    matnr = ls-Material
    maktx = ls-ProductDescription
    plant = ls-Plant
    width = ls-yy1_width_mm_prd
    netwt = ''
    plnqty = ls-OrderQuantity
    uom = ls-OrderQuantityUnit
    vbeln = ls-SalesOrder
    soitem = ls-SalesOrderItem ) ).
**********************************************************************
result = VALUE #( for ls2 in lt_hdr (  %tky = ls2-%tky
%param = ls2 ) ).




  ENDMETHOD.
**********************************************************************
  METHOD gt_data1.
**********************************************************************
    DATA : gs_hdr TYPE zpp_apps02_htb1.
**********************************************************************
    READ ENTITIES OF zpp_apps02_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
**********************************************************************
    APPEND gs_hdr TO zbp_pp_apps02_rv=>gt_hdr.
  ENDMETHOD.
**********************************************************************

ENDCLASS.

CLASS lhc_zpp_apps02_rv DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lhc_ZPP_APPS02_RV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
    IF zbp_pp_apps02_rv=>gt_hdr IS NOT INITIAL.
      MODIFY zpp_apps02_htb1 FROM TABLE @zbp_pp_apps02_rv=>gt_hdr.
    ENDIF.
**********************************************************************
    IF zbp_pp_apps02_rv=>gt_item IS NOT INITIAL.
      MODIFY zpp_apps02_itb1 FROM TABLE @zbp_pp_apps02_rv=>gt_item.
    ENDIF.
**********************************************************************
    if zbp_pp_apps02_rv=>gt_item2 is not INITIAL.
    MODIFY zpp_apps02_itb2 from table @zbp_pp_apps02_rv=>gt_item2.
    endif.
**********************************************************************


    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(ls_del).
        DELETE FROM zpp_apps02_htb1 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps02_itb1 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps02_itb2 WHERE uuid = @ls_del-Uuid.

      ENDLOOP.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
