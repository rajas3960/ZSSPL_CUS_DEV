CLASS lhc__Hdr DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _Hdr RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _Hdr RESULT result.

    METHODS Updsal FOR MODIFY
      IMPORTING keys FOR ACTION _Hdr~Updsal RESULT result.

    METHODS GetData1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Hdr~GetData1.
    METHODS lc1 FOR VALIDATE ON SAVE
      IMPORTING keys FOR _Hdr~lc1.
    METHODS GetSales FOR DETERMINE ON SAVE
      IMPORTING keys FOR _Hdr~GetSales.
    METHODS lc_1 FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _Hdr~lc_1.

ENDCLASS.

CLASS lhc__Hdr IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zsd_app2_rv IN LOCAL MODE ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(it_hdr).
    DATA lv_mark TYPE c LENGTH 1.
    lv_mark = 'X'.
    DATA(ls_hdr) = it_hdr[ 1 ].
**********************************************************************
    TRY.
        DATA(lv_user) = cl_abap_context_info=>get_user_business_partner_id(  ).
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        DATA(lv_1) = 1.
    ENDTRY.
**********************************************************************
*    IF ls_hdr-SalesDocument IS NOT INITIAL.
*      SELECT SINGLE YY1_mark_SDH FROM I_SalesOrderTP WITH PRIVILEGED ACCESS  WHERE SalesOrder = @ls_hdr-SalesDocument INTO @DATA(wa_mark) .
*      IF wa_mark IS NOT INITIAL.
*        IF lv_user = '9980000010'.
*          lv_mark = ' '.
*        ENDIF.
*      ELSE.
*        lv_mark = ' '.
*      ENDIF.
*    ENDIF.
*
*    result = VALUE #( FOR ls_key IN keys
*  ( %tky =  ls_key-%tky
*
*    %action = VALUE #( Edit = COND #(  WHEN lv_mark IS INITIAL
*                                   THEN if_abap_behv=>fc-o-enabled
*                                   ELSE if_abap_behv=>fc-o-disabled ) ) ) ).



