CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS gt_section FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gt_section RESULT result.
    METHODS gtsect FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtsect RESULT result.
    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_data1.

    METHODS get_new_uuid RETURNING VALUE(rv_uuid) TYPE sysuuid_x16.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv  IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemselc
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************
    result = VALUE #( FOR ls_HDR IN lt_hdr ( %tky = ls_HDR-%tky
    %action-gt_section = COND #( WHEN lt_item IS NOT INITIAL
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE
                                                               if_abap_behv=>fc-o-enabled
                                                               )
    %features-%delete =  COND #( WHEN ls_HDR-Plannedorder IS NOT INITIAL
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE
                                                               if_abap_behv=>fc-o-enabled
                                                               )
    %action-Edit = COND #( WHEN ls_HDR-Plannedorder IS NOT INITIAL
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE
                                                               if_abap_behv=>fc-o-enabled
                                                               )
    %features-%update = COND #( WHEN ls_HDR-Plannedorder IS NOT INITIAL
                                                               THEN if_abap_behv=>fc-o-disabled
                                                               ELSE
                                                               if_abap_behv=>fc-o-enabled
                                                               )
                                                                   ) ).





  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD gt_section.
**********************************************************************
    DATA : gt_item TYPE TABLE FOR CREATE zpp_appsr_rv\_itemselc.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).


**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT *
      FROM zpp_apps_plnvh AS hdr
      WHERE hdr~material       = @ls_hdr-secmat
        AND hdr~supplyingplant = @ls_hdr-plant
        AND ( hdr~Mark2 = ' ' )
        AND hdr~schedlinestscdeliverydate
            BETWEEN @ls_hdr-frmdt AND @ls_hdr-todt
      INTO TABLE @DATA(lt_item).
**********************************************************************
*    IF lt_item IS NOT INITIAL.
*        TRY.
*          data(lv_item) = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
*        CATCH cx_uuid_error.
*        data(lv_er3) = 1.
*      ENDTRY.
*
*
*
*      gt_item = VALUE #(  ( %cid_ref = keys[ 1 ]-%cid_ref
*                         %is_draft = keys[ 1 ]-%is_draft
*                         Uuid = keys[ 1 ]-Uuid
*      %target = VALUE #( FOR ls IN lt_item index INTO i
*    ( %cid = get_new_uuid(  )
*      %is_draft = keys[ 1 ]-%is_draft
*      %data = VALUE #(
*     Uuid = keys[ 1 ]-Uuid
*     Purchaseorder = ls-PurchaseOrder
*     Purchaseitm = ls-PurchaseOrderItem
*     matnr     = ls-Material
*     maktx     = ls-PurchaseOrderItemText
*     length   = ls-YY1_Length_PDI
*     width    = ls-YY1_Width_PDI
*     Menge   = ls-OrderQuantity
*     Meins      = ls-PurchaseOrderQuantityUnit
*     Prioritypo = ls-YY1_PriorityPONO_PDH
*     Pcs = ls-YY1_Pieces_PDI
*     Recplt = ls-Plant
**   Mark = 'X'
*
*   ) %control = VALUE #(
*  Uuid = if_abap_behv=>mk-on
*     Purchaseorder = if_abap_behv=>mk-on
*     Purchaseitm = if_abap_behv=>mk-on
*     matnr     = if_abap_behv=>mk-on
*     maktx     = if_abap_behv=>mk-on
*     length   = if_abap_behv=>mk-on
*     width    = if_abap_behv=>mk-on
*     Menge   = if_abap_behv=>mk-on
*     Meins      = if_abap_behv=>mk-on
*     Prioritypo = if_abap_behv=>mk-on
*     Pcs = if_abap_behv=>mk-on
*     Recplt = if_abap_behv=>mk-on
**   mark   = if_abap_behv=>mk-on
*
*   )
*
*
*
*    ) ) ) ).
    DATA:
*      gt_item TYPE TABLE FOR CREATE zpp_appsr_rv\_itemselc,
      ls_create LIKE LINE OF gt_item,
      ls_target LIKE LINE OF ls_create-%target.

    CLEAR gt_item.

    IF lt_item IS NOT INITIAL.

      LOOP AT lt_item INTO DATA(ls).

        " Generate UNIQUE CID every time
        DATA: lv_cid TYPE sysuuid_c32.

        TRY.
            lv_cid = cl_system_uuid=>create_uuid_c32_static(  ).
          CATCH cx_uuid_error.
            CONTINUE. " skip if UUID fails
        ENDTRY.

        CLEAR ls_target.

        ls_target-%cid      = lv_cid.
        ls_target-%is_draft = keys[ 1 ]-%is_draft.

        ls_target-%data = VALUE #(
          Uuid          = keys[ 1 ]-Uuid
          Purchaseorder = ls-PurchaseOrder
          Purchaseitm   = ls-PurchaseOrderItem
          matnr         = ls-Material
          maktx         = ls-PurchaseOrderItemText
          length        = ls-YY1_Length_PDI
          width         = ls-YY1_Width_PDI
          Menge         = ls-OrderQuantity
          Meins         = ls-PurchaseOrderQuantityUnit
          Prioritypo    = ls-YY1_PriorityPONO_PDH
          Pcs           = ls-YY1_Pieces_PDI
          Recplt        = ls-Plant
        ).

        ls_target-%control = VALUE #(
          Uuid          = if_abap_behv=>mk-on
          Purchaseorder = if_abap_behv=>mk-on
          Purchaseitm   = if_abap_behv=>mk-on
          matnr         = if_abap_behv=>mk-on
          maktx         = if_abap_behv=>mk-on
          length        = if_abap_behv=>mk-on
          width         = if_abap_behv=>mk-on
          Menge         = if_abap_behv=>mk-on
          Meins         = if_abap_behv=>mk-on
          Prioritypo    = if_abap_behv=>mk-on
          Pcs           = if_abap_behv=>mk-on
          Recplt        = if_abap_behv=>mk-on
        ).

        " Append to parent structure
        IF ls_create IS INITIAL.
          ls_create-%cid_ref = keys[ 1 ]-%cid_ref.
          ls_create-%is_draft = keys[ 1 ]-%is_draft.
          ls_create-uuid = keys[ 1 ]-uuid.
        ENDIF.

        APPEND ls_target TO ls_create-%target.

      ENDLOOP.

      APPEND ls_create TO gt_item.



      MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
      ENTITY _hdr CREATE BY \_itemselc
      FROM gt_item.
    ELSE.
      DATA : lv_text TYPE string.
      lv_text  = 'You Dont have Section Material'.
      APPEND VALUE #(  %tky = ls_hdr-%tky
              %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
          text = lv_text )
                ) TO reported-_hdr.
      APPEND VALUE #( %tky = ls_hdr-%tky  ) TO failed-_hdr.


    ENDIF.

    result = VALUE #(
   FOR ls3 IN lt_hdr (
     %tky   = ls3-%tky
     %param = ls3
   )
 ).

  ENDMETHOD.

  METHOD GtSect.
**********************************************************************
    DATA : gt_item TYPE TABLE FOR CREATE zpp_appsr_rv\_itemselc.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).


    READ ENTITY IN LOCAL MODE zpp_appsr_rv BY \_itemseld
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(lt_itm).

    DATA(lv) = lines( lt_itm ).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT * FROM zpp_apps_plnvh WHERE Material = @ls_hdr-Secmat AND Plant = @ls_hdr-Plant AND
     SchedLineStscDeliveryDate BETWEEN @ls_hdr-Frmdt AND @ls_hdr-Todt
     INTO TABLE @DATA(lt_item).
**********************************************************************

    gt_item = VALUE #(  ( %cid_ref =  keys[ 1 ]-%cid_ref
                       %is_draft = keys[ 1 ]-%is_draft
                       Uuid = keys[ 1 ]-Uuid
    %target = VALUE #( FOR ls IN lt_item INDEX INTO i
    ( %cid =   'ITEM_' && i
    %is_draft = keys[ 1 ]-%is_draft
    %data = VALUE #(
   Uuid = keys[ 1 ]-Uuid
   Purchaseorder = ls-PurchaseOrder
   Purchaseitm = ls-PurchaseOrderItem
   matnr     = ls-Material
   maktx     = ls-PurchaseOrderItemText
   length   = ls-YY1_Length_PDI
   width    = ls-YY1_Width_PDI
   Menge   = ls-OrderQuantity
   Meins      = ls-PurchaseOrderQuantityUnit
   Prioritypo = ls-YY1_PriorityPONO_PDH
   Pcs = ls-YY1_Pieces_PDI
   Recplt = ls-Plant
*   Mark = 'X'

 ) %control = VALUE #(
