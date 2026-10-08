*CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
*  PRIVATE SECTION.
*
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.
*
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.
*
*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.
*    METHODS goodissue FOR MODIFY
*      IMPORTING keys FOR ACTION _hdr~goodissue RESULT result.
*
*ENDCLASS.
*
*CLASS lhc__hdr IMPLEMENTATION.
*
*  METHOD get_instance_features.
*  ENDMETHOD.
*
*  METHOD get_instance_authorizations.
*  ENDMETHOD.
*
*  METHOD get_global_authorizations.
*  ENDMETHOD.
*
*  METHOD goodissue.
*
*
*  tYPES : BEGIN OF TT_MATITEM,
*        PLANT TYPE werks_d,
*        ORDERNO TYPE aufnr,
*        MATNR TYPE MATNR,
*        ORDERITEM TYPE co_posnr,
*        COMQTY TYPE menge_d,
*        resrv type  rsnum,
*        uom type meins,
*END OF TT_MATITEM.
*
*data : it_matitem type table of TT_MATITEM,
*       it_matitemf type table of TT_MATITEM,
*       wa_matitem type TT_MATITEM.
*
*    READ ENTITIES OF zpp_app09_rv IN LOCAL MODE ENTITY
*    _hdr ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_hdr).
*    DATA(ls_hdr) = lt_hdr[ 1 ].
*
*
**
**    SELECT FROM zpp_app03_itb2 FIELDS matnr ,orderno ,plant, uom, SUM( reqty ) AS  reqty
**     WHERE jobsheet = @ls_hdr-Jobshtnum
**     GROUP BY
**     matnr ,orderno ,plant,uom
**      INTO TABLE @DATA(it_item) .
*       SELECT FROM zpp_app03_itb2 FIELDS matnr ,orderno ,plant, uom,  reqty,resev ,orderitem
*     WHERE jobsheet = @ls_hdr-Jobshtnum
**     GROUP BY
**     matnr ,orderno ,plant,uom
*      INTO TABLE @DATA(it_item) .
*    IF it_item IS NOT INITIAL.
*      LOOP AT it_item  ASSIGNING FIELD-SYMBOL(<wa_item>).
*
***********************************************************************
*        READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
*             ENTITY billofmaterial
*             EXECUTE explodebom
*
*               FROM VALUE #(
*                 (
*                   plant          = <wa_item>-plant
*                   material       = <wa_item>-matnr
*                   billofmaterialcategory = 'M'
*                   %param-bomexplosionapplication = 'PP01'
*                   %param-requiredquantity = <wa_item>-reqty
*                   %param-explodebomlevelvalue = 0
*                 )
*               )
*               RESULT  DATA(lt_result)
*               FAILED DATA(ls_failed)
*               REPORTED DATA(ls_reported).
***********************************************************************
*
***********************************************************************
*it_matitem = VALUE #(  BASE it_matitem for ls in lt_result (
*                                    orderno = <wa_item>-orderno
*                                    orderitem = <wa_item>-orderitem
*                                    resrv = <wa_item>-resev
*                                    matnr = ls-%param-BillOfMaterialComponent
*                                    plant = ls-%param-Plant
*                                    uom = <wa_item>-uom
*                                    comqty = ls-%param-ComponentQuantityInCompUoM
*                                    ) ).
**APPEND LINES OF it_matitem to it_matitemf.
*
*
*
*
*
*  ENDLOOP.
*
*
***********************************************************************
**data : lvno type n LENGTH 3.
**lvno = lvno + 1.
*
*        IF it_matitem IS NOT INITIAL.
*
*
*
*             MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
*             ENTITY MaterialDocument
*             CREATE FROM VALUE #( ( %cid                          = 'CID_001'
*                                    goodsmovementcode             = '03'
*                                    postingdate                   = cl_abap_context_info=>get_system_date( )
*                                    documentdate                  = cl_abap_context_info=>get_system_date( )
*                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
*                                    %control-postingdate                          = cl_abap_behv=>flag_changed
*                                    %control-documentdate                         = cl_abap_behv=>flag_changed
*                                ) )
*             ENTITY MaterialDocument
*             CREATE BY \_MaterialDocumentItem
*             FROM VALUE #( FOR ls1 in it_matitem INDEX INTO idx (
*                             %cid_ref = 'CID_001'
*                             %target = VALUE #( ( %cid                           = 'CID_ITM_' && IDX
*                                                  plant                          = ls1-plant
*                                                  material                       = ls1-matnr
*                                                  GoodsMovementType              = '261'
*                                                  storagelocation                = 'RY01'
*                                                  QuantityInEntryUnit            = ls1-comqty
*                                                  entryunit                      = ls1-uom
*                                                  ManufacturingOrder             =  ls1-orderno
*                                                  Reservation                    =  ls1-resrv
*                                                  ReservationItem =  ls1-orderitem
*
*                                                  %control-plant                 = cl_abap_behv=>flag_changed
*                                                  %control-material              = cl_abap_behv=>flag_changed
*                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
*                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
*                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
*                                                  %control-entryunit             = cl_abap_behv=>flag_changed
*                                                  %control-ManufacturingOrder   =  cl_abap_behv=>flag_changed
*                                                  %control-Reservation =  cl_abap_behv=>flag_changed
*                                                  %control-ReservationItem =  cl_abap_behv=>flag_changed
*                                              ) )
*
*
*                         ) )
*             MAPPED   DATA(ls_create_mapped)
*             FAILED   DATA(ls_create_failed)
*             REPORTED DATA(ls_create_reported).
*IF ls_create_failed IS INITIAL.
*zbp_pp_app09_rv=>cv_mat_doc = ls_create_mapped.
*ELSE.
*ENDIF.
*
*
*
*        ELSE.
*
*
*        ENDIF.
*
*
*
*    ENDIF.
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lhc__item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
*  PRIVATE SECTION.
*
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR _item2 RESULT result.
*
*    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*      IMPORTING keys REQUEST requested_authorizations FOR _item2 RESULT result.
*
*    METHODS goodissue FOR MODIFY
*      IMPORTING keys FOR ACTION _item2~goodissue RESULT result.
*
*    METHODS gtidata1 FOR DETERMINE ON SAVE
*      IMPORTING keys FOR _item2~gtidata1.
*
*ENDCLASS.
*
*CLASS lhc__item2 IMPLEMENTATION.
*
*  METHOD get_instance_features.
*  ENDMETHOD.
*
*  METHOD get_instance_authorizations.
*  ENDMETHOD.
*
*  METHOD goodissue.
*  ENDMETHOD.
*
*  METHOD gtidata1.
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lsc_ZPP_APP09_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
*  PROTECTED SECTION.
*
*    METHODS save_modified REDEFINITION.
*
*    METHODS cleanup_finalize REDEFINITION.
*
*ENDCLASS.
*
*CLASS lsc_ZPP_APP09_RV IMPLEMENTATION.
*
*  METHOD save_modified.
*
*  IF zbp_pp_app09_rv=>cv_mat_doc IS NOT INITIAL .
*      LOOP AT zbp_pp_app09_rv=>cv_mat_doc-MaterialDocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
*        CONVERT KEY OF i_materialdocumenttp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
*        <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument .
*      ENDLOOP.
*      ENDIF.
*  ENDMETHOD.
*
*  METHOD cleanup_finalize.
*  ENDMETHOD.
*
*ENDCLASS.