*

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Updsal.
*    READ ENTITIES OF zsd_app2_rv IN LOCAL MODE ENTITY _Hdr
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(it_hdr).
*
*    DATA(ls_hdr) = it_hdr[ 1 ].
*
*    DATA : it_sdhr TYPE TABLE OF zsd_app2_tb,
*           wa_sdhr TYPE zsd_app2_tb.
*
*    MODIFY ENTITIES OF i_salesordertp PRIVILEGED
*      ENTITY salesorder
*        UPDATE
*          FIELDS (
*            yy1_lcnumber_1_sdh yy1_lcnumber_2_sdh yy1_lcnumber_3_sdh yy1_lcnumber_4_sdh yy1_lcnumber_5_sdh
*            yy1_lcnumber_6_sdh yy1_lcnumber_7_sdh yy1_lcnumber_8_sdh yy1_lcnumber_9_sdh yy1_lcnumber_10_sdh
*            yy1_lcamount_1_sdh yy1_lcamount_1_sdhc yy1_lcamount_2_sdh yy1_lcamount_2_sdhc yy1_lcamount_3_sdh
*            yy1_lcamount_3_sdhc yy1_lcamount_5_sdh yy1_lcamount_5_sdhc yy1_lcamount_6_sdh yy1_lcamount_6_sdhc
*            yy1_lcamount_7_sdh yy1_lcamount_7_sdhc yy1_lcamount_8_sdh yy1_lcamount_8_sdhc yy1_lcamount_9_sdh
*            yy1_lcamount_9_sdhc yy1_lcamount_10_sdh yy1_lcamount_10_sdhc
*          )
*          WITH VALUE #( (
*            %key-salesorder          = ls_hdr-SalesDocument
*            yy1_lcnumber_1_sdh       = ls_hdr-yy1_lcnumber_1_sdh
*            yy1_lcnumber_2_sdh       = ls_hdr-yy1_lcnumber_2_sdh
*            yy1_lcnumber_3_sdh       = ls_hdr-yy1_lcnumber_3_sdh
*            yy1_lcnumber_4_sdh       = ls_hdr-yy1_lcnumber_4_sdh
*            yy1_lcnumber_5_sdh       = ls_hdr-yy1_lcnumber_5_sdh
*            yy1_lcnumber_6_sdh       = ls_hdr-yy1_lcnumber_6_sdh
*            yy1_lcnumber_7_sdh       = ls_hdr-yy1_lcnumber_7_sdh
*            yy1_lcnumber_8_sdh       = ls_hdr-yy1_lcnumber_8_sdh
*            yy1_lcnumber_9_sdh       = ls_hdr-yy1_lcnumber_9_sdh
*            yy1_lcnumber_10_sdh      = ls_hdr-yy1_lcnumber_10_sdh
*            yy1_lcamount_1_sdh       = ls_hdr-yy1_lcamount_1_sdh
*            yy1_lcamount_1_sdhc      = ls_hdr-yy1_lcamount_1_sdhc
*            yy1_lcamount_2_sdh       = ls_hdr-yy1_lcamount_2_sdh
*            yy1_lcamount_2_sdhc      = ls_hdr-yy1_lcamount_2_sdhc
*            yy1_lcamount_3_sdh       = ls_hdr-yy1_lcamount_3_sdh
*            yy1_lcamount_3_sdhc      = ls_hdr-yy1_lcamount_3_sdhc
*            yy1_lcamount_5_sdh       = ls_hdr-yy1_lcamount_5_sdh
*            yy1_lcamount_5_sdhc      = ls_hdr-yy1_lcamount_5_sdhc
*            yy1_lcamount_6_sdh       = ls_hdr-yy1_lcamount_6_sdh
*            yy1_lcamount_6_sdhc      = ls_hdr-yy1_lcamount_6_sdhc
*            yy1_lcamount_7_sdh       = ls_hdr-yy1_lcamount_7_sdh
*            yy1_lcamount_7_sdhc      = ls_hdr-yy1_lcamount_7_sdhc
*            yy1_lcamount_8_sdh       = ls_hdr-yy1_lcamount_8_sdh
*            yy1_lcamount_8_sdhc      = ls_hdr-yy1_lcamount_8_sdhc
*            yy1_lcamount_9_sdh       = ls_hdr-yy1_lcamount_9_sdh
*            yy1_lcamount_9_sdhc      = ls_hdr-yy1_lcamount_9_sdhc
*            yy1_lcamount_10_sdh      = ls_hdr-yy1_lcamount_10_sdh
*            yy1_lcamount_10_sdhc     = ls_hdr-yy1_lcamount_10_sdhc
*          ) )
*        FAILED   DATA(ls_failed)
*        REPORTED DATA(ls_reported)
*        MAPPED DATA(ls_mapped).
*    IF ls_failed IS INITIAL.
*      zbp_sd_app2_rv=>cv_sal_doc = ls_mapped.
*        MOVE-CORRESPONDING ls_hdr TO wa_sdhr.
*        wa_sdhr-mark = abap_true.
*      APPEND wa_sdhr TO it_sdhr.
*
*      zbp_sd_app2_rv=>gt_salestb = it_sdhr.
*            APPEND VALUE #( %tky = ls_hdr-%tky
*      %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-information
*                                                              text = 'Please Click On Save Button' )
*                               ) TO reported-_hdr.
*    ELSE.
*    data(ls_fail) = ls_failed-salesorder[ 1 ].
*if ls_fail-%fail-cause = if_abap_behv=>cause-locked.
*      data(lv_salesorder)  = |{ ls_hdr-SalesDocument ALPHA = OUT }|.
*      DATA(lv_text) = |Sales No. { lv_salesorder } is in approval.|.
*      APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr .
*      APPEND VALUE #( %tky = ls_hdr-%tky
*      %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
*                                                              text = lv_text )
*                               ) TO reported-_hdr.
*endif.
*
*    ENDIF.
*
*
*
*
*
*    READ ENTITIES OF i_salesordertp PRIVILEGED
*      ENTITY salesorder
*        FROM VALUE #( ( salesorder = ls_hdr-SalesDocument ) )
*      RESULT   DATA(lt_so_head)
*      REPORTED ls_reported
*      FAILED   ls_failed.
*
*    result = VALUE #( FOR ls_ord IN it_hdr
*                     ( %tky = ls_ord-%tky
*                       %param = ls_ord ) ).


  ENDMETHOD.

  METHOD GetData1.
