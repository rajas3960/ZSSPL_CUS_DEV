CLASS lsc_zsd_app_hrv DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.


ENDCLASS.

CLASS lsc_zsd_app_hrv IMPLEMENTATION.


  METHOD save_modified.
*********************************************************************
    IF create-salesheader IS NOT INITIAL.
      IF zbp_sd_app_hrv=>gt_saleshdr IS NOT INITIAL.
        DATA(lt_hdrcrt) = zbp_sd_app_hrv=>gt_saleshdr.
        MODIFY zsd_app_h FROM TABLE @lt_hdrcrt.
      ENDIF.
    ENDIF.
**********************************************************************
    IF zbp_sd_app_hrv=>cv_sal_doc IS NOT INITIAL .
**********************************************************************
      LOOP AT zbp_sd_app_hrv=>cv_sal_doc-salesorder ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
        CONVERT KEY OF I_SalesOrderTP FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
        <fs_pr_mapped>-SalesOrder = ls_pr_key-SalesOrder.
      ENDLOOP.
**********************************************************************
      IF zbp_sd_app_hrv=>gt_salesudp IS NOT INITIAL.
        DATA(lt_hdrupd) = zbp_sd_app_hrv=>gt_salesudp.
        LOOP AT lt_hdrupd ASSIGNING FIELD-SYMBOL(<fs_hdrupd>).
          <fs_hdrupd>-salesorderno = ls_pr_key-SalesOrder.
        ENDLOOP.
        MODIFY zsd_app_h FROM TABLE @lt_hdrupd.
      ENDIF.
**********************************************************************
    ENDIF.

**********************************************************************
*DATA: it_table   TYPE TABLE OF zlc_app_tb,
*      it_lcdata  TYPE TABLE OF zlc_app_tb,
*      lt_lcnums  TYPE TABLE OF string,  " Table to store multiple LC numbers
*      lt_lcamt   TYPE TABLE OF zlc_app_tb-lc_amt, " Table to store corresponding LC amounts
*      wa_hdr     TYPE zsd_app_hrv.      " Header structure
*
** Fetch data from the database table
*SELECT * FROM zlc_app_tb INTO TABLE @it_table.
*zbp_sd_app_hrv=>gt_lcdata = it_table.
*
*DATA(it_hdr) = lt_hdrupd. " Assuming lt_hdrupd contains header data
*
*LOOP AT it_hdr INTO wa_hdr.
*  IF wa_hdr-Lcnumber1 IS NOT INITIAL OR
*     wa_hdr-Lcnumber2 IS NOT INITIAL OR
*     wa_hdr-Lcnumber3 IS NOT INITIAL OR//
*     wa_hdr-Lcnumber4 IS NOT INITIAL OR
*     wa_hdr-Lcnumber5 IS NOT INITIAL OR
*     wa_hdr-Lcnumber6 IS NOT INITIAL OR
*     wa_hdr-Lcnumber7 IS NOT INITIAL OR
*     wa_hdr-Lcnumber8 IS NOT INITIAL OR
*     wa_hdr-Lcnumber9 IS NOT INITIAL OR
*     wa_hdr-Lcnumber10 IS NOT INITIAL.
*
*    CLEAR lt_lcnums.
*    CLEAR lt_lcamt.
*
*    " Collect all LC numbers and their respective amounts dynamically
*    APPEND wa_hdr-Lcnumber1 TO lt_lcnums. APPEND wa_hdr-Lcamount1 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber2 TO lt_lcnums. APPEND wa_hdr-Lcamount2 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber3 TO lt_lcnums. APPEND wa_hdr-Lcamount3 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber4 TO lt_lcnums. APPEND wa_hdr-Lcamount4 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber5 TO lt_lcnums. APPEND wa_hdr-Lcamount5 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber6 TO lt_lcnums. APPEND wa_hdr-Lcamount6 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber7 TO lt_lcnums. APPEND wa_hdr-Lcamount7 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber8 TO lt_lcnums. APPEND wa_hdr-Lcamount8 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber9 TO lt_lcnums. APPEND wa_hdr-Lcamount9 TO lt_lcamt.
*    APPEND wa_hdr-Lcnumber10 TO lt_lcnums. APPEND wa_hdr-Lcamount10 TO lt_lcamt.
*
*    " Remove empty LC numbers and corresponding amounts
*    DELETE lt_lcnums WHERE table_line IS INITIAL.
*    DELETE lt_lcamt WHERE table_line IS INITIAL.
*
*    " Loop through each LC number along with its corresponding amount
*    LOOP AT lt_lcnums INTO DATA(lc_num) INDEX INTO DATA(idx).
*      READ TABLE lt_lcamt INTO DATA(lc_amt) INDEX idx.
*
*      LOOP AT zbp_sd_app_hrv=>gt_lcdata ASSIGNING FIELD-SYMBOL(<fs_lcdata>).
*        IF lc_num = <fs_lcdata>-lnum.
*
*          " Update lc_utilz
*          IF <fs_lcdata>-lc_utilz IS INITIAL.
*            <fs_lcdata>-lc_utilz = lc_amt.
*          ELSE.
*            <fs_lcdata>-lc_utilz = <fs_lcdata>-lc_utilz + lc_amt.
*          ENDIF.
*
*          " Calculate total balance
*          <fs_lcdata>-tot_balance = <fs_lcdata>-lc_amt - <fs_lcdata>-lc_utilz.
*
*        ENDIF.
*        APPEND <fs_lcdata> TO it_lcdata.
*      ENDLOOP.
*    ENDLOOP.
*
*    " Update the database table with modified data
*    MODIFY zlc_app_tb FROM TABLE @it_lcdata.
*  ENDIF.
*ENDLOOP.