Uuid = if_abap_behv=>mk-on
   Purchaseorder = if_abap_behv=>mk-on
   Purchaseitm = if_abap_behv=>mk-on
   matnr     = if_abap_behv=>mk-on
   maktx     = if_abap_behv=>mk-on
   length   = if_abap_behv=>mk-on
   width    = if_abap_behv=>mk-on
   Menge   = if_abap_behv=>mk-on
   Meins      = if_abap_behv=>mk-on
   Prioritypo = if_abap_behv=>mk-on
   Pcs = if_abap_behv=>mk-on
   Recplt = if_abap_behv=>mk-on
*   mark   = if_abap_behv=>mk-on

 )



  ) ) ) ).

    MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _hdr CREATE BY \_itemselc
    AUTO FILL CID WITH gt_item.

    result = VALUE #(
   FOR ls3 IN lt_hdr (
     %tky   = ls3-%tky
     %param = ls3
   )
 ).
  ENDMETHOD.

  METHOD gt_data1.
**********************************************************************
    DATA : gs_hdr TYPE zpp_appsr_htb.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv IN LOCAL MODE
      ENTITY _hdr BY \_itemseld " Use the association name from your BDEF
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items_to_update).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
**********************************************************************

**********************************************************************
    IF ls_hdr IS NOT INITIAL.
      MODIFY ENTITIES OF i_plannedordertp PRIVILEGED ENTITY plannedorder
                 CREATE FIELDS ( material mrparea plndorderplannedstartdate materialprocurementcategory
                                 plannedorderprofile totalquantity baseunit )
                 WITH VALUE #( ( %cid = 'ORD_' && ls_hdr-Uuid
                 material = ls_hdr-Secmat
                 mrparea  = ls_hdr-Plant
                 plndorderplannedstartdate = sy-datlo
                 materialprocurementcategory = 'E'
                 plannedorderprofile = 'LA'
                 totalquantity = ls_hdr-Totqty
                 baseunit = ls_hdr-Uom
              ) )

            MAPPED DATA(ls_create_mapped)
            FAILED DATA(ls_create_failed)
            REPORTED DATA(ls_create_reported).
    ENDIF.
    IF ls_create_failed IS INITIAL.
      gs_hdr-plannedorder = ls_create_mapped-plannedorder[ 1 ]-PlannedOrder.
      gs_hdr-status = 'C'.

      MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _hdr
    UPDATE FROM VALUE #( ( %tky = ls_hdr-%tky
    Plannedorder = gs_hdr-plannedorder
    Status = gs_hdr-status
    %control-Plannedorder = if_abap_behv=>mk-on
    %control-Status = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped1)
     FAILED DATA(ls_failed1)
     REPORTED DATA(ls_reported1).

        MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _itemwe " Ensure this is the correct entity name for your items
      UPDATE FROM VALUE #( FOR ls_item IN lt_items_to_update (
        %tky         = ls_item-%tky
        Plannedorder = gs_hdr-plannedorder
        %control     = VALUE #( Plannedorder = if_abap_behv=>mk-on )
      ) )

      MAPPED   DATA(ls_mod_mapped)
      FAILED   DATA(ls_mod_failed)
      REPORTED DATA(ls_mod_reported).






      APPEND gs_hdr TO zbp_pp_appsr_rv=>gt_hdr.
    ELSE .
      APPEND VALUE #( %tky = ls_hdr-%tky
      %msg = ls_create_reported-plannedorder[ 1 ]-%msg ) TO reported-_hdr.

    ENDIF.

  ENDMETHOD.

  METHOD get_new_uuid.
    TRY.
        DATA(lv_item) = cl_system_uuid=>create_uuid_c32_static(  ).
      CATCH cx_uuid_error.
        DATA(lv_er3) = 1.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

CLASS lhc__item DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item RESULT result.

    METHODS gt_selection FOR MODIFY
      IMPORTING keys FOR ACTION _item~gt_selection RESULT result.

    METHODS get_new_uuid RETURNING VALUE(rv_uuid) TYPE sysuuid_x16.
ENDCLASS.

CLASS lhc__item IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemselc
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************

    result = VALUE #( FOR ls IN lt_item ( %tky = ls-%tky
    %action-gt_selection =  COND #( WHEN ls-Mark IS NOT INITIAL
                                                                    THEN if_abap_behv=>fc-o-disabled
                                                                    ELSE
                                                                    if_abap_behv=>fc-o-enabled
                                                                    )
     ) ).







  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD gt_selection.