*-----------------------------------------new code--------------------

CLASS lhc__hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _hdr RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR _hdr RESULT result.
    METHODS goodissue FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~goodissue RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD goodissue.


    TYPES : BEGIN OF tt_matitem,
              plant     TYPE werks_d,
              orderno   TYPE aufnr,
              matnr     TYPE matnr,
              orderitem TYPE co_posnr,
              comqty    TYPE menge_d,
              resrv     TYPE  rsnum,
              resno     TYPE co_posnr,
              plnqty    TYPE menge_d,
              uom       TYPE meins,
              batch     TYPE charg_d,
              storg     TYPE lgort_d,
              vbeln     TYPE vbeln_va,
              soitm     TYPE posnr_va,
            END OF tt_matitem.




    DATA : it_matitem  TYPE TABLE OF tt_matitem,
           it_matitemf TYPE TABLE OF tt_matitem,
           wa_matitem  TYPE tt_matitem,
           it_citem    TYPE TABLE OF zpp_app09_itb2,
           wa_citem    TYPE zpp_app09_itb2.




    READ ENTITIES OF zpp_app09_rv IN LOCAL MODE ENTITY
    _hdr ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).


    DATA(ls_hdr) = lt_hdr[ 1 ].


    " --- fetch SFG rows (itb2) and bring planned qty from order table