**********************************************************************

****************************LC UPDATE******************************************
*   DATA: lt_lcnums TYPE TABLE OF string,
*      lt_lcamt  TYPE TABLE OF zlc_app_tb-lc_amt,
*      it_lcdata TYPE TABLE OF zlc_app_tb,
*      LV_INDEX TYPE SY-tabix.
*
*SELECT * FROM zlc_app_tb INTO TABLE @zbp_sd_app_hrv=>gt_lcdata.
*
*LOOP AT lt_hdrupd INTO DATA(wa_hdr).
*  CLEAR: lt_lcnums, lt_lcamt.
*
*
*  APPEND: wa_hdr-Lcnumber  TO lt_lcnums. APPEND wa_hdr-Lcamount  TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber2 TO lt_lcnums. APPEND wa_hdr-Lcamount2 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber3 TO lt_lcnums. APPEND wa_hdr-Lcamount3 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber4 TO lt_lcnums. APPEND wa_hdr-Lcamount4 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber5 TO lt_lcnums. APPEND wa_hdr-Lcamount5 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber6 TO lt_lcnums. APPEND wa_hdr-Lcamount6 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber7 TO lt_lcnums. APPEND wa_hdr-Lcamount7 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber8 TO lt_lcnums. APPEND wa_hdr-Lcamount8 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber9 TO lt_lcnums. APPEND wa_hdr-Lcamount9 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber10 TO lt_lcnums. APPEND wa_hdr-Lcamount10 TO lt_lcamt.
*
*  DELETE lt_lcnums WHERE table_line IS INITIAL.
*  DELETE lt_lcamt WHERE table_line IS INITIAL.
*
*  IF lt_lcnums IS INITIAL. CONTINUE. ENDIF.
*
*  LOOP AT lt_lcnums INTO DATA(lc_num) .
*  LV_INDEX = SY-tabix.
*
*    READ TABLE lt_lcamt INTO DATA(lc_amt) INDEX lv_index.
*
*    READ TABLE zbp_sd_app_hrv=>gt_lcdata ASSIGNING FIELD-SYMBOL(<fs_lcdata>)
*      WITH KEY lnum = lc_num.
*
*    IF sy-subrc = 0.
*
*      <fs_lcdata>-lc_utilz = <fs_lcdata>-lc_utilz + lc_amt.
*      <fs_lcdata>-tot_balance = <fs_lcdata>-lc_amt - <fs_lcdata>-lc_utilz.
*      APPEND <fs_lcdata> TO it_lcdata.
*    ENDIF.
*  ENDLOOP.
*ENDLOOP.
*
*" Perform Database Update in One Step
*MODIFY zlc_app_tb FROM TABLE @it_lcdata.