*  if zbp_sd_app2_rv=>gt_salestb is not INITIAL.
*  data(ls_mark) = zbp_sd_app2_rv=>gt_salestb[ 1 ].
**********************************************************************
    READ ENTITIES OF zsd_app2_rv IN LOCAL MODE ENTITY _Hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    DATA :lt_gtupdr TYPE TABLE OF zsd_app2_tb,
          ls_gtudr  TYPE zsd_app2_tb.
**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO ls_gtudr.
    ls_gtudr-yy1_lcnumber_1_sdh = ls_hdr-yy1_lcnumber_1_sdh.
    ls_gtudr-yy1_lcnumber_2_sdh  = ls_hdr-yy1_lcnumber_2_sdh.
    ls_gtudr-yy1_lcnumber_3_sdh  = ls_hdr-yy1_lcnumber_3_sdh.
    ls_gtudr-yy1_lcnumber_4_sdh  = ls_hdr-yy1_lcnumber_4_sdh.
    ls_gtudr-yy1_lcnumber_5_sdh = ls_hdr-yy1_lcnumber_5_sdh.
    ls_gtudr-yy1_lcnumber_6_sdh = ls_hdr-yy1_lcnumber_6_sdh.
    ls_gtudr-yy1_lcnumber_7_sdh = ls_hdr-yy1_lcnumber_7_sdh.
    ls_gtudr-yy1_lcnumber_8_sdh = ls_hdr-yy1_lcnumber_8_sdh.
    ls_gtudr-yy1_lcnumber_9_sdh = ls_hdr-yy1_lcnumber_9_sdh.
    ls_gtudr-yy1_lcnumber_10_sdh = ls_hdr-yy1_lcnumber_10_sdh.
**********************************************************************
    ls_gtudr-yy1_lcamount_1_sdh = ls_hdr-yy1_lcamount_1_sdh.
    ls_gtudr-yy1_lcamount_1_sdhc = ls_hdr-yy1_lcamount_1_sdhc.

    ls_gtudr-yy1_lcamount_2_sdh = ls_hdr-yy1_lcamount_2_sdh.
    ls_gtudr-yy1_lcamount_2_sdhc = ls_hdr-yy1_lcamount_2_sdhc.

    ls_gtudr-yy1_lcamount_3_sdh = ls_hdr-yy1_lcamount_3_sdh.
    ls_gtudr-yy1_lcamount_3_sdhc = ls_hdr-yy1_lcamount_3_sdhc.

    ls_gtudr-yy1_lcamount_4_sdh = ls_hdr-yy1_lcamount_4_sdh.
    ls_gtudr-yy1_lcamount_4_sdhc = ls_hdr-yy1_lcamount_4_sdhc.

    ls_gtudr-yy1_lcamount_5_sdh = ls_hdr-yy1_lcamount_5_sdh.
    ls_gtudr-yy1_lcamount_5_sdhc = ls_hdr-yy1_lcamount_5_sdhc.

    ls_gtudr-yy1_lcamount_6_sdh = ls_hdr-yy1_lcamount_6_sdh.
    ls_gtudr-yy1_lcamount_6_sdhc = ls_hdr-yy1_lcamount_6_sdhc.

    ls_gtudr-yy1_lcamount_7_sdh = ls_hdr-yy1_lcamount_7_sdh.
    ls_gtudr-yy1_lcamount_7_sdhc = ls_hdr-yy1_lcamount_7_sdhc.

    ls_gtudr-yy1_lcamount_8_sdh = ls_hdr-yy1_lcamount_8_sdh.
    ls_gtudr-yy1_lcamount_8_sdhc = ls_hdr-yy1_lcamount_8_sdhc.

    ls_gtudr-yy1_lcamount_9_sdh = ls_hdr-yy1_lcamount_9_sdh.
    ls_gtudr-yy1_lcamount_9_sdhc = ls_hdr-yy1_lcamount_9_sdhc.

    ls_gtudr-yy1_lcamount_10_sdh = ls_hdr-yy1_lcamount_10_sdh.
    ls_gtudr-yy1_lcamount_10_sdhc = ls_hdr-yy1_lcamount_10_sdhc.

