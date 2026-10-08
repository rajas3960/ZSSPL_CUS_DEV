CLASS lhc__item2 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _item2 RESULT result.

ENDCLASS.

CLASS lhc__item2 IMPLEMENTATION.

  METHOD get_instance_features.
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

    METHODS Closejob FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~Closejob RESULT result.

    METHODS gtdata1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gtdata1.
    METHODS matval FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~matval RESULT result.

    METHODS salvalje FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~salvalje RESULT result.
    METHODS gtjob1 FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~gtjob1.
    METHODS genjob FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~genjob RESULT result.
*    METHODS earlynumbering_create FOR NUMBERING
*      IMPORTING entities FOR CREATE _hdr.%*

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].

**********************************************************************

    result = VALUE #( ( %tky = ls_hdr-%tky %action-Closejob = COND #( WHEN ls_hdr-Status = 'C'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
                                           %action-Edit = COND #( WHEN ls_hdr-Status = 'C'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
                                            %action-matval = COND #( WHEN ls_hdr-Status = 'C'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
                                            %action-salvalje = COND #( WHEN ls_hdr-Status = 'C'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
                                            %assoc-_Item1  = COND #( WHEN ls_hdr-Status = 'C' OR ls_hdr-Status = 'O'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
                                             %assoc-_Item2  = COND #( WHEN ls_hdr-Status = 'C' OR ls_hdr-Status = 'O'
                                              THEN
                                              if_abap_behv=>fc-o-disabled
                                              ELSE
                                              if_abap_behv=>fc-o-enabled )
     ) ).
**********************************************************************



  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD Closejob.
**********************************************************************
    DATA : gthdr1 TYPE TABLE OF zpp_app03_tb1,
           gshdr1 TYPE zpp_app03_tb1.

    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO gshdr1.
    gshdr1-status = 'C'.

    APPEND gshdr1 TO gthdr1.

    zbp_pp_app03_rv1=>gthcrt = gthdr1.

    result = VALUE #( FOR ls_ord IN lt_hdr
                             (  %tky  = ls_ord-%tky
                              %param = ls_ord ) ).
**********************************************************************


  ENDMETHOD.

  METHOD gtdata1.
**********************************************************************
    DATA : gthdr TYPE TABLE OF zpp_app03_tb1,
           gshdr TYPE zpp_app03_tb1,
           gtitm TYPE TABLE OF zpp_app03_itb1,
           gsitm TYPE zpp_app03_itb1.

    READ ENTITIES OF zpp_app03_rv1
    IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    SELECT SINGLE MAX( Serialno ) AS Serialno FROM zpp_app03_tb1 INTO @DATA(wa_no).
    IF wa_no IS NOT INITIAL.
      gshdr-serialno = wa_no + 1.
      gshdr-jobshtnum = |JB{ gshdr-serialno ALPHA = IN }|.
    ELSE.
      gshdr-serialno = '0000000001'.

      gshdr-jobshtnum = |JB{ gshdr-serialno }|.
    ENDIF.
**********************************************************************
    gshdr-werks = ls_hdr-Werks.

    gshdr-jobdesc = ls_hdr-Jobdesc.
    gshdr-status = 'O'.
    gshdr-createdby = ls_hdr-Createdby.
    gshdr-createdon = ls_hdr-Createdon.
    gshdr-lastchangedby = ls_hdr-Lastchangedby.
    gshdr-lastchangedon = ls_hdr-Lastchangedon.
**********************************************************************
    zbp_pp_app03_rv1=>gs_plant =  gshdr-werks.
    zbp_pp_app03_rv1=>gs_jobsheet = gshdr-jobshtnum.
    APPEND gshdr TO gthdr.
    zbp_pp_app03_rv1=>gthcrt =  gthdr.
**********************************************************************



  ENDMETHOD.



  METHOD matval.
    DATA : gtitm TYPE TABLE OF zpp_app03_itb1,
           gsitm TYPE zpp_app03_itb1.