**********************************************************************
    READ ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    READ ENTITY IN LOCAL MODE zpp_appsr_rv BY \_itemseld
ALL FIELDS WITH CORRESPONDING #( keys )
RESULT DATA(lt_itm).
    IF lt_itm IS NOT INITIAL.
      DATA(lv) = lines( lt_itm ) + 1.
    ELSE.
      lv = 1.
    ENDIF.


**********************************************************************
    DELETE lt_item WHERE mark = 'X'.

    DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).

    IF ls_item IS INITIAL.
      " No unplanned item exists
      RETURN.
    ENDIF.
**********************************************************************
    DATA : lv_totwt1 TYPE menge_d.
    DATA : gt_item2 TYPE TABLE FOR CREATE zpp_appsr_rv\_itemseld.
**********************************************************************
*    SELECT SINGLE MAX( sno ) AS sno FROM zpp_apps01_ditb2  WHERE uuid = @ls_item-Uuid INTO @DATA(LV_Sno).
    " Generate UNIQUE CID every time
    DATA: lv_cid TYPE sysuuid_c32.

    TRY.
        lv_cid = cl_system_uuid=>create_uuid_c32_static(  ).
      CATCH cx_uuid_error.
        DATA(lv_eror) = 1. " skip if UUID fails
    ENDTRY.


    gt_item2 = VALUE #( (  %cid_ref = keys[ 1 ]-%cid_ref
         %is_draft = keys[ 1 ]-%is_draft
         Uuid = keys[ 1 ]-Uuid
         %target = VALUE #(  (
          %cid = lv_cid
          %is_draft = keys[ 1 ]-%is_draft
          %data = VALUE #(
          Uuid = keys[ 1 ]-Uuid
         Purchaseorder = ls_item-Purchaseorder
         Purchaseitm = ls_item-Purchaseitm
         Length = ls_item-Length
         Maktx = ls_item-Maktx
         Mark = 'X'
         Matnr = ls_item-Matnr
         Meins = ls_item-Meins
         Menge = ls_item-Menge
         Pcs = ls_item-Pcs
         Prioritypo = ls_item-Prioritypo
         Recplt = ls_item-Recplt
         Width = ls_item-Width
           )
           %control = VALUE #(
     Uuid = if_abap_behv=>mk-on
         Purchaseorder = if_abap_behv=>mk-on
         Purchaseitm = if_abap_behv=>mk-on
         Length = if_abap_behv=>mk-on
         Maktx = if_abap_behv=>mk-on
         Mark = if_abap_behv=>mk-on
         Matnr = if_abap_behv=>mk-on
         Meins = if_abap_behv=>mk-on
         Menge = if_abap_behv=>mk-on
         Pcs = if_abap_behv=>mk-on
         Prioritypo = if_abap_behv=>mk-on
         Recplt = if_abap_behv=>mk-on
         Width = if_abap_behv=>mk-on

    )  ) )  ) ).

**********************************************************************
    MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _item
    UPDATE FROM VALUE #( ( %tky = ls_item-%tky
    Mark = 'X'
    %control-Mark = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped)
     FAILED DATA(ls_failed)
     REPORTED DATA(ls_reported).
***********************************************************************
*read ENTITIES OF zpp_appsr_rv IN LOCAL MODE
*ENTITY _hdr BY \_itemseld
*ALL FIELDS WITH CORRESPONDING #( keys )
*RESULT data(lt_result).
*if lt_result is not inITIAL.
*MODIFY ENTITIES OF zpp_appsr_rv in LOCAL MODE
*ENTITY _itemwe DELETE FROM VALUE #(
*FOR ls in lt_result ( %key = ls-%key
*%is_draft = ls-%is_draft
*)
* )
* MAPPED data(lt_mappde)
* FAILED data(lt_faileds)
* REPORTED data(lt_rprot).
*
*
*endif.
*
*
*
*
*
*
***********************************************************************
    MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
     ENTITY _hdr CREATE BY  \_itemseld
     from gt_item2
      MAPPED DATA(lt_mappde1)
 FAILED DATA(lt_faileds1)
 REPORTED DATA(lt_rprot1).


    READ ENTITY IN LOCAL MODE  zpp_appsr_rv BY \_itemseld
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1).