*    SELECT FROM zpp_app03_itb2 AS itb2
*       LEFT JOIN zpp_app03_ord  AS ord
*         ON ord~ManufacturingOrder = itb2~orderno
*        AND ord~Material           = itb2~matnr
*       FIELDS itb2~matnr,
*              itb2~orderno,
*              itb2~plant,
*              itb2~uom,
*              itb2~reqty,
*              itb2~resev,
*              itb2~orderitem,
*              ord~MfgOrderItemPlannedTotalQty AS plnqty
*      WHERE itb2~jobsheet = @ls_hdr-Jobshtnum
*      INTO TABLE @DATA(it_item).
*    SELECT * FROM zpp_app09_ipv1 WHERE Jobshtnum = @ls_hdr-Jobshtnum INTO TABLE @DATA(it_item).
*
*    IF it_item IS NOT INITIAL.
*      LOOP AT it_item ASSIGNING FIELD-SYMBOL(<wa_item>).
*
***********************************************************************
*        " explode BOM for this SFG
*
*        READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
*              ENTITY billofmaterial
*              EXECUTE explodebom
*                FROM VALUE #(
*                  (
*                    plant                          = <wa_item>-plant
*                    material                       = <wa_item>-matnr
*                    billofmaterialcategory         = 'M'
*                    %param-bomexplosionapplication = 'PP01'
*                    %param-requiredquantity        = <wa_item>-reqty
*                    %param-explodebomlevelvalue    = 0
*                  )
*                )
*                RESULT  DATA(lt_result)
*                FAILED  DATA(ls_failed)
*                REPORTED DATA(ls_reported).
***********************************************************************
*
***********************************************************************
*        LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).
*          SELECT SINGLE IsBatchManagementRequired  FROM I_ProductPlantBasic WHERE Product = @<ls_result>-%param-BillOfMaterialComponent
*          AND  Plant = @<ls_result>-Plant INTO @DATA(isbatchm).
*
*          IF isbatchm = 'X'.
*
*            SELECT FROM I_StockQuantityCurrentValue_2( p_displaycurrency = 'INR' ) AS stck
*              INNER JOIN i_batch AS bt
*                ON bt~Batch = stck~Batch
*               AND bt~Material = stck~Product
*               AND bt~Plant = stck~Plant
*               AND bt~IsSubordinateBatch = 'X'
*              FIELDS
*                stck~Product,
*                stck~MatlWrhsStkQtyInMatlBaseUnit,
*                bt~Plant,
*                bt~Batch,
*                stck~StorageLocation,
*                bt~LastGoodsReceiptDate
*              WHERE stck~ValuationAreaType = 1
*                AND stck~StorageLocation = 'RY01'
*                AND stck~Product = @<ls_result>-%param-BillOfMaterialComponent
*                AND bt~Plant = @<wa_item>-Plant
*                AND ( ( @<wa_item>-Vbeln IS INITIAL OR stck~SDDocument     = @<wa_item>-Vbeln )
*                  AND ( @<wa_item>-Soitem IS INITIAL OR stck~SDDocumentItem = @<wa_item>-Soitem ) )
*              INTO TABLE @DATA(lt_stck).
*            LOOP AT lt_stck INTO DATA(ls_stck) .
*
*
*
*              APPEND VALUE  #(               orderno   = <wa_item>-orderno
*                                             orderitem = <wa_item>-orderitem
*                                             resrv     = <wa_item>-resev
*                                             resno     = <ls_result>-%param-RowIndex
*                                             matnr     = <ls_result>-%param-BillOfMaterialComponent
*                                             plant     = <ls_result>-%param-Plant
*                                             uom       = <wa_item>-uom
*                                             comqty    = <ls_result>-%param-ComponentQuantityInCompUoM
*                                             plnqty    = <wa_item>-Plndqty
*                                             batch     = ls_stck-Batch
*                                             storg  = ls_stck-StorageLocation
*                                             vbeln = <wa_item>-Vbeln
*                                             soitm = <wa_item>-Soitem
*                                              ) TO  it_matitem.
*            ENDLOOP.
*          ELSE.
*
*            APPEND VALUE  #(               orderno   = <wa_item>-orderno
*                                                      orderitem = <wa_item>-orderitem
*                                                      resrv     = <wa_item>-resev
*                                                      resno     = <ls_result>-%param-RowIndex
*                                                      matnr     = <ls_result>-%param-BillOfMaterialComponent
*                                                      plant     = <ls_result>-%param-Plant
*                                                      uom       = <wa_item>-uom
*                                                      comqty    = <ls_result>-%param-ComponentQuantityInCompUoM
*                                                      plnqty    = <wa_item>-Plndqty
*                                                      vbeln = <wa_item>-Vbeln
*                                                      soitm = <wa_item>-Soitem
*                                                       ) TO  it_matitem.
*
*          ENDIF.
*
*
*
**        it_matitem = VALUE #( BASE it_matitem FOR ls IN lt_result (
**                                           orderno   = <wa_item>-orderno
**                                           orderitem = <wa_item>-orderitem
**                                           resrv     = <wa_item>-resev
**                                           resno     = LS-%param-RowIndex
**                                           matnr     = ls-%param-BillOfMaterialComponent
**                                           plant     = ls-%param-Plant
**                                           uom       = <wa_item>-uom
**                                           comqty    = ls-%param-ComponentQuantityInCompUoM
**                                           plnqty    = <wa_item>-Plndqty
**
**                                           ) ).
*
*
*
*
*        ENDLOOP.
*
*      ENDLOOP.
SELECT *
  FROM zpp_app09_ipv1
  WHERE Jobshtnum = @ls_hdr-Jobshtnum
  INTO TABLE @DATA(it_item).