**********************************************************************6



  ENDMETHOD.

ENDCLASS.

CLASS lhc_Salesheader DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    "METHODS get_instance_features FOR INSTANCE FEATURES
      "IMPORTING keys REQUEST requested_features FOR Salesheader RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Salesheader RESULT result.

*    METHODS SalesOn FOR MODIFY
*      IMPORTING keys FOR ACTION Salesheader~SalesOn RESULT result.
    METHODS GetData1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR Salesheader~GetData1.
    METHODS Validatelcamt FOR VALIDATE ON SAVE
      IMPORTING keys FOR Salesheader~Validatelcamt.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Salesheader RESULT result.
*   METHODS get_instance_features FOR INSTANCE FEATURES
*     IMPORTING keys REQUEST requested_features FOR Salesheader RESULT result.
*    METHODS GetData2 FOR DETERMINE ON SAVE
*      IMPORTING keys FOR Salesheader~GetData2.

ENDCLASS.

CLASS lhc_Salesheader IMPLEMENTATION.

*  METHOD get_instance_features.
***********************************************************************
*    READ ENTITIES OF zsd_app_hrv IN LOCAL MODE
*    ENTITY Salesheader
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(it_status).
***********************************************************************
*    result = VALUE #( FOR ls_data IN It_status
*          ( %tky =  ls_data-%tky
*            %features-%action-SalesOn = COND #( WHEN ls_data-Salesorderno IS NOT INITIAL
*                                                THEN if_abap_behv=>fc-o-disabled
*                                                ELSE if_abap_behv=>fc-o-enabled   )
*
*              ) ).
***********************************************************************
*
*  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

*  METHOD SalesOn.


*  ENDMETHOD.

  METHOD GetData1.