**********************************************************************
    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE ENTITY _item1
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    DATA(ls_plant) =  lt_hdr[ 1 ]-Werks.
    DATA(ls_job) =  lt_hdr[ 1 ]-Jobshtnum.
    DATA(ls_mat) = keys[ 1 ]-%param-matnr.
**********************************************************************
    IF ls_mat IS NOT INITIAL AND ls_plant IS NOT INITIAL.

      WITH +ztb AS (    SELECT rv~ManufacturingOrder ,rv~material,SUM( tb2~reqty ) AS reqty FROM zpp_app03_ord AS rv
      INNER JOIN zpp_app03_itb2 AS tb2 ON tb2~orderno = rv~ManufacturingOrder AND tb2~matnr = rv~Material
       WHERE  rv~ProductionPlant  = @ls_plant
       AND rv~Material = @ls_mat
       AND
       NOT EXISTS ( SELECT orderno FROM zpp_app03_itb1 AS tb1
       INNER JOIN zpp_app03_tb1 AS tb ON tb~jobshtnum =  tb1~jobshtnum
        WHERE orderno = rv~ManufacturingOrder AND matnr =  rv~Material  AND tb~status <> 'C'  )
        GROUP BY rv~ManufacturingOrder ,rv~material  )

       SELECT FROM  zpp_app03_ord AS rv
       LEFT JOIN +ztb AS ztb ON ztb~ManufacturingOrder = rv~ManufacturingOrder AND ztb~Material = rv~Material
       FIELDS rv~ManufacturingOrder,
       rv~ManufacturingOrderItem ,
       rv~Batch,
       rv~CompanyCode,
       rv~Material,
       rv~ProductionPlant,
       rv~SalesOrder,
       rv~SalesOrderItem,
       rv~MfgOrderItemPlannedTotalQty,
       rv~ProductionUnit,
       rv~ProductType,
       rv~ManufacturingOrderType,
       rv~ProductName,
       rv~StorageLocation,
       rv~Reservation,
       ztb~reqty
       WHERE  rv~ProductionPlant  = @ls_plant AND rv~Material = @ls_mat AND
       NOT EXISTS ( SELECT orderno FROM zpp_app03_itb1 AS tb1
       INNER JOIN zpp_app03_tb1 AS tb ON tb~jobshtnum =  tb1~jobshtnum
       WHERE orderno = rv~ManufacturingOrder AND matnr =  rv~Material  AND tb~status <> 'C' )
       INTO TABLE @DATA(lt_manu).

    ENDIF.



    LOOP AT lt_manu INTO DATA(ls).
      gsitm-jobshtnum = ls_job.
      gsitm-plant  = ls-ProductionPlant.
      gsitm-orderno = ls-ManufacturingOrder.
      gsitm-orderitem = ls-ManufacturingOrderItem.
      gsitm-matnr = ls-Material.
      gsitm-maktx = ls-ProductName.
      gsitm-plnqty = ls-MfgOrderItemPlannedTotalQty.
      gsitm-uom = ls-ProductionUnit.
      gsitm-rsnum = ls-Reservation.
      gsitm-totreqty = ls-reqty.
      gsitm-totopnqty =    gsitm-plnqty - ls-reqty.
      gsitm-vbeln = ls-SalesOrder.
      gsitm-soitem = ls-SalesOrderItem.
      IF gsitm-totopnqty > 0 .
        APPEND gsitm TO gtitm.
      ENDIF.
      CLEAR : gsitm , ls.
    ENDLOOP.
    zbp_pp_app03_rv1=>gticrt = gtitm.

    result = VALUE #( FOR ls_ord IN lt_hdr
                          (  %tky  = ls_ord-%tky
                           %param = ls_ord ) ).




  ENDMETHOD.

  METHOD salvalje.
  ENDMETHOD.

  METHOD gtjob1.
  ENDMETHOD.

  METHOD genjob.

