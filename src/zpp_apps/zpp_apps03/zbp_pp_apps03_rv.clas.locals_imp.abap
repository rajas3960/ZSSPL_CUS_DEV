CLASS lhc__item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS delde FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _item2~delde.

ENDCLASS.

CLASS lhc__item2 IMPLEMENTATION.

  METHOD delde.

  ENDMETHOD.

ENDCLASS.

CLASS lhc__item1 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item1 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item1 RESULT result.

    METHODS selectim FOR MODIFY
      IMPORTING keys FOR ACTION _item1~selectim RESULT result.
    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item1~gtidata1.

    METHODS reqty_val FOR VALIDATE ON SAVE
      IMPORTING keys FOR _item1~reqty_val.
    METHODS selectionitm FOR MODIFY
      IMPORTING keys FOR ACTION _item1~selectionitm RESULT result.

ENDCLASS.

CLASS lhc__item1 IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD selectim.
    DATA : gtitem TYPE TABLE OF zpp_apps03_itb1,
           gsitem TYPE zpp_apps03_itb1.
*    READ ENTITIES OF zpp_apps03_rv
*    IN LOCAL MODE ENTITY _hdr
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT data(ls_hdr).

    READ ENTITIES OF zpp_apps03_rv
   IN LOCAL MODE ENTITY _item1
     ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(lt_item1).
    DATA(ls_item1) = lt_item1[ 1 ].
*    IF ls_item1-%is_draft IS  INITIAL.
    MOVE-CORRESPONDING ls_item1 TO gsitem.

    SELECT SINGLE SUM( reqty ) AS totqty
    FROM zpp_apps03_itb2 WHERE orderno = @ls_item1-Orderno AND matnr = @ls_item1-Matnr INTO @DATA(wa_ord).

    SELECT SINGLE FROM  zpp_apps03_htb  FIELDS unitwet WHERE uuid = @ls_item1-Uuid INTO  @DATA(ls_unit).

    IF wa_ord IS NOT INITIAL.
      gsitem-totreqty = wa_ord + ls_item1-Reqty.
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.
    ELSE.
      gsitem-totreqty = ls_item1-Reqty .
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.

    ENDIF.


    IF sy-subrc = 0 .

      APPEND gsitem TO gtitem.

      SELECT SINGLE MAX( sno ) AS sno FROM zpp_apps03_itb2  WHERE uuid = @ls_item1-Uuid INTO @DATA(LV_Sno).
      IF gtitem IS NOT INITIAL.
        zbp_pp_apps03_rv=>gt_item2 =  VALUE #( FOR ls IN gtitem INDEX INTO lv  ( uuid = ls-uuid
                                                              sno = lv_sno + lv
                                                              matnr =   ls-matnr
                                                              orderno = ls-orderno
                                                              reqty = ls-reqty
                                                              uom = ls-uom
                                                              plant = ls-plant
                                                              vbeln = ls-vbeln
                                                              plnqty = ls-plnqty
                                                              maktx = ls-maktx
                                                              length = ls-length
                                                              width = ls-width
                                                              wetpc = ls-length * ls_unit  / 1000
                                                              netwt =  ls-length * ls_unit  / 1000 * ls-reqty
                                                                                      ) ).
      ENDIF.

*      ENDIF.



      gsitem-reqty = 0.
      APPEND gsitem TO gtitem.


      zbp_pp_apps03_rv=>gt_item = gtitem.



    ENDIF.







  ENDMETHOD.

  METHOD gtidata1.
    READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE
     ENTITY _Item1
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_item).

    zbp_pp_apps03_rv=>gt_item = VALUE #( FOR ls IN lt_item ( CORRESPONDING #( ls ) ) ).

  ENDMETHOD.

  METHOD reqty_val.
    READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE
      ENTITY _Item1
     ALL FIELDS WITH CORRESPONDING #( keys  )
     RESULT DATA(lt_item).


    reported-_item1 = VALUE #( FOR ls IN lt_item ( %tky =  ls-%tky
    %msg = COND #( WHEN ls-Reqty > ls-Totopnqty
    THEN

     new_message_with_text( severity = if_abap_behv_message=>severity-error
    text = |Requested Qty { ls-Reqty } exceeds Open Qty { ls-Totopnqty }| )

    ELSE
      new_message_with_text( severity = if_abap_behv_message=>severity-success
    text = |Requested Qty { ls-Reqty } Ok| )
      )
        ) ) .

*                failed-_item2 = VALUE #( lt_item[ billingreference  = <lfs_podet1>-billingreference gateitem = <fs_billref>-billingdocumentitem ]-item OPTIONAL ).

    LOOP AT lt_item INTO DATA(ls1).
      IF ls1-Reqty > ls1-Totopnqty.
        APPEND VALUE #( %tky = ls1-%tky  ) TO failed-_item1.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD selectionitm.
  ENDMETHOD.

ENDCLASS.

CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
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
    METHODS showleng FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~showleng RESULT result.
    METHODS print FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~print RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD seltitem.