**********************************************************************
    DATA: lt_hrdcrt TYPE TABLE OF zsd_app_h,
          ls_hrdcrt TYPE zsd_app_h.

    READ ENTITIES OF zsd_app_hrv IN LOCAL MODE
      ENTITY Salesheader
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdrdata).

    LOOP AT lt_hdrdata INTO DATA(ls_hdrdata).
      CLEAR ls_hrdcrt.

      ls_hrdcrt-recguid = ls_hdrdata-Recguid.
      ls_hrdcrt-createdon = ls_hdrdata-Createdon.
      ls_hrdcrt-createdby = ls_hdrdata-Createdby.
      ls_hrdcrt-dist = ls_hdrdata-Dist.
      ls_hrdcrt-div = ls_hdrdata-Div.
      ls_hrdcrt-salesorg = ls_hdrdata-Salesorg.
      ls_hrdcrt-ordertype = ls_hdrdata-Ordertype.
      ls_hrdcrt-soldto = ls_hdrdata-soldto.

      " Assign LC numbers correctly
      ls_hrdcrt-lcnumber  = ls_hdrdata-Lcnumber.
      ls_hrdcrt-lcamount  = ls_hdrdata-Lcamount.
      ls_hrdcrt-lcurr     = ls_hdrdata-Lcurr.

      ls_hrdcrt-lcnumber2 = ls_hdrdata-Lcnumber2.
      ls_hrdcrt-lcamount2 = ls_hdrdata-Lcamount2.
      ls_hrdcrt-lcurr2    = ls_hdrdata-Lcurr2.

      ls_hrdcrt-lcnumber3 = ls_hdrdata-Lcnumber3.
      ls_hrdcrt-lcamount3 = ls_hdrdata-Lcamount3.
      ls_hrdcrt-lcurr3    = ls_hdrdata-Lcurr3.

      ls_hrdcrt-lcnumber4 = ls_hdrdata-Lcnumber4.
      ls_hrdcrt-lcamount4 = ls_hdrdata-Lcamount4.
      ls_hrdcrt-lcurr4    = ls_hdrdata-Lcurr4.

      ls_hrdcrt-lcnumber5 = ls_hdrdata-Lcnumber5.
      ls_hrdcrt-lcamount5 = ls_hdrdata-Lcamount5.
      ls_hrdcrt-lcurr5    = ls_hdrdata-Lcurr5.

      ls_hrdcrt-lcnumber6 = ls_hdrdata-Lcnumber6.
      ls_hrdcrt-lcamount6 = ls_hdrdata-Lcamount6.
      ls_hrdcrt-lcurr6    = ls_hdrdata-Lcurr6.

      ls_hrdcrt-lcnumber7 = ls_hdrdata-Lcnumber7.
      ls_hrdcrt-lcamount7 = ls_hdrdata-Lcamount7.
      ls_hrdcrt-lcurr7    = ls_hdrdata-Lcurr7.

      ls_hrdcrt-lcnumber8 = ls_hdrdata-Lcnumber8.
      ls_hrdcrt-lcamount8 = ls_hdrdata-Lcamount8.
      ls_hrdcrt-lcurr8    = ls_hdrdata-Lcurr8.

      ls_hrdcrt-lcnumber9 = ls_hdrdata-Lcnumber9.
      ls_hrdcrt-lcamount9 = ls_hdrdata-Lcamount9.
      ls_hrdcrt-lcurr9    = ls_hdrdata-Lcurr9.

      ls_hrdcrt-lcnumber10 = ls_hdrdata-Lcnumber10.
      ls_hrdcrt-lcamount10 = ls_hdrdata-Lcamount10.
      ls_hrdcrt-lcurr10    = ls_hdrdata-Lcurr10.

      ls_hrdcrt-lastchangedby = ls_hdrdata-lastchangedby.
      ls_hrdcrt-lastchangedon = ls_hdrdata-lastchangedon.

      " ✅ Append inside the loop
      APPEND ls_hrdcrt TO lt_hrdcrt.
    ENDLOOP.

    zbp_sd_app_hrv=>gt_saleshdr = lt_hrdcrt.