IF it_item IS NOT INITIAL.
  LOOP AT it_item ASSIGNING FIELD-SYMBOL(<wa_item>).

    " Explode BOM for SFG
    READ ENTITIES OF i_billofmaterialtp_2 PRIVILEGED
      ENTITY billofmaterial
      EXECUTE explodebom
        FROM VALUE #(
          (
            plant                          = <wa_item>-plant
            material                       = <wa_item>-matnr
            billofmaterialcategory         = 'M'
            %param-bomexplosionapplication = 'PP01'
            %param-requiredquantity        = <wa_item>-reqty
            %param-explodebomlevelvalue    = 0
          )
        )
        RESULT  DATA(lt_result)
        FAILED  DATA(ls_failed)
        REPORTED DATA(ls_reported).

    IF lt_result IS NOT INITIAL.

      "### Step 1: Get batch management flags for all components
      SELECT Product, Plant, IsBatchManagementRequired
        FROM I_ProductPlantBasic
        FOR ALL ENTRIES IN @lt_result
        WHERE Product = @lt_result-%param-BillOfMaterialComponent
          AND Plant   = @lt_result-%param-Plant
        INTO TABLE @DATA(lt_batch_mng).

      SORT lt_batch_mng BY Product Plant.

      LOOP AT lt_result ASSIGNING FIELD-SYMBOL(<ls_result>).

        READ TABLE lt_batch_mng INTO DATA(ls_batchm)
          WITH KEY Product = <ls_result>-%param-BillOfMaterialComponent
                   Plant   = <ls_result>-%param-Plant
          BINARY SEARCH.

        IF ls_batchm-IsBatchManagementRequired = 'X'.

          "### Step 2: Fetch stock for this component - FIFO order
          SELECT
            stck~Product,
            stck~MatlWrhsStkQtyInMatlBaseUnit AS qty,
            bt~Plant,
            bt~Batch,
            stck~StorageLocation,
            bt~LastGoodsReceiptDate
            FROM I_StockQuantityCurrentValue_2( p_displaycurrency = 'INR' ) AS stck
            INNER JOIN i_batch AS bt
              ON bt~Batch    = stck~Batch
             AND bt~Material = stck~Product
             AND bt~Plant    = stck~Plant
             AND bt~IsSubordinateBatch = 'X'
            WHERE stck~ValuationAreaType = 1
              AND stck~StorageLocation   = 'RY01'
              AND stck~Product           = @<ls_result>-%param-BillOfMaterialComponent
              AND bt~Plant               = @<wa_item>-Plant
              AND ( ( @<wa_item>-Vbeln IS INITIAL OR stck~SDDocument     = @<wa_item>-Vbeln )
                AND ( @<wa_item>-Soitem IS INITIAL OR stck~SDDocumentItem = @<wa_item>-Soitem ) )
            ORDER BY bt~LastGoodsReceiptDate ASCENDING
            INTO TABLE @DATA(lt_stck).

          "### Step 3: FIFO Allocation Logic
          DATA(lv_req_qty) = <ls_result>-%param-ComponentQuantityInCompUoM.

          LOOP AT lt_stck INTO data(ls_stck).
          IF lv_req_qty > 0.

            DATA(lv_alloc_qty) = COND #( WHEN ls_stck-qty >= lv_req_qty
                                         THEN lv_req_qty
                                         ELSE ls_stck-qty ).

            APPEND VALUE #(
              orderno   = <wa_item>-orderno
              orderitem = <wa_item>-orderitem
              resrv     = <wa_item>-resev
              resno     = <ls_result>-%param-RowIndex
              matnr     = <ls_result>-%param-BillOfMaterialComponent
              plant     = <ls_result>-%param-Plant
              uom       = <ls_result>-%param-BillOfMaterialItemUnit
              comqty    = lv_alloc_qty
              plnqty    = <ls_result>-%param-ComponentQuantityInCompUoM
              batch     = ls_stck-Batch
              storg     = ls_stck-StorageLocation
              vbeln     = <wa_item>-Vbeln
              soitm     = <wa_item>-Soitem
            ) TO it_matitem.

            " Reduce requirement
            lv_req_qty = lv_req_qty - lv_alloc_qty.
            ENDIF.

          ENDLOOP.

        ELSE.
          "### Non-batch managed → single line entry
          APPEND VALUE #(
            orderno   = <wa_item>-orderno
            orderitem = <wa_item>-orderitem
            resrv     = <wa_item>-resev
            resno     = <ls_result>-%param-RowIndex
            matnr     = <ls_result>-%param-BillOfMaterialComponent
            plant     = <ls_result>-%param-Plant
            uom       = <ls_result>-%param-BillOfMaterialItemUnit
            comqty    = <ls_result>-%param-ComponentQuantityInCompUoM
            plnqty    = <wa_item>-Plndqty
            vbeln     = <wa_item>-Vbeln
            soitm     = <wa_item>-Soitem
            storg = 'RY01'
          ) TO it_matitem.

        ENDIF.

      ENDLOOP.
    ENDIF.

  ENDLOOP.

      it_citem = VALUE #( FOR ls IN it_matitem INDEX INTO idx ( jobshtnum = ls_hdr-Jobshtnum
                                              btach = ls-batch
                                              comqty = ls-comqty
                                              matnr = ls-matnr
                                              sno = idx
                                              strgloc = ls-storg
                                              werks = ls-plant
                                              uom = LS-uom
                                               ) ).



    ENDIF.