**********************************************************************

    APPEND ls_gtudr TO lt_gtupdr.

    zbp_sd_app2_rv=>gt_update = lt_gtupdr.
**********************************************************************


  ENDMETHOD.

  METHOD lc1.

  ENDMETHOD.

  METHOD GetSales.
*    READ ENTITIES OF zsd_app2_rv IN LOCAL MODE ENTITY _Hdr
*     ALL FIELDS WITH CORRESPONDING #( keys )
*     RESULT DATA(it_hdr).
*
*    DATA(ls_hdr) = it_hdr[ 1 ].
*
*    DATA : it_sdhr TYPE TABLE OF zsd_app2_tb,
*           wa_sdhr TYPE zsd_app2_tb.
*
*    MODIFY ENTITIES OF i_salesordertp PRIVILEGED
*      ENTITY salesorder
*        UPDATE
*          FIELDS (
*            yy1_lcnumber_1_sdh yy1_lcnumber_2_sdh yy1_lcnumber_3_sdh yy1_lcnumber_4_sdh yy1_lcnumber_5_sdh
*            yy1_lcnumber_6_sdh yy1_lcnumber_7_sdh yy1_lcnumber_8_sdh yy1_lcnumber_9_sdh yy1_lcnumber_10_sdh
*            yy1_lcamount_1_sdh yy1_lcamount_1_sdhc yy1_lcamount_2_sdh yy1_lcamount_2_sdhc yy1_lcamount_3_sdh
*            yy1_lcamount_3_sdhc yy1_lcamount_5_sdh yy1_lcamount_5_sdhc yy1_lcamount_6_sdh yy1_lcamount_6_sdhc
*            yy1_lcamount_7_sdh yy1_lcamount_7_sdhc yy1_lcamount_8_sdh yy1_lcamount_8_sdhc yy1_lcamount_9_sdh
*            yy1_lcamount_9_sdhc yy1_lcamount_10_sdh yy1_lcamount_10_sdhc YY1_mark_SDH
*          )
*          WITH VALUE #( (
*            %key-salesorder          = ls_hdr-SalesDocument
*            yy1_lcnumber_1_sdh       = ls_hdr-yy1_lcnumber_1_sdh
*            yy1_lcnumber_2_sdh       = ls_hdr-yy1_lcnumber_2_sdh
*            yy1_lcnumber_3_sdh       = ls_hdr-yy1_lcnumber_3_sdh
*            yy1_lcnumber_4_sdh       = ls_hdr-yy1_lcnumber_4_sdh
*            yy1_lcnumber_5_sdh       = ls_hdr-yy1_lcnumber_5_sdh
*            yy1_lcnumber_6_sdh       = ls_hdr-yy1_lcnumber_6_sdh
*            yy1_lcnumber_7_sdh       = ls_hdr-yy1_lcnumber_7_sdh
*            yy1_lcnumber_8_sdh       = ls_hdr-yy1_lcnumber_8_sdh
*            yy1_lcnumber_9_sdh       = ls_hdr-yy1_lcnumber_9_sdh
*            yy1_lcnumber_10_sdh      = ls_hdr-yy1_lcnumber_10_sdh
*            yy1_lcamount_1_sdh       = ls_hdr-yy1_lcamount_1_sdh
*            yy1_lcamount_1_sdhc      = ls_hdr-yy1_lcamount_1_sdhc
*            yy1_lcamount_2_sdh       = ls_hdr-yy1_lcamount_2_sdh
*            yy1_lcamount_2_sdhc      = ls_hdr-yy1_lcamount_2_sdhc
*            yy1_lcamount_3_sdh       = ls_hdr-yy1_lcamount_3_sdh
*            yy1_lcamount_3_sdhc      = ls_hdr-yy1_lcamount_3_sdhc
*            yy1_lcamount_5_sdh       = ls_hdr-yy1_lcamount_5_sdh
*            yy1_lcamount_5_sdhc      = ls_hdr-yy1_lcamount_5_sdhc
*            yy1_lcamount_6_sdh       = ls_hdr-yy1_lcamount_6_sdh
*            yy1_lcamount_6_sdhc      = ls_hdr-yy1_lcamount_6_sdhc
*            yy1_lcamount_7_sdh       = ls_hdr-yy1_lcamount_7_sdh
*            yy1_lcamount_7_sdhc      = ls_hdr-yy1_lcamount_7_sdhc
*            yy1_lcamount_8_sdh       = ls_hdr-yy1_lcamount_8_sdh
*            yy1_lcamount_8_sdhc      = ls_hdr-yy1_lcamount_8_sdhc
*            yy1_lcamount_9_sdh       = ls_hdr-yy1_lcamount_9_sdh
*            yy1_lcamount_9_sdhc      = ls_hdr-yy1_lcamount_9_sdhc
*            yy1_lcamount_10_sdh      = ls_hdr-yy1_lcamount_10_sdh
*            yy1_lcamount_10_sdhc     = ls_hdr-yy1_lcamount_10_sdhc
*            YY1_mark_SDH             = 'X'
*          ) )
*        FAILED   DATA(ls_failed)
*        REPORTED DATA(ls_reported)
*        MAPPED DATA(ls_mapped).
*    IF ls_failed IS INITIAL.
*      zbp_sd_app2_rv=>cv_sal_doc = ls_mapped.
*      MOVE-CORRESPONDING ls_hdr TO wa_sdhr.
**        wa_sdhr-mark = abap_true.
*      APPEND wa_sdhr TO it_sdhr.
*      zbp_sd_app2_rv=>gt_salestb = it_sdhr.
*********************************************************
*      DATA : gt_lctb TYPE TABLE OF zlc_app_tb.
*      DATA : gt_lctb1 TYPE TABLE OF zlc_app_tb.
*      FIELD-SYMBOLS <ls_lctb> TYPE zlc_app_tb.
***********************************************************************
*
*
*       SELECT * FROM zlc_app_tb
*       WHERE lnum = @ls_hdr-yy1_lcnumber_1_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_2_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_3_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_4_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_5_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_6_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_7_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_8_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_9_sdh
*       OR lnum = @ls_hdr-yy1_lcnumber_10_sdh
*       INTO TABLE @gt_lctb .
*
***********************************************************************
*      SELECT SINGLE yy1_lcnumber_1_sdh,yy1_lcnumber_2_sdh,yy1_lcnumber_3_sdh,yy1_lcnumber_5_sdh,
*      yy1_lcnumber_6_sdh,yy1_lcnumber_7_sdh,yy1_lcnumber_8_sdh,yy1_lcnumber_9_sdh,yy1_lcnumber_10_sdh
*      ,yy1_lcnumber_4_sdh FROM I_SalesDocument WITH PRIVILEGED ACCESS
*      WHERE SalesDocument = @ls_hdr-SalesDocument
*      INTO @DATA(ls_old) .
***********************************************************************
*      SELECT * FROM zlc_app_tb
*         WHERE lnum = @ls_old-yy1_lcnumber_1_sdh
*         OR lnum = @ls_old-yy1_lcnumber_2_sdh
*         OR lnum = @ls_old-yy1_lcnumber_3_sdh
*         OR lnum = @ls_old-yy1_lcnumber_4_sdh
*         OR lnum = @ls_old-yy1_lcnumber_5_sdh
*         OR lnum = @ls_old-yy1_lcnumber_6_sdh
*         OR lnum = @ls_old-yy1_lcnumber_7_sdh
*         OR lnum = @ls_old-yy1_lcnumber_8_sdh
*         OR lnum = @ls_old-yy1_lcnumber_9_sdh
*         OR lnum = @ls_old-yy1_lcnumber_10_sdh
*         INTO TABLE @gt_lctb1 .
*
***********************************************************************
**
***IF gt_lctb IS NOT INITIAL.
**      IF ls_hdr-yy1_lcnumber_1_sdh IS NOT INITIAL.
**        IF ls_hdr-yy1_lcnumber_1_sdh NE ls_old-yy1_lcnumber_1_sdh AND ls_old-yy1_lcnumber_1_sdh IS NOT INITIAL.
**          READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_1_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_1_sdh  .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            APPEND <ls_lctb> TO gt_lctb.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**          READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_1_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_1_sdh  .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**        ELSE.
**          READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_1_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_1_sdh - ls_old-yy1_lcamount_1_sdh .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_1_sdh IS INITIAL AND ls_old-yy1_lcnumber_1_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_1_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_1_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_2_sdh IS NOT INITIAL.
**        IF ls_hdr-yy1_lcnumber_2_sdh NE ls_old-yy1_lcnumber_2_sdh AND ls_old-yy1_lcnumber_2_sdh IS NOT INITIAL.
**          READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_2_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_2_sdh .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            APPEND <ls_lctb> TO gt_lctb.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**          READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_2_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_2_sdh  .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**        ELSE.
**          READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_2_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_2_sdh - ls_old-yy1_lcamount_2_sdh.
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_2_sdh IS INITIAL AND ls_old-yy1_lcnumber_2_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_2_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_2_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_3_sdh IS NOT INITIAL.
**       IF ls_hdr-yy1_lcnumber_3_sdh NE ls_old-yy1_lcnumber_2_sdh AND ls_old-yy1_lcnumber_2_sdh IS NOT INITIAL.
**          READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_2_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcnumber_2_sdh  .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            APPEND <ls_lctb> TO gt_lctb.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**          READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_2_sdh.
**          IF <ls_lctb> IS ASSIGNED.
**            <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcnumber_2_sdh  .
**            <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**            UNASSIGN <ls_lctb>.
**          ENDIF.
**        ELSE.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_3_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_3_sdh - ls_old-yy1_lcamount_3_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_3_sdh IS INITIAL AND ls_old-yy1_lcnumber_3_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_3_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_3_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_4_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_4_sdh .
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_4_sdh - ls_old-yy1_lcamount_4_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_4_sdh IS INITIAL AND ls_old-yy1_lcnumber_4_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_4_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_4_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_5_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_5_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_5_sdh - ls_old-yy1_lcamount_5_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_5_sdh IS INITIAL AND ls_old-yy1_lcnumber_5_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_5_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_5_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_6_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_6_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_6_sdh - ls_old-yy1_lcamount_6_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_6_sdh IS INITIAL AND ls_old-yy1_lcnumber_6_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_6_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_6_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_7_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_7_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_7_sdh - ls_old-yy1_lcamount_7_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_7_sdh IS INITIAL AND ls_old-yy1_lcnumber_7_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_7_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_7_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_8_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_8_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_8_sdh - ls_old-yy1_lcamount_8_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_8_sdh IS INITIAL AND ls_old-yy1_lcnumber_8_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_8_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_8_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_9_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_9_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_9_sdh - ls_old-yy1_lcamount_9_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_9_sdh IS INITIAL AND ls_old-yy1_lcnumber_9_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_9_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_9_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ENDIF.
************************************************************************
**      IF ls_hdr-yy1_lcnumber_10_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = ls_hdr-yy1_lcnumber_10_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + ls_hdr-yy1_lcamount_10_sdh - ls_old-yy1_lcamount_10_sdh.
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          UNASSIGN <ls_lctb>.
**        ENDIF.
**      ELSEIF ls_hdr-yy1_lcnumber_10_sdh IS INITIAL AND ls_old-yy1_lcnumber_10_sdh IS NOT INITIAL.
**        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = ls_old-yy1_lcnumber_10_sdh.
**        IF <ls_lctb> IS ASSIGNED.
**          <ls_lctb>-lc_utilz  = <ls_lctb>-lc_utilz - ls_old-yy1_lcamount_6_sdh  .
**          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
**          APPEND <ls_lctb> TO gt_lctb.
**          UNASSIGN <ls_lctb>.
**
**        ENDIF.
**      ENDIF.
***********************************************************************
*
*DO 10 TIMES.
*  DATA(lv_idx) = sy-index.
*
*  FIELD-SYMBOLS:
*    <lv_lcnum_new>    TYPE any,
*    <lv_lcnum_old>    TYPE any,
*    <lv_lcamt_new>    TYPE any,
*    <lv_lcamt_old>    TYPE any.
*
*  " Build dynamic component names
*  DATA(lv_comp_lcnum) = |yy1_lcnumber_{ lv_idx }_sdh|.
*  DATA(lv_comp_lcamt) = |yy1_lcamount_{ lv_idx }_sdh|.
*
*  " Assign new and old LC numbers and amounts
*  ASSIGN COMPONENT lv_comp_lcnum OF STRUCTURE ls_hdr TO <lv_lcnum_new>.
*  ASSIGN COMPONENT lv_comp_lcnum OF STRUCTURE ls_old TO <lv_lcnum_old>.
*  ASSIGN COMPONENT lv_comp_lcamt OF STRUCTURE ls_hdr TO <lv_lcamt_new>.
*  ASSIGN COMPONENT lv_comp_lcamt OF STRUCTURE ls_old TO <lv_lcamt_old>.
*
*  IF <lv_lcnum_new> IS ASSIGNED AND <lv_lcnum_old> IS ASSIGNED AND
*     <lv_lcamt_new> IS ASSIGNED AND <lv_lcamt_old> IS ASSIGNED.
*
*    " Case: New LC number is present
*    IF <lv_lcnum_new> IS NOT INITIAL.
*      " Case: LC number changed
*      IF <lv_lcnum_new> NE <lv_lcnum_old> AND <lv_lcnum_old> IS NOT INITIAL.
*
*        READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = <lv_lcnum_old>.
*        IF <ls_lctb> IS ASSIGNED.
*          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz - <lv_lcamt_old>.
*          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
*          APPEND <ls_lctb> TO gt_lctb.
*          UNASSIGN <ls_lctb>.
*        ENDIF.
*
*        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = <lv_lcnum_new>.
*        IF <ls_lctb> IS ASSIGNED.
*          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + <lv_lcamt_new>.
*          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
*          UNASSIGN <ls_lctb>.
*        ENDIF.
*
*      " Case: LC number same, amount changed
*      ELSE.
*        READ TABLE gt_lctb ASSIGNING <ls_lctb> WITH KEY lnum = <lv_lcnum_new>.
*        IF <ls_lctb> IS ASSIGNED.
*          <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz + <lv_lcamt_new> - <lv_lcamt_old>.
*          <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
*          UNASSIGN <ls_lctb>.
*        ENDIF.
*      ENDIF.
*
*    " Case: New LC number is cleared, subtract old amount
*    ELSEIF <lv_lcnum_old> IS NOT INITIAL.
*      READ TABLE gt_lctb1 ASSIGNING <ls_lctb> WITH KEY lnum = <lv_lcnum_old>.
*      IF <ls_lctb> IS ASSIGNED.
*        <ls_lctb>-lc_utilz = <ls_lctb>-lc_utilz - <lv_lcamt_old>.
*        <ls_lctb>-tot_balance = <ls_lctb>-lc_amt - <ls_lctb>-lc_utilz.
*        APPEND <ls_lctb> TO gt_lctb.
*        UNASSIGN <ls_lctb>.
*      ENDIF.
*    ENDIF.
*
*  ENDIF.
*
*ENDDO.
*
***********************************************************************
*      zbp_sd_app2_rv=>gt_lctb = gt_lctb.
*      FREE gt_lctb.
**ENDIF.
**************************************************************************************************
*
*    ELSE.
*      DATA(ls_fail) = ls_failed-salesorder[ 1 ].
*      IF ls_fail-%fail-cause = if_abap_behv=>cause-locked.
*        DATA(lv_salesorder)  = |{ ls_hdr-SalesDocument ALPHA = OUT }|.
*        DATA(lv_text) = |Sales No. { lv_salesorder } is in approval.|.
**      APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr .
*        APPEND VALUE #( %tky = ls_hdr-%tky
*        %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-error
*                                                                text = lv_text )
*                                 ) TO reported-_hdr.
*      ENDIF.
*
*    ENDIF.
  ENDMETHOD.