**********************************************************************
*    DATA: it_salesheader TYPE TABLE OF zsd_app_h,
*          wa_salesheader TYPE zsd_app_h.
*
*    READ ENTITIES OF zsd_app_hrv IN LOCAL MODE
*      ENTITY Salesheader ALL FIELDS WITH CORRESPONDING #( keys )
*      RESULT DATA(it_header)
*      ENTITY Salesheader BY \_SalesItem
*      ALL FIELDS WITH CORRESPONDING #( keys )
*      RESULT DATA(it_item).
*
*    DATA(ls_header) = it_header[ 1 ].
*    DATA(lv_soldtoparty) = |{ ls_header-Soldto ALPHA = IN }|.
*
*    IF it_item IS NOT INITIAL.
*      DATA(it_sitem) = it_item.
*
*    ENDIF.
*
*    MODIFY ENTITIES OF i_salesordertp PRIVILEGED
*            ENTITY salesorder
*            CREATE
*            FIELDS ( salesordertype
*                     salesorganization
*                     distributionchannel
*                     organizationdivision
*                     soldtoparty
*                     yy1_lcnumber_1_sdh
*                     yy1_lcnumber_2_sdh
*                     yy1_lcnumber_3_sdh
*                     yy1_lcnumber_4_sdh
*                     yy1_lcnumber_5_sdh
*                      yy1_lcnumber_6_sdh
*                       yy1_lcnumber_7_sdh
*                        yy1_lcnumber_8_sdh
*                         yy1_lcnumber_9_sdh
*                          yy1_lcnumber_10_sdh
*                     yy1_lcamount_1_sdhc
*                     yy1_lcamount_1_sdh
*                     yy1_lcamount_2_sdhc
*                     yy1_lcamount_2_sdh
*                     yy1_lcamount_3_sdhc
*                     yy1_lcamount_3_sdh
*                     yy1_lcamount_4_sdhc
*                     yy1_lcamount_4_sdh
*                     yy1_lcamount_5_sdhc
*                     yy1_lcamount_5_sdh
*                     yy1_lcamount_6_sdhc
*                     yy1_lcamount_6_sdh
*                     yy1_lcamount_7_sdhc
*                     yy1_lcamount_7_sdh
*                     yy1_lcamount_8_sdhc
*                     yy1_lcamount_8_sdh
*                     yy1_lcamount_9_sdhc
*                     yy1_lcamount_9_sdh
*                     yy1_lcamount_10_sdhc
*                     yy1_lcamount_10_sdh
*                      )
*            WITH VALUE #( ( %cid  = 'H001'
*                            %data = VALUE #( salesordertype       = ls_header-Ordertype
*                                             salesorganization    = ls_header-Salesorg
*                                             distributionchannel  = ls_header-Dist
*                                             organizationdivision = ls_header-Div
*                                             soldtoparty          = lv_soldtoparty
*                                             yy1_lcnumber_1_sdh   = ls_header-Lcnumber
*                                             yy1_lcamount_1_sdh = ls_header-Lcamount
*                                             yy1_lcamount_1_sdhc = ls_header-Lcurr
*                                             yy1_lcnumber_2_sdh   = ls_header-Lcnumber2
*                                             yy1_lcamount_2_sdh = ls_header-Lcamount2
*                                              yy1_lcamount_2_sdhc = ls_header-lcurr2
*                                             yy1_lcnumber_3_sdh   = ls_header-Lcnumber3
*                                             yy1_lcamount_3_sdh = ls_header-Lcamount3
*                                             yy1_lcamount_3_sdhc = ls_header-lcurr3
*                                             yy1_lcnumber_4_sdh   = ls_header-Lcnumber4
*                                             yy1_lcamount_4_sdh = ls_header-Lcamount4
*                                             yy1_lcamount_4_sdhc = ls_header-lcurr4
*                                             yy1_lcnumber_5_sdh   = ls_header-Lcnumber5
*                                             yy1_lcamount_5_sdh = ls_header-Lcamount5
*                                             yy1_lcamount_5_sdhc = ls_header-lcurr5
*                                             yy1_lcnumber_6_sdh   = ls_header-Lcnumber6
*                                             yy1_lcamount_6_sdh = ls_header-Lcamount6
*                                             yy1_lcamount_6_sdhc = ls_header-lcurr6
*                                             yy1_lcnumber_7_sdh   = ls_header-Lcnumber7
*                                             yy1_lcamount_7_sdh = ls_header-Lcamount7
*                                             yy1_lcamount_7_sdhc = ls_header-lcurr7
*                                             yy1_lcnumber_8_sdh   = ls_header-Lcnumber8
*                                             yy1_lcamount_8_sdh = ls_header-Lcamount8
*                                             yy1_lcamount_8_sdhc = ls_header-lcurr8
*                                             yy1_lcnumber_9_sdh   = ls_header-Lcnumber9
*                                             yy1_lcamount_9_sdh = ls_header-Lcamount9
*                                             yy1_lcamount_9_sdhc = ls_header-lcurr9
*                                             yy1_lcnumber_10_sdh   = ls_header-Lcnumber10
*                                             yy1_lcamount_10_sdh = ls_header-Lcamount10
*                                             yy1_lcamount_10_sdhc = ls_header-lcurr10
*                                             ) ) )
*            CREATE BY \_item
*            FIELDS ( product
*                     requestedquantity
*                     Plant
*                      )
*            WITH VALUE #( FOR ls_sitem IN it_item ( %cid_ref   = 'H001'
*                            salesorder = space
*                            %target    = VALUE #( ( %cid              = 'I' && ls_sitem-Item
*                                                    product           = ls_sitem-Product
*                                                    requestedquantity = ls_sitem-Requestqnt
*                                                    Plant   = ls_sitem-Plnt
*                                                    NetAmount = ls_sitem-Netamt
*                                                     ) ) ) )
*            ENTITY SalesOrderItem
*            CREATE BY \_ItemPricingElement
*                  FROM VALUE #( FOR ls_sitem IN it_item (  %cid_ref        = 'I' && ls_sitem-Item
*                                   salesorder      = space
*                                   salesorderitem  = space
*                                   %target         =   VALUE #( ( %cid                          = 'ITPRELM' && ls_sitem-Item
*                                                                  conditiontype                 = 'ZPR1'
*                                                                  conditionrateamount           = ls_sitem-Netamt
*                                                                  conditioncurrency             = ls_sitem-Curr
*                                                                  conditionquantity             = 1
*                                                                  %control-conditioncurrency    = if_abap_behv=>mk-on
*                                                                  %control-conditiontype        = if_abap_behv=>mk-on
*                                                                  %control-conditionrateamount  = if_abap_behv=>mk-on
*                                                                  %control-conditionquantity    = if_abap_behv=>mk-on ) ) ) )
*            MAPPED   DATA(ls_mapped)
*            FAILED   DATA(ls_failed)
*            REPORTED DATA(ls_reported).
*
*    IF ls_failed IS INITIAL.
*      zbp_sd_app_hrv=>cv_sal_doc = ls_mapped.
*      MOVE-CORRESPONDING ls_header TO wa_salesheader.
*      APPEND wa_salesheader TO it_salesheader.
*      zbp_sd_app_hrv=>gt_salesudp = it_salesheader.
*
*
*    ELSE.
*
*
*    ENDIF.