**********************************************************************
*data : lvno type n LENGTH 3.
*lvno = lvno + 1.

    IF it_matitem IS NOT INITIAL.



      MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
      ENTITY MaterialDocument
      CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                             goodsmovementcode             = '03'
                             postingdate                   = cl_abap_context_info=>get_system_date( )
                             documentdate                  = cl_abap_context_info=>get_system_date( )
                             %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                             %control-postingdate                          = cl_abap_behv=>flag_changed
                             %control-documentdate                         = cl_abap_behv=>flag_changed
                         ) )
      ENTITY MaterialDocument
      CREATE BY \_MaterialDocumentItem
      FROM VALUE #( FOR ls1 IN it_matitem INDEX INTO idx (
                      %cid_ref = 'CID_001'
                      %target = VALUE #( ( %cid                           = 'CID_ITM_' && idx
                                           plant                          = ls1-plant
                                           material                       = ls1-matnr
                                           GoodsMovementType              = '261'
                                           storagelocation                = ls1-storg
                                           QuantityInEntryUnit            = ls1-comqty
                                           entryunit                      = ls1-uom
                                           ManufacturingOrder             =  ls1-orderno
                                           Reservation                    =  ls1-resrv
                                           ReservationItem =  ls1-resno
                                           Batch = ls1-batch
                                           SalesOrder = ls1-vbeln
                                           SalesOrderItem = ls1-soitm


                                           %control-plant                 = cl_abap_behv=>flag_changed
                                           %control-material              = cl_abap_behv=>flag_changed
                                           %control-GoodsMovementType     = cl_abap_behv=>flag_changed
                                           %control-storagelocation       = cl_abap_behv=>flag_changed
                                           %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
                                           %control-entryunit             = cl_abap_behv=>flag_changed
                                           %control-ManufacturingOrder   =  cl_abap_behv=>flag_changed
                                           %control-Reservation =  cl_abap_behv=>flag_changed
                                           %control-ReservationItem =  cl_abap_behv=>flag_changed
                                           %control-Batch = cl_abap_behv=>flag_changed
                                           %control-SalesOrder =  cl_abap_behv=>flag_changed
                                           %control-SalesOrderItem = cl_abap_behv=>flag_changed

                                       ) )


                  ) )
      MAPPED   DATA(ls_create_mapped)
      FAILED   DATA(ls_create_failed)
      REPORTED DATA(ls_create_reported).
      IF ls_create_failed IS INITIAL.
        zbp_pp_app09_rv=>cv_mat_doc = ls_create_mapped.
        zbp_pp_app09_rv=>gtitem =  it_citem.
      ELSE.
      ENDIF.

    ENDIF.

    result = VALUE #( FOR ls_ord IN lt_hdr
                             (  %tky  = ls_ord-%tky
                              %param = ls_ord ) ).








  ENDMETHOD.

ENDCLASS.

CLASS lhc__item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item2 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _item2 RESULT result.

    METHODS goodissue FOR MODIFY
      IMPORTING keys FOR ACTION _item2~goodissue RESULT result.

    METHODS gtidata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _item2~gtidata1.

ENDCLASS.

CLASS lhc__item2 IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.


  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD goodissue.
  ENDMETHOD.

  METHOD gtidata1.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP09_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP09_RV IMPLEMENTATION.

  METHOD save_modified.
    IF zbp_pp_app09_rv=>gtitem IS NOT INITIAL.
      MODIFY zpp_app09_itb2 FROM TABLE @zbp_pp_app09_rv=>gtitem.
    ENDIF.

    IF zbp_pp_app09_rv=>cv_mat_doc IS NOT INITIAL .
      LOOP AT zbp_pp_app09_rv=>cv_mat_doc-MaterialDocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF i_materialdocumenttp FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument .
      ENDLOOP.
    ENDIF.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