*    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE ENTITY _hdr
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lt_hdr).
*    DATA(LS_HDR) = lt_hdr[ 1 ].
*    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
*    DATA: lv_numb TYPE n LENGTH 10.
*
*         TRY.
*            cl_numberrange_runtime=>number_get( " generating number
*                                                EXPORTING nr_range_nr = '01'
*                                                          object      = 'ZNR_GATE'
*                                                IMPORTING number      = nr_number ).
*            IF nr_number IS NOT INITIAL.
*              lv_numb = nr_number+10(10).
*            ENDIF.
*          CATCH cx_nr_object_not_found.
*          CATCH cx_number_ranges.
*        ENDTRY.
*
*        MODIFY ENTITIES OF zpp_app03_rv1 IN LOCAL MODE
*        ENTITY _hdr UPDATE FIELDS (  Jobshtnum  )
*        WITH VALUE #( ( %tky = LS_HDR-%tky
*                        Jobshtnum = lv_numb ) ).
*
*
*
*
*            result = VALUE #( FOR ls_header IN lt_hdr
*                      ( %tky   = ls_header-%tky
*                        %param = ls_header ) ).

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
    METHODS reqty_val FOR VALIDATE ON SAVE
      IMPORTING keys FOR _item1~reqty_val.

ENDCLASS.

CLASS lhc__item1 IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zpp_app03_rv1  IN LOCAL MODE
    ENTITY _item1
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    result = VALUE #( FOR ls_data IN lt_item
      (   %tky =  ls_data-%tky
  %features-%field-Reqty =  COND #( WHEN ls_data-Totopnqty = 0

                                                  THEN if_abap_behv=>fc-f-read_only

                                                  ELSE if_abap_behv=>fc-f-unrestricted  )
  %action-addmat = COND #( WHEN ls_data-Totopnqty = 0
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

  METHOD addmat.

    DATA : gtitem  TYPE TABLE OF zpp_app03_itb1,
           gsitem  TYPE zpp_app03_itb1,
           gtitem2 TYPE TABLE OF zpp_app03_itb2,
           gsitem2 TYPE zpp_app03_itb2.

    READ ENTITIES OF zpp_app03_rv1
   IN LOCAL MODE ENTITY _item1
     ALL FIELDS WITH CORRESPONDING #( keys )
   RESULT DATA(lt_item1).
    DATA(ls_item1) = lt_item1[ 1 ].
    MOVE-CORRESPONDING ls_item1 TO gsitem.

    SELECT SINGLE SUM( reqty ) AS totqty
    FROM zpp_app03_itb2 WHERE orderno = @ls_item1-Orderno AND matnr = @ls_item1-Matnr INTO @DATA(wa_ord).

    IF wa_ord IS NOT INITIAL.
      gsitem-totreqty = wa_ord + ls_item1-Reqty.
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.
    ELSE.
      gsitem-totreqty = ls_item1-Reqty .
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.

    ENDIF.

    APPEND gsitem TO gtitem.
    SELECT SINGLE MAX( sno ) AS sno FROM zpp_app03_itb2  WHERE jobsheet = @ls_item1-Jobshtnum INTO @DATA(LV_Sno).
    IF gtitem IS NOT INITIAL.
      gtitem2 =  VALUE #( FOR ls IN gtitem INDEX INTO lv  ( jobsheet = ls-jobshtnum
                                                            sno = lv_sno + lv
                                                            matnr =   ls-matnr
                                                            orderno = ls-orderno
                                                            resev = ls-rsnum
                                                            orderitem = ls-orderitem
                                                            reqty = ls-reqty
                                                            uom = ls-uom
                                                            plant = ls-plant
                                                            vbeln = ls-vbeln
                                                            soitem = ls-soitem
                                                            plndqty = ls-plnqty
                                                            maktx = ls-maktx
                                                                                    ) ).

    ENDIF.



    gsitem-reqty = 0.
    APPEND gsitem TO gtitem.


    zbp_pp_app03_rv1=>gtiupt = gtitem.
    zbp_pp_app03_rv1=>gticrt2 = gtitem2.






  ENDMETHOD.

  METHOD matvh.

    READ ENTITIES OF zpp_app03_rv1
    IN LOCAL MODE ENTITY _item1 BY \_hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).


  ENDMETHOD.

  METHOD sovh.
  ENDMETHOD.

  METHOD gtidata1.


    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE
    ENTITY _item1
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
**********************************************************************
    DATA(ls_item) = lt_item[ 1 ].