*
  METHOD lc_1.
*    READ ENTITIES OF zsd_app2_rv IN LOCAL MODE ENTITY _Hdr
*    FIELDS ( yy1_lcnumber_1_sdh  yy1_lcamount_1_sdh ) WITH CORRESPONDING #( keys )
*    RESULT DATA(it_hdr).
*    DATA(ls_hdr) = it_hdr[ 1 ].
*    DATA: lv_lc_total_amount TYPE p LENGTH 16 DECIMALS 2.
*    lv_lc_total_amount =
*     ls_hdr-yy1_lcamount_1_sdh + ls_hdr-yy1_lcamount_2_sdh + ls_hdr-yy1_lcamount_3_sdh  + ls_hdr-yy1_lcamount_4_sdh  + ls_hdr-yy1_lcamount_5_sdh  +
*       ls_hdr-yy1_lcamount_6_sdh  +
*       ls_hdr-yy1_lcamount_7_sdh  +
*       ls_hdr-yy1_lcamount_8_sdh  +
*       ls_hdr-yy1_lcamount_9_sdh +
*       ls_hdr-yy1_lcamount_10_sdh .
*
*    IF   lv_lc_total_amount > ls_hdr-TotalNetAmount.
*      APPEND VALUE #( %tky = ls_hdr-%tky
*      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
*      text = |So Amt { ls_hdr-TotalNetAmount } LC amt { lv_lc_total_amount }| ) ) TO reported-_hdr.
*    ENDIF.
*
*    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZSD_APP2_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZSD_APP2_RV IMPLEMENTATION.

  METHOD save_modified.

*    IF update-_hdr IS NOT INITIAL.
*      IF zbp_sd_app2_rv=>gt_update IS NOT INITIAL.
*        DATA(lt_hdrcrt) = zbp_sd_app2_rv=>gt_update.
*        MODIFY zsd_app2_tb FROM TABLE @lt_hdrcrt.
*      ENDIF.
*    ENDIF.
*
*    IF zbp_sd_app2_rv=>gt_lctb IS NOT INITIAL.
*      MODIFY zlc_app_tb FROM TABLE @zbp_sd_app2_rv=>gt_lctb.
*      FREE zbp_sd_app2_rv=>gt_lctb.
*    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