**********************************************************************
    DATA : gs_item TYPE zpp_apps03_itb1.
**********************************************************************
    READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
      ENTITY billofmaterial
      EXECUTE explodebom
      FROM VALUE #(
        (
          plant                          = ls_hdr-Werks
          material                       = ls_hdr-Project
          billofmaterialcategory         = 'M'
          %param-bomexplosionapplication = 'PP01'
          %param-requiredquantity        = 1
          %param-explodebomlevelvalue    = 0
          %param-bomexplosionismultilevel = 'X'
        )
      )
      RESULT DATA(lt_result).


    SELECT *
      FROM zpp_apps02_se
      FOR ALL ENTRIES IN @lt_result
      WHERE Material = @lt_result-%param-BillOfMaterialComponent
        AND BillOfMaterialComponent   = @ls_hdr-Sectmat
        AND PlannedOrder IS NOT INITIAL
      INTO TABLE @DATA(lt_table).


**********************************************************************



**********************************************************************
    IF lt_table IS NOT INITIAL.
      SELECT FROM  zpp_apps02_se AS rv
  LEFT JOIN zpp_apps03_pldv AS ztb ON ztb~PlannedOrder = rv~PlannedOrder AND ztb~Material = rv~Material
  FIELDS rv~PlannedOrder,
  rv~bom ,
  rv~BillOfMaterialCategory,
  rv~BillOfMaterialVariant,
  rv~Material,
  rv~Plant,
  rv~SalesOrder,
  rv~SalesOrderItem,
  rv~OrderQuantity,
  rv~OrderQuantityUnit,
  rv~BillOfMaterialItemNodeNumber,
  rv~BOMItemInternalChangeCount,
  rv~ProductDescription,
  rv~yy1_length_mm_prd,
  rv~yy1_width_mm_prd,
  ztb~reqty
  FOR ALL ENTRIES IN @lt_table
  WHERE  rv~Plant  = @lt_table-Plant AND rv~Material = @lt_table-Material
  INTO TABLE @DATA(lt_manu1).
**********************************************************************

      LOOP AT lt_manu1 INTO DATA(ls).
        gs_item-uuid = ls_hdr-Uuid.
        gs_item-plant  = ls-Plant.
        gs_item-orderno = ls-PlannedOrder.
        gs_item-length = ls-yy1_length_mm_prd.

        gs_item-matnr = ls-Material.
        gs_item-maktx = ls-ProductDescription.
        gs_item-plnqty = ls-OrderQuantity.
        gs_item-uom = ls-OrderQuantityUnit.
        gs_item-width = ls-yy1_width_mm_prd.
        gs_item-totreqty = ls-reqty.
        gs_item-totopnqty =    gs_item-plnqty - ls-reqty.
        gs_item-vbeln = ls-SalesOrder.
        gs_item-soitem = ls-SalesOrderItem.
*        gs_item-netwt = gs_item-length * ls_hdr-Unitwet / 1000 * ls-reqty.
        IF gs_item-totopnqty > 0 .
          APPEND gs_item TO zbp_pp_apps03_rv=>gt_item.
        ENDIF.
        CLEAR : gs_item , ls.
      ENDLOOP.
    ENDIF.






*    zbp_pp_apps03_rv=>gt_item  = VALUE #( FOR ls IN lt_table INDEX INTO lv ( uuid = ls_hdr-Uuid
*    orderno = ls-PlannedOrder
**    sno = lv
*    length = ls-yy1_length_mm_prd
*    matnr = ls-Material
*    maktx = ls-ProductDescription
*    plant = ls-Plant
*    width = ls-yy1_width_mm_prd
*    netwt = ''
*    plnqty = ls-OrderQuantity
*    uom = ls-OrderQuantityUnit
*    vbeln = ls-SalesOrder
*    soitem = ls-SalesOrderItem ) ).
**********************************************************************
    result = VALUE #( FOR ls2 IN lt_hdr (  %tky = ls2-%tky
    %param = ls2 ) ).



  ENDMETHOD.

  METHOD gt_data1.
**********************************************************************
    DATA : gs_hdr TYPE zpp_apps03_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
    SELECT  SINGLE FROM zpp_rp01_rv AS rv
    LEFT OUTER JOIN I_BillOfMaterialItemTP_2 AS tp ON tp~BillOfMaterial = rv~bom FIELDS tp~yy1_untwgt_bmi WHERE
    rv~BillOfMaterialComponent = @ls_hdr-Sectmat INTO @DATA(ls_tab).
    gs_hdr-unitwet = ls_tab.
**********************************************************************
    APPEND gs_hdr TO zbp_pp_apps03_rv=>gt_hdr.
  ENDMETHOD.

  METHOD showleng.
**********************************************************************
    READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    ENTITY _hdr BY \_Item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
        READ ENTITIES OF zpp_apps03_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr2).