***********************************************************************
    zbp_pp_app03_rv1=>gtiupt = VALUE #( FOR ls IN lt_item ( jobshtnum = ls-Jobshtnum
                                                            plant = ls-Plant
                                                            orderno = ls-Orderno
                                                            orderitem = ls-Orderitem
                                                            matnr =  ls-Matnr
                                                            maktx = ls-Maktx
                                                            plnqty = ls-Plnqty
                                                            reqty = ls-Reqty
                                                            totreqty = ls-Totreqty
                                                            rsnum = ls-Rsnum
                                                            uom = ls-Uom
                                                            totopnqty = ls-Plnqty - ls-Totreqty
                                                            vbeln = ls-Vbeln
                                                            soitem = ls-Soitem ) ).


  ENDMETHOD.

  METHOD reqty_val.

    READ ENTITIES OF zpp_app03_rv1 IN LOCAL MODE
     ENTITY _item1
    ALL FIELDS WITH CORRESPONDING #( keys  )
    RESULT DATA(lt_item).



*failed-_item1 = VALUE #(
*  FOR ls1 IN lt_item
*  WHERE ( ls1-reqty > ls1-totopnqty )
*  ( %tky = ls1-%tky )
*).





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
*
*failed-_item1 = VALUE #( FOR ls1 IN lt_item   ( %tky = ls1-%tky  %fail  = COND #( WHEN ls1-Reqty > ls1-Totopnqty
*                                                                                then  |Quantity error|
*                                                                                else
*                                                                                |okay|
*
*                                                                                ) ) ) .

    LOOP AT lt_item INTO DATA(ls1).
      IF ls1-Reqty > ls1-Totopnqty.
        APPEND VALUE #( %tky = ls1-%tky  ) TO failed-_item1.
      ENDIF.
    ENDLOOP.





  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APP03_RV1 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APP03_RV1 IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
*    IF create-_hdr IS NOT INITIAL.
    IF zbp_pp_app03_rv1=>gthcrt IS NOT INITIAL.
      MODIFY zpp_app03_tb1 FROM TABLE @zbp_pp_app03_rv1=>gthcrt.
    ENDIF.
*    ENDIF.
**********************************************************************
    IF zbp_pp_app03_rv1=>gticrt IS NOT INITIAL.
      MODIFY zpp_app03_itb1 FROM TABLE @zbp_pp_app03_rv1=>gticrt.
    ENDIF.
    IF zbp_pp_app03_rv1=>gtiupt IS NOT INITIAL.
      MODIFY zpp_app03_itb1 FROM TABLE @zbp_pp_app03_rv1=>gtiupt.
    ENDIF.
    IF zbp_pp_app03_rv1=>gticrt2 IS NOT INITIAL.
      MODIFY zpp_app03_itb2 FROM TABLE @zbp_pp_app03_rv1=>gticrt2.
    ENDIF.
    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(ls_delete).
        DELETE FROM zpp_app03_tb1 WHERE jobshtnum = @ls_delete-Jobshtnum.
        DELETE FROM zpp_app03_itb1 WHERE jobshtnum =  @ls_delete-Jobshtnum.
        DELETE FROM zpp_app03_itb2 WHERE jobsheet =  @ls_delete-Jobshtnum.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