**********************************************************************
    SELECT SINGLE  FROM    zpp_appsr_dhtb  FIELDS totqty WHERE uuid = @ls_item-Uuid INTO @DATA(lv_totwt).
    IF lv_totwt IS NOT INITIAL.
      lv_totwt1 =  ls_item-Menge + lv_totwt.
    ELSE .
      lv_totwt1 = ls_item-Menge.

    ENDIF.

    MODIFY ENTITIES OF zpp_appsr_rv IN LOCAL MODE
    ENTITY _hdr
    UPDATE FROM VALUE #( ( Uuid = ls_item-Uuid
    %is_draft = ls_item-%is_draft
    Totqty = lv_totwt1
    Uom = ls_item-Meins
    %control-Totqty = if_abap_behv=>mk-on
    %control-Uom = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped1)
     FAILED DATA(ls_failed1)
     REPORTED DATA(ls_reported1).
**********************************************************************





  ENDMETHOD.

  METHOD get_new_uuid.
    TRY.
        DATA(lv_item) = cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ).
      CATCH cx_uuid_error.
        DATA(lv_er3) = 1.
    ENDTRY.
  ENDMETHOD.

ENDCLASS.

*CLASS lsc_ZPP_APPSR_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS save_modified REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_ZPP_APPSR_RV IMPLEMENTATION.
*
*  METHOD save_modified.
***********************************************************************
*    IF create-_hdr IS NOT INITIAL.
*      IF zbp_pp_appsr_rv=>gt_hdr IS NOT INITIAL.
***********************************************************************
*        MODIFY zpp_appsr_htb FROM TABLE @zbp_pp_appsr_rv=>gt_hdr.
*        DATA(plannedorder) = zbp_pp_appsr_rv=>gt_hdr[ 1 ]-plannedorder.
*        DATA(uuid)         = zbp_pp_appsr_rv=>gt_hdr[ 1 ]-uuid.
***********************************************************************
*        SELECT * FROM zpp_appsr_ditb1 WHERE uuid = @uuid INTO TABLE @DATA(lt_item1).
*        SELECT * FROM zpp_appsr_ditb2 WHERE uuid = @uuid INTO TABLE @DATA(lt_item2).
***********************************************************************
*        IF lt_item1 IS NOT INITIAL.
*          zbp_pp_appsr_rv=>gt_item = VALUE #( FOR wa IN lt_item1 (
*          uuid = wa-uuid
*          Purchaseorder = wa-PurchaseOrder
*          Purchaseitm = wa-purchaseitm
*          matnr     = wa-matnr
*          maktx     = wa-maktx
*          length   = wa-length
*          width    = wa-width
*          Menge   = wa-menge
*          Meins      = wa-meins
*          Prioritypo = wa-prioritypo
*          Pcs = wa-pcs
*          Recplt = wa-recplt
*          mark = wa-mark
*                ) ).
*          MODIFY zpp_appsr_itb1 FROM TABLE @zbp_pp_appsr_rv=>gt_item.
*        ENDIF.
***********************************************************************
*        IF lt_item2 IS NOT INITIAL.
*          zbp_pp_appsr_rv=>gt_item2 = VALUE #( FOR wa2 IN lt_item2 (
*           uuid = wa2-uuid
*           Purchaseorder = wa2-PurchaseOrder
*           Purchaseitm = wa2-purchaseitm
*           matnr     = wa2-matnr
*           maktx     = wa2-maktx
*           length   = wa2-length
*           width    = wa2-width
*           Menge   = wa2-menge
*           Meins      = wa2-meins
*           Prioritypo = wa2-prioritypo
*           Pcs = wa2-pcs
*           Recplt = wa2-recplt
*           mark = wa2-mark
*           plannedorder = plannedorder
*                 ) ).
*          MODIFY zpp_appsr_itb2 FROM TABLE @zbp_pp_appsr_rv=>gt_item2.
*        ENDIF.
*
*      ENDIF.
*
*
*
*
*    ENDIF.
*
*
*    IF delete-_hdr IS NOT INITIAL.
*      LOOP AT delete-_hdr INTO DATA(ls_hdr).
*        DELETE FROM zpp_appsr_htb WHERE uuid = @ls_hdr-Uuid.
*        DELETE FROM zpp_appsr_itb1 WHERE uuid = @ls_hdr-Uuid.
*        DELETE FROM zpp_appsr_itb2 WHERE uuid = @ls_hdr-Uuid.
*      ENDLOOP.
*    ENDIF.
*
*
*
*
*
*
*
*
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.
*
*ENDCLASS.