**********************************************************************

    DATA: lt_grp TYPE STANDARD TABLE OF zpp_apps3_itb3,
          ls_grp TYPE zpp_apps3_itb3.

    LOOP AT lt_item INTO DATA(ls_item)
         GROUP BY ( length = ls_item-Length )
         INTO DATA(ls_group).

      DATA(lv_sum_qty) = 0.

      LOOP AT GROUP ls_group INTO DATA(ls_grp_item).
        lv_sum_qty += ls_grp_item-Reqty.
      ENDLOOP.

      CLEAR ls_grp.
      ls_grp-uuid  = lt_hdr[ 1 ]-Uuid.
      ls_grp-Length = ls_group-length.
      ls_grp-quantity  = lv_sum_qty.

      APPEND ls_grp TO zbp_pp_apps03_rv=>gt_item3.

    ENDLOOP.

    result =  VALUE #(  FOR ls IN lt_hdr2 ( %tky = ls-%tky
    %param = ls ) ).













  ENDMETHOD.

  METHOD print.
**********************************************************************
    READ ENTITIES OF  zpp_apps03_rv IN LOCAL MODE
    ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    ENTITY _Hdr BY \_Item2
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************

    DATA : it_hdr  TYPE TABLE OF zpp_apps03_htb,
           it_item TYPE TABLE OF zpp_apps03_itb2.

    MOVE-CORRESPONDING lt_hdr TO it_hdr.
    MOVE-CORRESPONDING lt_item TO it_item.
**********************************************************************

    zcl_btp_adobe_form=>get_ouath_token(
              EXPORTING
                im_oauth_url    = 'ADS_OAUTH_URL'
                im_client_id    = 'ADS_CLIENTID'
                im_clientsecret = 'ADS_CLIENTSECRET'
              IMPORTING
                ex_token        = DATA(lv_token)
                ex_message      = DATA(lv_message)
            ).
**********************************************************************

    zbp_pp_apps03_rv=>get_pdf_xml(
      EXPORTING
        im_head    = it_hdr
        im_item    = it_item
      IMPORTING
        ex_base_64 = DATA(lv_base64)
    ).
**********************************************************************

    DATA : lv_form_name TYPE string VALUE 'ZCUTTING/YY1_CUTTING_FRM'.

**********************************************************************

    zcl_btp_adobe_form=>get_pdf_api(
      EXPORTING
        im_url           = 'ADS_URL'
        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
        im_client_id     = 'ADS_CLIENTID'
        im_clientsecret  = 'ADS_CLIENTSECRET'
        im_token         = lv_token
        im_base64_encode = lv_base64
        im_xdp_template  = lv_form_name
      IMPORTING
        ex_base64_decode = DATA(lv_base64_decode)
        ex_message       = lv_message
    ).

**********************************************************************
    DATA: gt_formupdate TYPE TABLE OF zpp_apps03_htb,
          gs_formupdate TYPE zpp_apps03_htb.
**********************************************************************


    DATA(gs_formout) =  lt_hdr[ 1 ].

    MOVE-CORRESPONDING gs_formout TO gs_formupdate.

    gs_formupdate-attachmentsul = lv_base64_decode.
    gs_formupdate-filenameul = 'form'.
    gs_formupdate-mimetypeul = 'application/pdf'.

    APPEND gs_formupdate TO gt_formupdate.
    zbp_pp_apps03_rv=>gt_hdr = gt_formupdate.
**********************************************************************
    result = VALUE #( FOR ls_output IN lt_hdr ( %tky = ls_output-%tky
                                                    %param = ls_output ) ).


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS03_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS03_RV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
    IF zbp_pp_apps03_rv=>gt_hdr IS NOT INITIAL.
      MODIFY zpp_apps03_htb FROM TABLE @zbp_pp_apps03_rv=>gt_hdr.
    ENDIF.
**********************************************************************
    IF zbp_pp_apps03_rv=>gt_item IS NOT INITIAL.
      MODIFY zpp_apps03_itb1 FROM TABLE @zbp_pp_apps03_rv=>gt_item.
    ENDIF.
**********************************************************************
    IF zbp_pp_apps03_rv=>gt_item2 IS NOT INITIAL.
      MODIFY zpp_apps03_itb2 FROM TABLE @zbp_pp_apps03_rv=>gt_item2.
    ENDIF.
**********************************************************************
    IF zbp_pp_apps03_rv=>gt_item3 IS NOT INITIAL.
      MODIFY zpp_apps3_itb3 FROM TABLE @zbp_pp_apps03_rv=>gt_item3.
    ENDIF.


    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(ls_del).
        DELETE FROM zpp_apps03_htb WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps03_itb1 WHERE uuid = @ls_del-Uuid.
        DELETE FROM zpp_apps03_itb2 WHERE uuid = @ls_del-Uuid.

      ENDLOOP.


    ENDIF.
    IF delete-_item2 IS NOT INITIAL.
      LOOP AT delete-_item2 INTO DATA(ls_delim).
        DELETE FROM zpp_apps03_itb2 WHERE uuid = @ls_delim-Uuid AND sno = @ls_delim-Sno.
      ENDLOOP.


    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