*    result = VALUE #( FOR ls_ord IN it_header
*                       ( %tky = ls_ord-%tky
*                         %param = ls_ord ) ).
**********************************************************************

  ENDMETHOD.

*  METHOD GetData2.
*  data : it_table type table of zlc_app_tb.
*select * from zlc_app_tb into table @it_table.
*
*zbp_sd_app_hrv=>gt_lcdata = it_table.
*  ENDMETHOD.

  METHOD Validatelcamt.
*DATA: lt_lcnums TYPE TABLE OF string,
*      lt_lcamt  TYPE TABLE OF zlc_app_tb-lc_amt,
*      LV_INDEX  TYPE SY-TABIX.
*
*SELECT * FROM zlc_app_tb INTO TABLE @zbp_sd_app_hrv=>gt_lcdata.
*
*READ ENTITIES OF zsd_app_hrv IN LOCAL MODE
*  ENTITY Salesheader
*  ALL FIELDS WITH CORRESPONDING #( keys )
*  RESULT DATA(it_hdr).
*
*LOOP AT it_hdr INTO DATA(wa_hdr).
*  CLEAR: lt_lcnums, lt_lcamt.
*
*  " Collect LC Numbers & Amounts dynamically
*  APPEND: wa_hdr-Lcnumber  TO lt_lcnums. APPEND wa_hdr-Lcamount  TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber2 TO lt_lcnums. APPEND wa_hdr-Lcamount2 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber3 TO lt_lcnums. APPEND wa_hdr-Lcamount3 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber4 TO lt_lcnums. APPEND wa_hdr-Lcamount4 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber5 TO lt_lcnums. APPEND wa_hdr-Lcamount5 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber6 TO lt_lcnums. APPEND wa_hdr-Lcamount6 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber7 TO lt_lcnums. APPEND wa_hdr-Lcamount7 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber8 TO lt_lcnums. APPEND wa_hdr-Lcamount8 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber9 TO lt_lcnums. APPEND wa_hdr-Lcamount9 TO lt_lcamt.
*  APPEND: wa_hdr-Lcnumber10 TO lt_lcnums. APPEND wa_hdr-Lcamount10 TO lt_lcamt.
*
*  DELETE lt_lcnums WHERE table_line IS INITIAL.
*  DELETE lt_lcamt WHERE table_line IS INITIAL.
*
*  IF lt_lcnums IS INITIAL.
*    CONTINUE.
*  ENDIF.
*
*  LOOP AT lt_lcnums INTO DATA(lc_num).
*    LV_INDEX = SY-TABIX.
*    READ TABLE lt_lcamt INTO DATA(lc_amt) INDEX LV_INDEX.
*
*    READ TABLE zbp_sd_app_hrv=>gt_lcdata ASSIGNING FIELD-SYMBOL(<fs_lcdata>)
*      WITH KEY lnum = lc_num.
*
*    IF sy-subrc = 0.
*
*      " ✅ Skip validation if both Utilz and Balance are initial
*      IF <fs_lcdata>-lc_utilz IS INITIAL AND <fs_lcdata>-tot_balance IS INITIAL.
*        CONTINUE.
*      ENDIF.
*
*      " Validate LC amount against available balance
*      IF lc_amt > <fs_lcdata>-tot_balance.
*
*        " Capture the field name dynamically
*        DATA(lc_field_name) = |Lcamt{ LV_INDEX }|.
*
*        " Mark the failed key
*        APPEND VALUE #( %tky = wa_hdr-%tky ) TO failed-salesheader.
*
*        " Add validation error message
*        APPEND VALUE #( %tky = keys[ 1 ]-%tky
*          %msg = new_message_with_text(
*              severity = if_abap_behv_message=>severity-error
*              text = |Balance insufficient for { lc_num } Field: { lc_field_name }|
*          ) ) TO reported-salesheader.
*
*        EXIT. " Stop processing if validation fails
*      ENDIF.
*
*    ENDIF.
*  ENDLOOP.
*ENDLOOP.

  ENDMETHOD.
