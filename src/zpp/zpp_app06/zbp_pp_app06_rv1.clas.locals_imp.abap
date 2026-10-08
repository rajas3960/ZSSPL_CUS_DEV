CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS load_item FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~load_item RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zpp_app06_rv1 IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_hdr).

    result = VALUE #( FOR w IN lt_hdr ( %tky = w-%tky
                                        %action-load_item = COND #( WHEN w-Status = 'C' THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
                                        %action-Edit = COND #( WHEN w-Status = 'C' THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
                                        %assoc-_Item1  = if_abap_behv=>fc-o-disabled
                                        %assoc-_Item2  = if_abap_behv=>fc-o-disabled ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD load_item.

    READ ENTITIES OF zpp_app06_rv1 IN LOCAL MODE ENTITY _hdr ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_hdr).

    DATA(lv_jobsheet) = VALUE #( keys[ 1 ]-Jobshtnum  OPTIONAL ).

    SELECT SINGLE @abap_true FROM zpp_app06_itb1 WHERE jobshtnum = @lv_jobsheet INTO @DATA(lv_flag).
    IF lv_flag IS INITIAL.
      SELECT FROM zpp_app03_itb2
        FIELDS jobsheet, matnr, SUM( reqty ) AS totreqty
      WHERE jobsheet = @lv_jobsheet GROUP BY jobsheet, matnr INTO TABLE @DATA(lt_data).

      SELECT FROM zpp_app03_itb1
          FIELDS jobshtnum, matnr, plant, maktx, uom, createdby, createdon
      WHERE jobshtnum = @lv_jobsheet AND totreqty IS NOT INITIAL
      INTO TABLE @DATA(lt_data1).

      zbp_pp_app06_rv1=>gt_item = VALUE #( FOR w IN lt_data ( jobshtnum = w-jobsheet
                                                              matnr = w-matnr
                                                              plant = VALUE #( lt_data1[ jobshtnum = w-jobsheet matnr = w-matnr ]-plant OPTIONAL )
                                                              maktx = VALUE #( lt_data1[ jobshtnum = w-jobsheet matnr = w-matnr ]-maktx OPTIONAL )
                                                              totreqty = w-totreqty
                                                              uom = VALUE #( lt_data1[ jobshtnum = w-jobsheet matnr = w-matnr ]-uom OPTIONAL )
                                                              receiptqty = '0.00'
                                                              totopnqty = w-totreqty
                                                              totreceiptqty = '0.00'
                                                              createdby = VALUE #( lt_data1[ jobshtnum = w-jobsheet matnr = w-matnr ]-createdby OPTIONAL )
                                                              createdon = VALUE #( lt_data1[ jobshtnum = w-jobsheet matnr = w-matnr ]-createdon OPTIONAL ) ) ).
    ELSE.
      LOOP AT lt_hdr INTO DATA(ls_hdr).
        failed-_hdr =  VALUE #( BASE failed-_hdr ( %tky = ls_hdr-%tky ) ).
        reported-_hdr = VALUE #( BASE reported-_hdr ( %tky = ls_hdr-%tky
                                                      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                                    text = |Material Already Loaded| ) ) ).
      ENDLOOP.
    ENDIF.

    result = VALUE #( FOR wa IN lt_hdr ( %tky = wa-%tky %param = wa ) ).

  ENDMETHOD.

ENDCLASS.

CLASS lhc__item1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item1 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item1 RESULT result.

    METHODS goodsreceipt FOR MODIFY
      IMPORTING keys FOR ACTION _item1~goodsreceipt RESULT result.

    METHODS save_item FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item1~save_item.

    METHODS rcptqty_val FOR VALIDATE ON SAVE
      IMPORTING keys FOR _item1~rcptqty_val.

ENDCLASS.

CLASS lhc__item1 IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITIES OF zpp_app06_rv1  IN LOCAL MODE ENTITY _item1 ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_item).

    result = VALUE #( FOR w IN lt_item ( %tky =  w-%tky
                                         %features-%field-receiptqty = COND #( WHEN w-Totopnqty = 0 THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
                                         %action-goodsreceipt = COND #( WHEN w-Totopnqty = 0 THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled ) ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD goodsreceipt.
  ENDMETHOD.

  METHOD save_item.

    READ ENTITIES OF zpp_app06_rv1 IN LOCAL MODE ENTITY _item1 ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_item).
    IF lt_item IS NOT INITIAL.
      zbp_pp_app06_rv1=>gt_item = VALUE #( FOR w IN lt_item ( CORRESPONDING #( w ) ) ).
    ENDIF.

  ENDMETHOD.

  METHOD rcptqty_val.

    READ ENTITIES OF zpp_app06_rv1 IN LOCAL MODE ENTITY _item1 ALL FIELDS WITH CORRESPONDING #( keys ) RESULT DATA(lt_item).

    LOOP AT lt_item INTO DATA(ls_item).
      IF ls_item-receiptqty > ls_item-Totopnqty.
        failed-_item1 = VALUE #( BASE failed-_item1 ( %tky = ls_item-%tky ) ).
        reported-_item1 = value #( base reported-_item1 ( %tky = ls_item-%tky
                                                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                                        text = |Goods Receipt Qty { ls_item-receiptqty } exceeds Open Qty { ls_item-Totopnqty }| ) ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc__item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item2 RESULT result.

ENDCLASS.

CLASS lhc__item2 IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP06_RV1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP06_RV1 IMPLEMENTATION.

  METHOD save_modified.

    IF zbp_pp_app06_rv1=>gt_item IS NOT INITIAL.
      MODIFY zpp_app06_itb1 FROM TABLE @zbp_pp_app06_rv1=>gt_item.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