*
*  METHOD get_instance_features.
*  READ ENTITIES OF zsd_app_hrv IN LOCAL MODE
*
*    ENTITY Salesheader
*
*    ALL FIELDS WITH CORRESPONDING #( keys )
*
*    RESULT DATA(it_status).
*
***********************************************************************
*
*    result = VALUE #( FOR ls_data IN It_status
*
*          ( %tky =  ls_data-%tky
*
*            %features-%delete = COND #( WHEN ls_data-Salesorderno IS NOT INITIAL
*
*                                                THEN if_abap_behv=>fc-o-disabled
*
*                                                ELSE if_abap_behv=>fc-o-enabled   )
*              ) ).
*  ENDMETHOD.
*
*
*  ENDMETHOD.

  METHOD get_instance_features.

    READ ENTITIES OF zsd_app_hrv IN LOCAL MODE

    ENTITY Salesheader

    ALL FIELDS WITH CORRESPONDING #( keys )

    RESULT DATA(it_status).

**********************************************************************

    result = VALUE #( FOR ls_data IN It_status

          ( %tky =  ls_data-%tky

            %features-%action-Edit = COND #( WHEN ls_data-Salesorderno IS NOT INITIAL

                                                THEN if_abap_behv=>fc-o-disabled

                                                ELSE if_abap_behv=>fc-o-enabled   )
            %features-%delete = COND #( WHEN ls_data-Salesorderno IS NOT INITIAL

                                                THEN if_abap_behv=>fc-o-disabled

                                                ELSE if_abap_behv=>fc-o-enabled   )
              ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_SalesItem DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesItem RESULT result.

ENDCLASS.

CLASS lhc_SalesItem IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

ENDCLASS.
