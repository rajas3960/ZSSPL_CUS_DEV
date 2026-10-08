CLASS lhc__item2mar DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS gt_del FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _itemftmark~gt_del.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _itemftmark RESULT result.

    METHODS deletes FOR MODIFY
      IMPORTING keys FOR ACTION _itemftmark~deletes RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _itemftmark RESULT result.

ENDCLASS.

CLASS lhc__item2mar IMPLEMENTATION.

  METHOD gt_del.


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD deletes.
**********************************************************************
    DATA : qtyent TYPE menge_d.
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_itemF).
**********************************************************************
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1).
**********************************************************************
**********************************************************************

    READ ENTITY IN LOCAL MODE zpp_apps05_rv ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

**********************************************************************
**********************************************************************

    IF lt_hdr IS NOT INITIAL.
      DATA(ls_qty) = lt_hdr[ 1 ]-Totwithmk.
    ENDIF.
**********************************************************************
**********************************************************************

    DATA(ls_item1) = lt_item1[ 1 ].

**********************************************************************
**********************************************************************

    DATA(ls_itemF) = VALUE #(
    lt_itemF[ KEY entity
              Uuid       = ls_item1-Uuid
              Orderno    = ls_item1-Orderno ] OPTIONAL ).

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _itemgtmark
    UPDATE FROM VALUE #( ( Uuid = ls_item1-Uuid
    Orderno = ls_item1-Orderno
    %is_draft = ls_item1-%is_draft
      totopnqty = ls_itemf-Totopnqty + ls_item1-Reqty
      totreqty = ls_itemf-Totreqty - ls_item1-Reqty
      Reqty = ls_itemf-Totopnqty + ls_item1-Reqty
      %control-Totopnqty = if_abap_behv=>mk-on
      %control-Totreqty = if_abap_behv=>mk-on
      %control-Reqty = if_abap_behv=>mk-on  ) )
      MAPPED DATA(lt_mapped)
      FAILED DATA(lt_faields)
      REPORTED DATA(lt_reportd).

**********************************************************************
**********************************************************************

*********************************************************************
    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE ENTITY _itemftmark
    DELETE FROM VALUE #( FOR ls_del IN keys ( %key = ls_del-%key
    %is_draft = ls_del-%is_draft

      ) ) MAPPED DATA(lt_mpdel)
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_report).

    qtyent = ls_qty - ls_item1-Netwt.

**********************************************************************
**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    UPDATE FROM VALUE #( ( Uuid = ls_item1-Uuid
    %is_draft = ls_item1-%is_draft
    Totwithmk = qtyent
    %control-Totwithmk = if_abap_behv=>mk-on ) )
    MAPPED DATA(ls_mapped1)
    FAILED DATA(ls_failed1)
    REPORTED DATA(ls_reported1).

**********************************************************************
**********************************************************************

  ENDMETHOD.

  METHOD get_instance_features.
**********************************************************************
**********************************************************************

    READ ENTITIES OF zpp_apps05_rv  IN LOCAL MODE ENTITY _itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_item).

**********************************************************************
**********************************************************************

    READ ENTITY IN LOCAL MODE zpp_apps05_rv BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_rsult).

**********************************************************************
**********************************************************************

    result              =   VALUE #( FOR ls_item IN lt_item
                                   ( %tky = ls_item-%tky

    %action-deletes =       COND #( WHEN lt_rsult IS INITIAL
                                    THEN
                                    if_abap_behv=>fc-o-enabled
                                    ELSE
                                    if_abap_behv=>fc-o-disabled  ) ) ).
**********************************************************************
  ENDMETHOD.

ENDCLASS.

CLASS lhc__item5s DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _itemftstock RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _itemftstock RESULT result.

    METHODS Gtselc FOR MODIFY
      IMPORTING keys FOR ACTION _itemftstock~Gtselc RESULT result.
    METHODS gt_itmrqty FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _itemftstock~gt_itmrqty.

ENDCLASS.

CLASS lhc__item5s IMPLEMENTATION.

  METHOD get_instance_features.

**********************************************************************

    READ ENTITIES OF zpp_apps05_rv  IN LOCAL MODE ENTITY _itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_item).


    READ ENTITY IN LOCAL MODE zpp_apps05_rv
    BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_rsult).

**********************************************************************

    result              = VALUE #( FOR ls_item IN lt_item
                                 ( %tky = ls_item-%tky

    %action-Gtselc      = COND #( WHEN ls_item-Mark IS INITIAL AND lt_rsult IS INITIAL AND ( ls_item-Rquantity <= ls_item-Aquatity OR ls_item-Rquantity <> 0 )
                                  THEN
                                  if_abap_behv=>fc-o-enabled
                                  ELSE
                                  if_abap_behv=>fc-o-disabled )

 %features-%field-Rpiecs = COND #( WHEN ls_item-Mark IS INITIAL
                                   THEN
                                   if_abap_behv=>fc-f-unrestricted
                                   ELSE
                                   if_abap_behv=>fc-f-read_only
                                                            )
                                                             ) ).

**********************************************************************




  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD Gtselc.
**********************************************************************
    DATA : gt_item4  TYPE TABLE FOR CREATE zpp_apps05_rv\_itemgtstock,
           gt_item8  TYPE TABLE FOR CREATE zpp_apps05_rv\_itemsumry,
           lv_totwt1 TYPE menge_d.

    READ ENTITIES OF zpp_apps05_rv
    IN LOCAL MODE ENTITY _itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1).

    READ ENTITY IN LOCAL MODE zpp_apps05_rv
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

**********************************************************************
    DATA(ls_item1) = VALUE #( lt_item1[ 1 ] OPTIONAL ).
    DATA(ls_HDR) = VALUE #( lt_hdr[ 1 ] OPTIONAL ).
**********************************************************************
    SELECT SINGLE FROM zpp_apps05_htb
    FIELDS
    vrno
    WHERE
    uuid = @ls_item1-Uuid
    INTO @DATA(ls_vrno).
**********************************************************************
    IF ls_item1 IS NOT INITIAL.
      SELECT SINGLE MAX( sno ) AS sno FROM zpp_apps05_Ditb4
      WHERE uuid = @ls_item1-Uuid INTO @DATA(ls_sno).
    ENDIF.

**********************************************************************

    zbp_pp_apps05_rv=>gt_item4 = VALUE #(  FOR ls IN lt_item1 INDEX INTO lv
                                 WHERE  ( Mark IS INITIAL   )
                                        ( uuid     = ls-uuid
                                          sno      = lv + ls_sno
                                          length   = ls-Length
                                          quantity = COND #( WHEN ls_hdr-Vrcuting = 'CI'
                                                             THEN
                                                             ls-Apiecs
                                                             ELSE
                                                             ls-Rpiecs )
                                          quanwt   = COND #( WHEN ls_hdr-Vrcuting = 'CI'
                                                              THEN
                                                              ls-Aquatity
                                                              ELSE
                                                              ls-Rquantity )

                                          irno = condense( |{ ls-Irno }/{ ls-Batch } { cl_abap_char_utilities=>newline } { ls-Supp }|  )
                                          vrno = ls_vrno
                                          batch = ls-Batch
                                          plant = ls-Plant
                                          matnr = ls-Product
                                          matnoitno = condense( |{ ls-Materialdoc }{ ls-Matdocitm }| )
                                          storagelocation = ls-Storagelocation  ) ).

    gt_item4                    = VALUE #( ( %cid_ref = keys[ 1 ]-%cid_ref
                                             %is_draft = keys[ 1 ]-%is_draft
                                             Uuid = keys[ 1 ]-Uuid
    %target                     = VALUE #( FOR ls2 IN zbp_pp_apps05_rv=>gt_item4
                                            ( %cid = keys[ 1 ]-%cid_ref
                                              %is_draft = keys[ 1 ]-%is_draft
    %data                       = VALUE #( Uuid     = keys[ 1 ]-Uuid
                                           Sno      = ls2-sno
                                           Irno     = ls2-irno
                                           Length   = ls2-length
                                           Quantity = ls2-quantity
                                           Quanwt   =  ls2-quanwt
                                           Batch    = ls2-batch
                                           Plant    = ls2-plant
                                           Matnr    = ls2-matnr
                                           matnoitno = ls2-matnoitno
                                  Storagelocation   = ls2-storagelocation )

   %control                     = VALUE #( Uuid = if_abap_behv=>mk-on
                                           Length = if_abap_behv=>mk-on
    									   Quantity = if_abap_behv=>mk-on
    									   Quanwt = if_abap_behv=>mk-on
    									   Sno = if_abap_behv=>mk-on
    									   Irno = if_abap_behv=>mk-on
    									   Batch = if_abap_behv=>mk-on
									       Plant = if_abap_behv=>mk-on
									       Matnr = if_abap_behv=>mk-on
									         matnoitno = if_abap_behv=>mk-on
									       Storagelocation = if_abap_behv=>mk-on )
     )
     )
    ) ).

**********************************************************************
    IF ls_hdr-Vrcuting = 'CR'.
      gt_item8              = VALUE #( ( %cid_ref = keys[ 1 ]-%cid_ref
                                          %is_draft = keys[ 1 ]-%is_draft
                                          Uuid = keys[ 1 ]-Uuid
       %target               = VALUE #( FOR ls6 IN zbp_pp_apps05_rv=>gt_item4
                                      ( %cid = keys[ 1 ]-%cid_ref
                                        %is_draft = keys[ 1 ]-%is_draft
       %data                 = VALUE #( Uuid = keys[ 1 ]-Uuid
                                        Sno = ls6-sno
                                        Irno = condense( ls6-irno )
                                        Length = ls6-length
                                        width  = ls_item1-Width
                                        Apcs = ls6-quantity
                                        Used = ls6-quantity
                                        Uqty = ls6-quanwt
                                        matnr = ls6-matnr
                                        batch = ls6-batch
                                        storagelocation = ls6-storagelocation
                                        plant = ls6-plant
                                        Vrno = ls6-vrno
                                        Rqty = ls6-quanwt
                                        Matnoitno = ls6-matnoitno
       )
       %control              = VALUE #( Uuid = if_abap_behv=>mk-on
                                        Length = if_abap_behv=>mk-on
                                        Sno = if_abap_behv=>mk-on
                                        Irno = if_abap_behv=>mk-on
                                        Uqty = if_abap_behv=>mk-on
                                        width = if_abap_behv=>mk-on
                                        Apcs = if_abap_behv=>mk-on
                                        Used = if_abap_behv=>mk-on
       								   matnr = if_abap_behv=>mk-on
       								   batch = if_abap_behv=>mk-on
       								   storagelocation = if_abap_behv=>mk-on
       								   plant = if_abap_behv=>mk-on
       								   Vrno = if_abap_behv=>mk-on
                                        Rqty = if_abap_behv=>mk-on
                                        Matnoitno = if_abap_behv=>mk-on

        )
        ) )
       ) ).

**********************************************************************

    ENDIF.

**********************************************************************


    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    CREATE BY \_itemgtstock
    AUTO FILL CID WITH gt_item4.


**********************************************************************
    IF ls_hdr-Vrcuting = 'CR'.
      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _hdr
      CREATE BY \_itemsumry
      AUTO FILL CID WITH gt_item8.
    ENDIF.
**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _itemftstock
    UPDATE FROM VALUE #( ( %tky = ls_item1-%tky
    Mark = 'X'
    %control-Mark = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped)
     FAILED DATA(ls_failed)
     REPORTED DATA(ls_reported).

**********************************************************************

    SELECT SINGLE FROM zpp_apps05_ditb4 FIELDS  SUM( quanwt )  WHERE uuid = @ls_item1-Uuid INTO @DATA(lv_totwt) .
    IF lv_totwt IS NOT INITIAL.
      lv_totwt1 = zbp_pp_apps05_rv=>gt_item4[ 1 ]-quanwt + lv_totwt.
    ELSE .
      lv_totwt1 = zbp_pp_apps05_rv=>gt_item4[ 1 ]-quanwt.

    ENDIF.

**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    UPDATE FROM VALUE #( ( Uuid = ls_item1-Uuid
    %is_draft = ls_item1-%is_draft
    Totwithst = lv_totwt1
    %control-Totwithst = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped1)
     FAILED DATA(ls_failed1)
     REPORTED DATA(ls_reported1).
**********************************************************************
**********************************************************************




  ENDMETHOD.

  METHOD gt_itmrqty.
**********************************************************************
    data : lv_q type i,
           lv_r type p deciMALS 3,
           lv_o type p decimals 4.
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr BY \_itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    READ ENTITY IN LOCAL MODE zpp_apps05_rv
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = VALUE #( lt_hdr[ 1 ] OPTIONAL ).
**********************************************************************
    LOOP AT lt_item INTO DATA(ls_item) WHERE Rpiecs IS NOT INITIAL.

      IF ls_item-Width IS INITIAL .
        lv_o = ls_item-Length * ls_hdr-Unitwet / 1000 * ls_item-Rpiecs.
      ELSE.
        lv_o = ls_item-Length * ls_item-Width * ls_hdr-Unitwet  / 1000000 * ls_item-Rpiecs.
      ENDIF.
if lv_o is not inITIAL.
      lv_q = TRUNC( lv_o * 1000 ).

      lv_r = lv_q / 1000 .

      ls_item-Rquantity =  lv_r.
endif.

      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _itemftstock UPDATE FROM VALUE #( ( %tky = ls_item-%tky
      Rquantity = ls_item-Rquantity
      %control-Rquantity = if_abap_behv=>mk-on ) ).

    ENDLOOP.
**********************************************************************

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

*    METHODS precheck_create FOR PRECHECK
*      IMPORTING entities FOR CREATE _hdr.

    METHODS GtLent FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~GtLent RESULT result.

    METHODS GtMark FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~GtMark RESULT result.

    METHODS GtPrint FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~GtPrint RESULT result.

    METHODS GtStok FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~GtStok RESULT result.
    METHODS gt_data1 FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_data1.
    METHODS gtintc FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtintc RESULT result.
    METHODS gtopers FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtopers RESULT result.
    METHODS vtoncrt FOR VALIDATE ON SAVE
      IMPORTING keys FOR _hdr~vtoncrt.
    METHODS gt_uporder FOR DETERMINE ON SAVE
      IMPORTING keys FOR _hdr~gt_uporder.
    METHODS gtcheck FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtcheck RESULT result.
    METHODS gtdelete FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtdelete  .
    METHODS gt_plant FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~gt_plant.
    METHODS gtcheckst FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtcheckst RESULT result.
    METHODS gt_uintwt FOR DETERMINE ON MODIFY
      IMPORTING keys FOR _hdr~gt_uintwt.
    METHODS gtstockclr FOR MODIFY
      IMPORTING keys FOR ACTION _hdr~gtstockclr RESULT result.
*    METHODS gtvrno FOR MODIFY
*      IMPORTING keys FOR ACTION _hdr~gtvrno RESULT result.

ENDCLASS.

CLASS lhc__hdr IMPLEMENTATION.

  METHOD get_instance_features.

**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_hdr)
    BY \_itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_item)
    BY \_itemgtlet
     ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_length)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item2)
    BY \_itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_itemst)
     BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_itemgt)
    BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(Lt_rslt)
    BY \_itemsumry
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_summ).
**********************************************************************
    IF lt_item2 IS NOT INITIAL.
      DATA(ls_item) = lt_item2[ 1 ]-Jobsht.
    ENDIF.

    DATA  : ls_can TYPE c LENGTH 1.
**********************************************************************
    IF lt_hdr[ 1 ]-Matno IS NOT INITIAL.
      DATA(ls_mark) = lt_hdr[ 1 ]-Matno .
      SELECT SINGLE FROM I_MaterialDocumentItem_2
      FIELDS
      GoodsMovementIsCancelled

      WHERE MaterialDocument = @ls_mark
      INTO @ls_can.
    ELSE.
      ls_can = 'X'.

    ENDIF.



    TRY.
        DATA(lv_user2) = cl_abap_context_info=>get_user_business_partner_id(  ).
      CATCH cx_abap_context_info_error INTO DATA(lv_error).
        DATA(lv_1) = 1.
    ENDTRY.

**********************************************************************
    result = VALUE #( FOR ls_data IN Lt_hdr
        (   %tky =  ls_data-%tky
*******************************Fields***************************************
    %features-%field-Vrcuting       =  COND #( WHEN  Lt_item IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
    %features-%field-Project        = COND #( WHEN Lt_item IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
    %features-%field-Purno          = COND #( WHEN Lt_item IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
    %features-%field-Sectmat        = COND #( WHEN Lt_item IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
    %features-%field-Unitwet        = COND #( WHEN Lt_item IS NOT INITIAL OR ls_data-Sectmat IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
    %features-%field-Werks          = COND #( WHEN Lt_item IS NOT INITIAL

                                                    THEN if_abap_behv=>fc-f-read_only

                                                    ELSE if_abap_behv=>fc-f-mandatory  )
**********************************End**************************************

*********************************Button*************************************



   %action-GtMark                       = COND #( WHEN Lt_item IS NOT INITIAL
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled )

   %action-GtStok                        = COND #( WHEN ls_data-Chckmrk IS NOT INITIAL
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled )
   %action-GtOpers                      = COND #( WHEN   ls_data-Chckmrk IS NOT INITIAL OR ls_data-Status IS INITIAL OR ls_item IS NOT INITIAL
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                     ELSE
                                                      if_abap_behv=>fc-o-enabled )
   %action-GtPrint                      = COND #( WHEN ls_data-Vrno IS NOT INITIAL
                                                     THEN
                                                       if_abap_behv=>fc-o-enabled
                                                     ELSE
                                                       if_abap_behv=>fc-o-disabled )
   %action-Edit                         = COND #( WHEN ls_data-Vrno IS NOT INITIAL
                                                    THEN
                                                     if_abap_behv=>fc-o-disabled
                                                    ELSE
                                                     if_abap_behv=>fc-o-enabled  )
   %action-GtDelete                              =  COND #( WHEN  ( ls_data-Vrno IS NOT INITIAL AND  ls_can IS INITIAL ) OR ls_data-Statusr IS NOT INITIAL OR ls_data-Statusgi IS NOT INITIAL
                                                             OR ls_data-Statusgr IS NOT INITIAL OR keys[ 1 ]-%is_draft IS NOT INITIAL AND ( lv_user2 <> '9980000000' OR lv_user2 <> '9980000010' )
                                                   THEN
                                                    if_abap_behv=>fc-o-disabled
                                                   ELSE
                                                    if_abap_behv=>fc-o-enabled    )



   %action-GtCheck                      = COND #( WHEN ls_data-Chckmrk IS NOT INITIAL
                                                     THEN
                                                      if_abap_behv=>fc-o-disabled
                                                     ELSE
                                                      if_abap_behv=>fc-o-enabled )
   %action-GtLent                       = COND #( WHEN ls_data-Chckmrk IS NOT INITIAL
                                                     THEN
                                                     if_abap_behv=>fc-o-disabled
                                                     ELSE
                                                     if_abap_behv=>fc-o-enabled )

   %action-Gtcheckst                  =  COND #( WHEN ls_data-Chckmrk IS NOT INITIAL  OR ls_data-Status IS NOT INITIAL
                                                     THEN
                                                     if_abap_behv=>fc-o-disabled
                                                     ELSE
                                                     if_abap_behv=>fc-o-enabled )

   %action-GtIntc                      =  COND #( WHEN   ls_data-Chckmrk IS NOT INITIAL OR ls_data-Vrcuting = 'CR'
                                                     THEN
                                                      if_abap_behv=>fc-o-disabled
                                                     ELSE
                                                      if_abap_behv=>fc-o-enabled )
                                         ) ).
********************************End**************************************

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.

  ENDMETHOD.

*  METHOD precheck_create.
*  ENDMETHOD.

  METHOD GtLent.
**********************************************************************

    DATA : gt_item3 TYPE TABLE FOR CREATE zpp_apps05_rv\_itemgtlet.

**********************************************************************
**********************************************************************

    READ ENTITIES OF zpp_apps05_rv  IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

**********************************************************************
**********************************************************************

    DATA(ls_uuid) = lt_hdr[ 1 ]-Uuid.

**********************************************************************
    DELETE FROM zpp_apps05_dibt3 WHERE uuid = @ls_uuid.
**********************************************************************
    IF lt_item IS NOT INITIAL.

      SELECT FROM @lt_item AS item
      FIELDS
      Length,
      SUM( Reqty ) AS Reqty
      GROUP BY
      Length
      INTO TABLE @DATA(lt_sItem).

**********************************************************************
**********************************************************************
      zbp_pp_apps05_rv=>gt_item3 = VALUE #( FOR ls IN lt_sitem ( uuid = ls_uuid
      length = ls-Length
      quantity = ls-reqty ) ).
**********************************************************************
      gt_item3    = VALUE #(   ( %cid_ref = keys[ 1 ]-%cid_ref
                               %is_draft = keys[ 1 ]-%is_draft
                               Uuid = keys[ 1 ]-Uuid

      %target     = VALUE #(   FOR ls2 IN zbp_pp_apps05_rv=>gt_item3
                               ( %cid = keys[ 1 ]-%cid_ref
                                 %is_draft = keys[ 1 ]-%is_draft

       %data      = VALUE #(    Uuid = keys[ 1 ]-Uuid
                                Length = ls2-length
                                Quantity = ls2-quantity )
       %control   =  VALUE #(   Uuid = if_abap_behv=>mk-on
                                Length = if_abap_behv=>mk-on
                                Quantity = if_abap_behv=>mk-on  )
       ) )  )  ).
**********************************************************************
**********************************************************************

      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _hdr CREATE BY \_itemgtlet
      AUTO FILL CID WITH gt_item3.
**********************************************************************
**********************************************************************
    ELSE.
      DATA(lv_msg1) = 'No Data is there : Please Select Orders'.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky ) TO failed-_hdr.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky
       %state_area    = 'Validate_Header'
       %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg1 ) ) TO reported-_hdr .

    ENDIF.

**********************************************************************

    result = VALUE #(
       FOR ls1 IN lt_hdr (
         %tky   = ls1-%tky
         %param = ls1
       )
     ).
**********************************************************************






  ENDMETHOD.

  METHOD GtMark.
**********************************************************************
    DATA: gs_item TYPE zpp_apps05_itb,
          gt_item TYPE TABLE FOR CREATE zpp_apps05_rv\_itemgtmark.
**********************************************************************
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
**********************************************************************
    IF lt_hdr IS INITIAL.
      RETURN.
    ENDIF.

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
**********************************************************************


    IF ls_hdr-Unitwet IS INITIAL AND ls_hdr-Purno IS NOT INITIAL AND ls_hdr-Sectmat IS NOT INITIAL.

      DATA(lv_msg9) = |Unit Wt is not Maintained|.

      APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg9 )   )  TO reported-_hdr.
      RETURN.

    ENDIF.

    IF ls_hdr-Unitwet IS NOT INITIAL.

      SELECT SINGLE FROM i_product
      FIELDS
      yy1_unit_wgt_prd
      WHERE Product = @ls_hdr-Sectmat
      INTO @DATA(ls_unitwt).

      IF  ls_hdr-Unitwet <> ls_unitwt.


        DATA(lv_msg23) = |Unit Wt is Not Match|.

        APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.

        APPEND VALUE #( %tky           = ls_hdr-%tky
                        %state_area    = 'Validate_Header'
                        %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                text     = lv_msg23 )   )  TO reported-_hdr.
        RETURN.

      ENDIF.


    ENDIF.
**********************************************************************
    IF ls_hdr-Project IS NOT INITIAL AND ls_hdr-Purno IS NOT INITIAL AND ls_hdr-Sectmat IS NOT INITIAL.
      SELECT SINGLE FROM zpp_apps05_dthb AS hdr
      LEFT JOIN I_BusinessUserBasic AS bo ON bo~UserID = hdr~createdby  FIELDS hdr~sectmat,hdr~createdby,bo~FirstName WHERE project = @ls_hdr-Project  AND purno = @ls_hdr-Purno AND sectmat = @ls_hdr-Sectmat INTO @DATA(ls_data).
      SELECT COUNT( * )
  FROM zpp_apps05_dthb
  WHERE project = @ls_hdr-project
    AND purno   = @ls_hdr-purno
    AND sectmat = @ls_hdr-sectmat
  INTO @DATA(lv_count).
      IF ls_data IS NOT INITIAL.
        IF lv_count > 1.
          DATA(lv_msg24) = |Section { ls_hdr-Sectmat } locked by { ls_data-FirstName }|.

          APPEND VALUE #( %tky = ls_hdr-%tky ) TO failed-_hdr.

          APPEND VALUE #( %tky           = ls_hdr-%tky
                          %state_area    = 'Validate_Header'
                          %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg24 )   )  TO reported-_hdr.
          RETURN.
        ENDIF.
      ENDIF.
    ENDIF.
**********************************************************************

**********************************************************************
**********************************************************************
    IF ls_hdr-Project IS NOT INITIAL.
      DATA(ls_project) = ls_hdr-Project && '%' .
    ENDIF.
**********************************************************************
**********************************************************************

    SELECT
    rv~ManufacturingOrder,
    rv~bom,
    rv~BillOfMaterialCategory,
    rv~BillOfMaterialVariant,
    rv~Material,
    rv~Plant,
    rv~SalesOrder,
    rv~SalesOrderItem,
    rv~MfgOrderItemPlannedTotalQty,
    rv~ProductionUnit,
    rv~BillOfMaterialItemNodeNumber,
    rv~BOMItemInternalChangeCount,
    rv~ProductName,
    rv~yy1_length_mm_prd,
    rv~yy1_width_mm_prd,
    op~OrderOperationInternalID,
    op~StandardTextInternalID,
    rv~Reservation,
    coalesce( ztb~reqty, 0 ) AS reqty
    FROM zpp_apps05_prov AS rv
    LEFT JOIN zpp_apps05_polv AS ztb
    ON ztb~ManufacturingOrder = rv~ManufacturingOrder
    AND ztb~Material           = rv~Material
    LEFT JOIN zpp_apps05_opv AS op ON op~ManufacturingOrder = rv~ManufacturingOrder
    WHERE rv~MainItemPricingRefProduct LIKE  @ls_project
    AND rv~BillOfMaterialComponent = @ls_hdr-Sectmat
    AND rv~YY1_PriorityPONos_SDH = @ls_hdr-Purno
    AND rv~Plant = @ls_hdr-Werks
    AND rv~ManufacturingOrder IS NOT INITIAL
    INTO TABLE @DATA(lt_manu1).

    DATA(lt_item) = lt_manu1.

**********************************************************************
**********************************************************************


    IF lt_manu1 IS NOT INITIAL.
      SORT lt_manu1 BY ManufacturingOrder.
      DELETE ADJACENT DUPLICATES FROM lt_manu1 COMPARING ManufacturingOrder.
*      SELECT FROM zpp_apps05_opv
*      FIELDS
*      OrderOperationInternalID,
*      ManufacturingOrder,
*      StandardTextInternalID
*      FOR ALL ENTRIES IN @lt_manu1
*      WHERE ManufacturingOrder = @lt_manu1-ManufacturingOrder
*      INTO TABLE @DATA(lt_item).

      SORT lt_item BY ManufacturingOrder  OrderOperationInternalID ASCENDING.

**********************************************************************
**********************************************************************
      LOOP AT lt_manu1 INTO DATA(ls).

        gs_item-uuid      = ls_hdr-Uuid.
        gs_item-plant     = ls-Plant.
        gs_item-orderno   = ls-ManufacturingOrder.
        gs_item-matnr     = ls-Material.
        gs_item-maktx     = ls-ProductName.
        gs_item-length    = ls-yy1_length_mm_prd.
        gs_item-width     = ls-yy1_width_mm_prd.
        gs_item-plnqty    = ls-MfgOrderItemPlannedTotalQty.
        gs_item-uom       = ls-ProductionUnit.
        gs_item-totreqty  = ls-reqty.
        gs_item-totopnqty = gs_item-plnqty - ls-reqty.
        gs_item-reqty     = gs_item-totopnqty.
**********************************************************************

        gs_item-netwt     = COND #( WHEN gs_item-width IS INITIAL THEN
                            gs_item-length * lt_hdr[ 1 ]-unitwet  / 1000 * gs_item-reqty
                            ELSE
                            gs_item-length * gs_item-width * lt_hdr[ 1 ]-unitwet / 1000000 * gs_item-reqty ).

**********************************************************************
        gs_item-vbeln     = ls-SalesOrder.
        gs_item-soitem    = ls-SalesOrderItem.
        gs_item-rsnum     = ls-Reservation.

**********************************************************************

        gs_item-operation = REDUCE string(
                            INIT result1 TYPE string
                            FOR ls2 IN lt_item
                            WHERE ( ManufacturingOrder = ls-ManufacturingOrder )
                            NEXT result1 = result1 && ls2-StandardTextInternalID  ).

**********************************************************************

        IF gs_item-totopnqty > 0.

          APPEND gs_item TO zbp_pp_apps05_rv=>gt_item.

        ENDIF.

**********************************************************************

        CLEAR gs_item.

      ENDLOOP.
**********************************************************************
**********************************************************************

      gt_item   = VALUE #(  ( %cid_ref = keys[ 1 ]-%cid_ref
                              %is_draft = keys[ 1 ]-%is_draft
                              Uuid = keys[ 1 ]-Uuid

      %target   = VALUE #(    FOR ls5 IN zbp_pp_apps05_rv=>gt_item
                         (    %cid = keys[ 1 ]-%cid_ref
                              %is_draft = keys[ 1 ]-%is_draft
      %data     = VALUE #(    Uuid = keys[ 1 ]-Uuid
                              plant   =  ls5-plant
                              orderno   = ls5-orderno
   							  matnr     = ls5-matnr
   							  maktx     = ls5-maktx
   							  length   = ls5-length
   							  width    = ls5-width
   							  plnqty   = ls5-plnqty
   							  uom      = ls5-uom
   							  totreqty = ls5-totreqty
   							  totopnqty = ls5-totopnqty
   							  reqty    = ls5-reqty
   							  vbeln    = ls5-vbeln
   							  soitem   = ls5-soitem
   							  Operation = ls5-operation
   							  Netwt = ls5-netwt
   							  Rsnum = ls5-rsnum )
   							
      %control   = VALUE #(   uuid     = if_abap_behv=>mk-on
                              plant    = if_abap_behv=>mk-on
                              orderno  = if_abap_behv=>mk-on
                              matnr    = if_abap_behv=>mk-on
                              maktx    = if_abap_behv=>mk-on
                              length   = if_abap_behv=>mk-on
                              width    = if_abap_behv=>mk-on
                              plnqty   = if_abap_behv=>mk-on
                              uom      = if_abap_behv=>mk-on
                              totreqty = if_abap_behv=>mk-on
                              totopnqty = if_abap_behv=>mk-on
                              reqty    = if_abap_behv=>mk-on
                              vbeln    = if_abap_behv=>mk-on
                              soitem   = if_abap_behv=>mk-on
                              Operation = if_abap_behv=>mk-on
                               Netwt = if_abap_behv=>mk-on
                              Rsnum = if_abap_behv=>mk-on  )
       ) ) ) ).

**********************************************************************
**********************************************************************

      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _hdr CREATE BY \_itemgtmark
      AUTO FILL CID WITH gt_item.

**********************************************************************
**********************************************************************

    ELSEIF ls_hdr-Vrcuting IS INITIAL.
*************************Error Validation For VR Field*********************************************

      DATA(lv_msg1) = |Please Maintain Vr Series|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg1 )   )
             TO reported-_hdr.
*****************************Error Validation For Plant Field*****************************************
    ELSEIF ls_hdr-Werks IS INITIAL.

      DATA(lv_msg2) = |Please Maintain Plant|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.
**********************************************************************
    ELSEIF ls_hdr-Project IS INITIAL.

      DATA(lv_msg3) = |Please Maintain Project|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg3 )   )
             TO reported-_hdr.
**********************************************************************
    ELSEIF ls_hdr-Sectmat IS INITIAL.

      DATA(lv_msg4) = |Please Maintain Section Material|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg4 )   )
             TO reported-_hdr.
**********************************************************************
    ELSEIF ls_hdr-Unitwet IS INITIAL OR ls_hdr-Unitwet = 0 .

      DATA(lv_msg5) = |Please Maintain Unit wt|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg5 )   )
             TO reported-_hdr.
**********************************************************************
    ELSE .
      DATA(lv_msg6) = |Plan has already been created for the particular section.|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-information
                                                              text     = lv_msg6 )   )
             TO reported-_hdr.
**********************************************************************

    ENDIF.
**********************************************************************

**********************************************************************
**********************************************************************

    result = VALUE #(
      FOR ls3 IN lt_hdr (
        %tky   = ls3-%tky
        %param = ls3
      )
    ).

**********************************************************************
**********************************************************************

  ENDMETHOD.














  METHOD GtPrint.
**********************************************************************
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
    DATA gs_item2 TYPE zpp_apps05_itb2.
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
    DATA(ls_keys) = keys[ 1 ].
    DATA: lv_total  TYPE menge_d,
          lv_total1 TYPE menge_d,
          lv_total2 TYPE menge_d,
          ls_total  TYPE zpp_apps05_itb2p,
          lv_order  TYPE string,
          lv_count  TYPE i,
          lno       TYPE i,
          lt_final  TYPE TABLE OF zpp_apps05_itb2p,
          lt_grptb type table of zpp_apps05_grp03.
**********************************************************************
    IF ls_keys-%param-lowvalu = 'RM'.
**********************************************************************
      SELECT * FROM zpp_apps05_itb2 WHERE vrno = @ls_hdr-Vrno INTO TABLE @DATA(lt_item2).

**********************************************************************
      IF lt_item2 IS NOT INITIAL.
**********************************************************************
        SORT lt_item2 BY jobsht matnr ASCENDING .

        LOOP AT lt_item2 INTO DATA(ls_item2) GROUP BY ( jobsht  = ls_item2-jobsht
        matnr = ls_item2-matnr ) INTO DATA(ls_gtp).
          ls_item2 = VALUE #( lt_item2[ jobsht = ls_gtp-jobsht matnr = ls_gtp-matnr ] OPTIONAL ).

          CLEAR : lv_order, lv_count , lv_total ,  lv_total1 ,  lv_total2 .


          LOOP AT GROUP ls_gtp INTO DATA(lw_grp).
*            lno = lno + 1.
*            lw_grp-sno = lno .
*            APPEND lw_grp TO lt_final.
            IF lv_order IS INITIAL.
              lv_order = lw_grp-orderno.
            ELSE.
              lv_order = |{ lv_order  } / {  lw_grp-orderno }|.
            ENDIF.

            lv_total = lv_total + lw_grp-reqty.
            lv_total1 = lv_total1 + lw_grp-wetpc.
            lv_total2 = lv_total2 + lw_grp-netwt.
*            lv_count = lv_count + 1.
            ls_total-jobsht = lw_grp-jobsht.
            ls_total-matnr = lw_grp-matnr.
            ls_total-length = lw_grp-length.
            ls_total-width = lw_grp-width.
            ls_total-plant = lw_grp-plant.
            ls_total-vrno = lw_grp-vrno.
            ls_total-uuid = lw_grp-uuid.
            ls_total-operation = lw_grp-operation.



          ENDLOOP.




          lno =  lno + 1.
          ls_total-sno  = lno.

          ls_total-reqty = lv_total.
          ls_total-wetpc = lv_total1.
          ls_total-netwt = lv_total2.
          ls_total-orderno = lv_order.

          APPEND ls_total TO lt_final.




        ENDLOOP.

      ENDIF.

      IF lt_final IS NOT INITIAL.


      select    client , vrno,  jobsht ,  operation , uuid , plant from @lt_final
      AS h
      GROUP BY
     client, vrno,  jobsht ,   operation ,uuid , plant
      ORDER BY
      vrno , jobsht
      into correSPONDING FIELDS OF table @lt_grptb.




       delete from zpp_apps05_grp03 where vrno = @ls_hdr-Vrno.
       DELETE FROM zpp_apps05_itb2p WHERE vrno = @ls_hdr-Vrno.
        MODIFY zpp_apps05_itb2p FROM TABLE @lt_final.
        modify zpp_apps05_grp03 from table @lt_grptb.

      ENDIF.


**********************************************************************




**********************************************************************
      TRY.
          "Initialize Template Store Client
          DATA(lo_store) = NEW zcl_fp_tmpl_store_client1(
           iv_name                  = 'ZTEST_CS'
           iv_service_instance_name = 'ZTEST_OS_REST'
          ).

          DATA(lo_fdp_util) = cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_APPS05_UICE'
                                                                iv_root_node = 'ZPP_APPS05_CE' ) .

          DATA: printque TYPE c LENGTH 32.

          printque = 'ADOBE_DEFAULT'.

**********************************************************************

          TRY.
              lo_store->get_schema_by_name( iv_form_name = 'ZCUTTING' ).
              "   out->write( 'Schema found in form' ).
            CATCH zcx_fp_tmpl_store_error1 INTO DATA(lo_tmpl_error).
              "  out->write( 'No schema in form found' ).
              IF lo_tmpl_error->mv_http_status_code = 404 OR lo_tmpl_error->mv_http_status_code = 403 .
                "Upload service definition
*                  lo_store->set_schema(
*                    iv_form_name = 'GATEFORM'
*                    is_data      = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd( ) )
*                  ).
              ELSE.

              ENDIF.
          ENDTRY.
**********************************************************************
          TYPES: BEGIN OF ty_schema_body,
                   xsd_schema  TYPE xstring,
                   schema_name TYPE c LENGTH 30,
                   note        TYPE c LENGTH 280,
                 END OF ty_schema_body.
**********************************************************************
          " TODO: variable is assigned but never used (ABAP cleaner)
          DATA lv_xdp TYPE ty_schema_body.
          lv_xdp = VALUE #( note        = ''
                            schema_name = 'schema'
                            xsd_schema  = lo_fdp_util->get_xsd( ) ).

**********************************************************************

          DATA(lt_keys)     = lo_fdp_util->get_keys( ).

**********************************************************************
          IF lt_keys IS NOT INITIAL.
            lt_keys[ name = 'VRNO' ]-value = ls_hdr-Vrno.
          ENDIF.
**********************************************************************
*          lt_keys[ name = 'JOBST' ]-value = ls_item-Jobsht.

**********************************************************************
          DATA(lt_xsd) = lo_fdp_util->get_xsd( ).
*            lt_xsd[ name = 'BILLINGDOCUMENT' ]-value = header[ 1 ]-BillingDocument.
          DATA:  lv_sd TYPE xstring.
          DATA(lv_text) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).
          lv_sd = cl_web_http_utility=>decode_utf8( encoded = lt_xsd ).

**********************************************************************
          TRY.
*          LOOP AT lt_keys INTO DATA(LS_KEY) .
              DATA(lv_xml) = lo_fdp_util->read_to_xml( lt_keys ).
*          ENDLOOP.
              DATA(lv_text1) = cl_web_http_utility=>decode_utf8( encoded = lv_xml ).
            CATCH cx_fp_fdp_error INTO DATA(lo_exception).
              DATA(lv_erro) = 1.
          ENDTRY..
**********************************************************************

          DATA(ls_template) = lo_store->get_template_by_name(
            iv_get_binary    = abap_true
            iv_form_name     = 'ZCUTTING'
            iv_template_name = 'YY1_CUTTING_FRM'
          ).
**********************************************************************

          cl_fp_ads_util=>render_pdf( EXPORTING iv_locale       = 'en_US'
                                     "  iv_pq_name      = CONV zde_pqname( ls_queue-printque )"'YYRESV' "'PRINT_QUEUE'
                                               iv_xml_data     = lv_xml
                                               iv_xdp_layout   = ls_template-xdp_template
                                               is_options      = VALUE #( trace_level = 4 ) " Use 0 in production environment
                                     IMPORTING
                                     " TODO: variable is assigned but never used (ABAP cleaner)
                                               ev_trace_string = DATA(lv_trace)
                                               ev_pdf          = DATA(lv_pdf) ).
**********************************************************************

          DATA: lv_name TYPE c LENGTH 120.
          lv_name = |Invoice { ls_hdr-Vrno }|.

          DATA(lv_gno) = VALUE #( lt_hdr[ 1 ]-Vrno OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
            iv_qname            = printque
            iv_print_data       = lv_pdf
            iv_name_of_main_doc = lv_name
            iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
          ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lver) = 1.
          " out->write( 'Exception occurred.' ).
      ENDTRY.
**********************************************************************

      DATA:
               gs_att TYPE zpp_apps05_att.

      IF lv_pdf IS NOT INITIAL.
        gs_att-vrno = ls_hdr-Vrno.
        gs_att-attachment = lv_pdf.
        gs_att-filename = ls_hdr-Vrno.
        gs_att-mimetype = 'application/pdf'.

        APPEND gs_att TO zbp_pp_apps05_rv=>gt_att.
*                 zbp_sd_app11_header=>up_attach = gt_att.
      ENDIF.
**********************************************************************
**********************************************************************
**********************************************************************

    ELSEIF ls_keys-%param-lowvalu = 'RR'.
**********************************************************************
      TRY.
          "Initialize Template Store Client
          DATA(lo_store1) = NEW zcl_fp_tmpl_store_client1(
           iv_name                  = 'ZTEST_CS'
           iv_service_instance_name = 'ZTEST_OS_REST'
          ).

          DATA(lo_fdp_util1) = cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_APPS05_UICE'
                                                                iv_root_node = 'ZPP_APPS05_RM' ) .

          DATA: printque1 TYPE c LENGTH 32.

          printque1 = 'ADOBE_DEFAULT'.
**********************************************************************
**********************************************************************
          TRY.
              lo_store1->get_schema_by_name( iv_form_name = 'ZRM_REQ_FORM' ).
              "   out->write( 'Schema found in form' ).
            CATCH zcx_fp_tmpl_store_error1 INTO DATA(lo_tmpl_error1).
              "  out->write( 'No schema in form found' ).
              IF lo_tmpl_error1->mv_http_status_code = 404 OR lo_tmpl_error1->mv_http_status_code = 403 .
                "Upload service definition
*                  lo_store->set_schema(
*                    iv_form_name = 'GATEFORM'
*                    is_data      = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd( ) )
*                  ).
              ELSE.

              ENDIF.
          ENDTRY.
**********************************************************************
**********************************************************************
          TYPES: BEGIN OF ty_schema_body1,
                   xsd_schema  TYPE xstring,
                   schema_name TYPE c LENGTH 30,
                   note        TYPE c LENGTH 280,
                 END OF ty_schema_body1.
**********************************************************************
**********************************************************************
          " TODO: variable is assigned but never used (ABAP cleaner)
          DATA lv_xdp1 TYPE ty_schema_body.
          lv_xdp1 = VALUE #( note        = ''
                            schema_name = 'schema'
                            xsd_schema  = lo_fdp_util1->get_xsd( ) ).
**********************************************************************
          DATA(lt_keys1)     = lo_fdp_util1->get_keys( ).
**********************************************************************
          IF lt_keys1 IS NOT INITIAL.
            lt_keys1[ name = 'VRNO' ]-value = ls_hdr-Vrno.
          ENDIF.
**********************************************************************
*          lt_keys[ name = 'JOBST' ]-value = ls_item-Jobsht.


          DATA(lt_xsd1) = lo_fdp_util1->get_xsd( ).
*
          DATA(lv_text2) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd1 ).
**********************************************************************
          TRY.
*          LOOP AT lt_keys INTO DATA(LS_KEY) .
              DATA(lv_xml1) = lo_fdp_util1->read_to_xml( lt_keys1 ).
*          ENDLOOP.
              DATA(lv_text3) = cl_web_http_utility=>decode_utf8( encoded = lv_xml1 ).
            CATCH cx_fp_fdp_error INTO DATA(lo_exception1).
              DATA(lv_error02) = 2.
          ENDTRY..

          DATA(ls_template1) = lo_store1->get_template_by_name(
            iv_get_binary    = abap_true
            iv_form_name     = 'ZRM_REQ_FORM'
            iv_template_name = 'YY1_RQM_FRM'
          ).
**********************************************************************

          cl_fp_ads_util=>render_pdf( EXPORTING iv_locale       = 'en_US'
                                     "  iv_pq_name      = CONV zde_pqname( ls_queue-printque )"'YYRESV' "'PRINT_QUEUE'
                                               iv_xml_data     = lv_xml1
                                               iv_xdp_layout   = ls_template1-xdp_template
                                               is_options      = VALUE #( trace_level = 4 ) " Use 0 in production environment
                                     IMPORTING
                                     " TODO: variable is assigned but never used (ABAP cleaner)
                                               ev_trace_string = DATA(lv_trace1)
                                               ev_pdf          = DATA(lv_pdf1) ).


          DATA: lv_name1 TYPE c LENGTH 120.
          lv_name1 = |Invoice { ls_hdr-Vrno }|.

          DATA(lv_gno1) = VALUE #( lt_hdr[ 1 ]-Vrno OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
            iv_qname            = printque1
            iv_print_data       = lv_pdf1
            iv_name_of_main_doc = lv_name1
            iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
          ).

        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          " out->write( 'Exception occurred.' ).
          DATA(lv_error03) = 1.
      ENDTRY.

**********************************************************************
      DATA:
               gs_att1 TYPE zpp_apps05_att.

      IF lv_pdf1 IS NOT INITIAL.
        gs_att1-vrno = ls_hdr-Vrno.
        gs_att1-attachment = lv_pdf1.
        gs_att1-filename = ls_hdr-Vrno.
        gs_att1-mimetype = 'application/pdf'.

        APPEND gs_att1 TO zbp_pp_apps05_rv=>gt_att.
**********************************************************************
      ENDIF.
    ELSEIF ls_keys-%param-lowvalu = 'RW'.

**********************************************************************
      TRY.
          "Initialize Template Store Client
          DATA(lo_store2) = NEW zcl_fp_tmpl_store_client1(
           iv_name                  = 'ZTEST_CS'
           iv_service_instance_name = 'ZTEST_OS_REST'
          ).

          DATA(lo_fdp_util2) = cl_fp_fdp_services=>get_instance( iv_service_definition = 'ZPP_APPS05_UICE'
                                                                iv_root_node = 'ZPP_APPS05_RMCAV' ) .

          DATA: printque2 TYPE c LENGTH 32.

          printque2 = 'ADOBE_DEFAULT'.
**********************************************************************

          TRY.
              lo_store2->get_schema_by_name( iv_form_name = 'ZRM_CUTALW_FORM' ).
              "   out->write( 'Schema found in form' ).
            CATCH zcx_fp_tmpl_store_error1 INTO DATA(lo_tmpl_error2).
              "  out->write( 'No schema in form found' ).
              IF lo_tmpl_error2->mv_http_status_code = 404 OR lo_tmpl_error2->mv_http_status_code = 403 .
                "Upload service definition
*                  lo_store->set_schema(
*                    iv_form_name = 'GATEFORM'
*                    is_data      = VALUE #( note = '' schema_name = 'schema' xsd_schema = lo_fdp_util->get_xsd( ) )
*                  ).
              ELSE.

              ENDIF.
          ENDTRY.
**********************************************************************
          TYPES: BEGIN OF ty_schema_body2,
                   xsd_schema  TYPE xstring,
                   schema_name TYPE c LENGTH 30,
                   note        TYPE c LENGTH 280,
                 END OF ty_schema_body2.
*                 data : ldata type xstring.
          " TODO: variable is assigned but never used (ABAP cleaner)
          DATA lv_xdp2 TYPE ty_schema_body.
          lv_xdp2 = VALUE #( note        = ''
                            schema_name = 'schema'
                            xsd_schema  = lo_fdp_util2->get_xsd( ) ).
**********************************************************************

          DATA(lt_keys2)     = lo_fdp_util2->get_keys( ).
          IF lt_keys2 IS NOT INITIAL.
            lt_keys2[ name = 'VRNO' ]-value = ls_hdr-Vrno.
          ENDIF.
*          lt_keys[ name = 'JOBST' ]-value = ls_item-Jobsht.
**********************************************************************

          DATA(lt_xsd2) = lo_fdp_util2->get_xsd( ).
*
          DATA(lv_text4) = cl_web_http_utility=>decode_utf8( encoded = lt_xsd2 ).

          TRY.
*          LOOP AT lt_keys INTO DATA(LS_KEY) .
              DATA(lv_xml2) = lo_fdp_util2->read_to_xml( lt_keys2 ).
*          ENDLOOP.
              DATA ldata2 TYPE xstring.
              DATA(lv_text5) =  cl_web_http_utility=>decode_utf8( encoded = lv_xml2 ).
**********************************************************************
*ldata2 = cl_web_http_utility=>decode_utf8( encoded = lv_xml2 ) .
            CATCH cx_fp_fdp_error INTO DATA(lo_exception2).
              DATA(lv_eror05) = 1.
          ENDTRY..
**********************************************************************

          DATA(ls_template2) = lo_store2->get_template_by_name(
            iv_get_binary    = abap_true
            iv_form_name     = 'ZRM_CUTALW_FORM'
            iv_template_name = 'YY1_CUTTING_ALOC'
          ).
**********************************************************************
          cl_fp_ads_util=>render_pdf( EXPORTING iv_locale       = 'en_US'
                                     "  iv_pq_name      = CONV zde_pqname( ls_queue-printque )"'YYRESV' "'PRINT_QUEUE'
                                               iv_xml_data     = lv_xml2
                                               iv_xdp_layout   = ls_template2-xdp_template
                                               is_options      = VALUE #( trace_level = 4 ) " Use 0 in production environment
                                     IMPORTING
                                     " TODO: variable is assigned but never used (ABAP cleaner)
                                               ev_trace_string = DATA(lv_trace2)
                                               ev_pdf          = DATA(lv_pdf2) ).
**********************************************************************

          DATA: lv_name2 TYPE c LENGTH 120.
          lv_name2 = |Invoice { ls_hdr-Vrno }|.

          DATA(lv_gno2) = VALUE #( lt_hdr[ 1 ]-Vrno OPTIONAL ).


          cl_print_queue_utils=>create_queue_item_by_data(
            iv_qname            = printque2
            iv_print_data       = lv_pdf2
            iv_name_of_main_doc = lv_name2
            iv_itemid           = cl_print_queue_utils=>create_queue_itemid( )
          ).
**********************************************************************
        CATCH cx_fp_fdp_error zcx_fp_tmpl_store_error1 cx_fp_ads_util.
          DATA(lv_error05) = 1.
          " out->write( 'Exception occurred.' ).
      ENDTRY.

      DATA:
               gs_att2 TYPE zpp_apps05_att.

      IF lv_pdf2 IS NOT INITIAL.
        gs_att2-vrno = ls_hdr-Vrno.
        gs_att2-attachment = lv_pdf2.
        gs_att2-filename = ls_hdr-Vrno.
        gs_att2-mimetype = 'application/pdf'.

        APPEND gs_att2 TO zbp_pp_apps05_rv=>gt_att.

      ENDIF.

**********************************************************************

    ENDIF.

**********************************************************************
    result = VALUE #( FOR ls_ord IN lt_hdr
                        ( %tky   = ls_ord-%tky
                          %param = ls_ord ) ).


  ENDMETHOD.

  METHOD GtStok.
**********************************************************************
    DATA : gt_item5 TYPE TABLE FOR CREATE zpp_apps05_rv\_itemftstock.

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ] .
**********************************************************************
    IF ls_hdr-Werks IS NOT INITIAL AND ls_hdr-Sectmat IS NOT INITIAL.
      SELECT  FROM zpp_stock_rv AS hdr
      LEFT OUTER JOIN zpp_stock_bal AS itm ON itm~Purchaseorder = hdr~PurchaseOrder
      AND itm~Purchaseorderitem = hdr~PurchaseOrderItem
      AND itm~Materialdoc = hdr~MaterialDocument
      AND itm~Matdocitm = hdr~MaterialDocumentItem
      AND itm~Plant    = hdr~Plant
      AND itm~Batch    = hdr~Batch
      AND itm~Storagelocation = hdr~StorageLocation
      FIELDS
      hdr~Batch,
      hdr~MaterialDocument,
      hdr~MaterialDocumentItem,
      hdr~Product,
      CASE WHEN hdr~YY1_Length_No_MMI IS NOT INITIAL
      THEN
      hdr~YY1_Length_No_MMI
      ELSE
      hdr~length END AS YY1_Length_No_MMI ,
       CASE WHEN hdr~YY1_WidthNo_MMI IS NOT INITIAL
      THEN
      hdr~YY1_WidthNo_MMI
      ELSE
      hdr~width END AS YY1_WidthNo_MMI
      ,
      CASE WHEN hdr~YY1_Pieces_No_MMI IS NOT INITIAL
      THEN
      hdr~YY1_Pieces_No_MMI
      ELSE
      hdr~pcs END AS YY1_Pieces_No_MMI,
      hdr~YY1_PriorityPONO_PDH,
      hdr~StorageLocation,
      hdr~QuantityInBaseUnit,
      hdr~Plant,
      hdr~PostingDate,
      hdr~PurchaseOrder,
      hdr~PurchaseOrderItem,
      hdr~IRNno,
      hdr~supplname,
      itm~balnce,
      hdr~MatlWrhsStkQtyInMatlBaseUnit,
      hdr~balance,
      CASE WHEN itm~Mark = 'X'
      THEN
      itm~qtyblne
      ELSE hdr~QuantityInBaseUnit END AS qtyblne,
      hdr~yy1_unit_wgt_prd,
      CAST( 0 AS DEC( 15,3 ) ) AS disqty
      WHERE hdr~Product = @ls_hdr-Sectmat AND hdr~Plant = @ls_hdr-Werks  INTO TABLE @DATA(lt_stock).

      DELETE lt_stock WHERE qtyblne <= 0 OR yy1_length_no_mmi IS INITIAL.

      DATA: lv_rem_stock TYPE menge_d,
            lv_bl_ea     TYPE p LENGTH 10 DECIMALS 0,
            qty          TYPE zpp_apps05_dec,
            qty2         TYPE zpp_apps05_dec,
*  lv_rem_stock TYPE menge_d,
            lv_old_batch TYPE charg_d,
            lv_old_sloc  TYPE lgort_d,
            lv_old_mat   TYPE matnr,
            lv_old_plant TYPE werks_d.

      SORT lt_stock BY PostingDate DESCENDING.
      LOOP AT lt_stock ASSIGNING FIELD-SYMBOL(<fs_stock>) WHERE yy1_length_no_mmi IS NOT INITIAL .




        IF lv_old_batch <> <fs_stock>-Batch
        OR lv_old_sloc <> <fs_stock>-StorageLocation
        OR lv_old_mat <> <fs_stock>-Product
        OR lv_old_plant <> <fs_stock>-Plant.

          lv_rem_stock = <fs_stock>-MatlWrhsStkQtyInMatlBaseUnit.

          lv_old_batch = <fs_stock>-Batch.
          lv_old_sloc  = <fs_stock>-StorageLocation.
          lv_old_mat   = <fs_stock>-Product.
          lv_old_plant = <fs_stock>-Plant.

        ENDIF.

        IF lv_rem_stock <= 0.
          CONTINUE.
        ENDIF.
*IF <fs_stock>-qtyblne <> 0 OR <fs_stock>-qtyblne < 0 .

        IF lv_rem_stock >= <fs_stock>-qtyblne.

          <fs_stock>-disqty = <fs_stock>-qtyblne.

          lv_rem_stock = lv_rem_stock - <fs_stock>-qtyblne.

        ELSE.

          <fs_stock>-disqty = lv_rem_stock.

          lv_rem_stock = 0.

        ENDIF.


        IF <fs_stock>-yy1_widthno_mmi IS NOT INITIAL.
          qty = <fs_stock>-disqty * 1000000.
          qty2 = <fs_stock>-yy1_length_no_mmi * <fs_stock>-yy1_unit_wgt_prd * <fs_stock>-yy1_widthno_mmi.
        ELSE .

          qty = <fs_stock>-disqty * 1000.
          qty2 = <fs_stock>-yy1_length_no_mmi * <fs_stock>-yy1_unit_wgt_prd.
        ENDIF.

        <fs_stock>-balance = qty / qty2 .


        <fs_stock>-MatlWrhsStkQtyInMatlBaseUnit = lv_rem_stock.
*ENDIF.
      ENDLOOP.



    ENDIF.

**********************************************************************
    IF lt_stock IS NOT INITIAL.

      zbp_pp_apps05_rv=>gt_item5 = VALUE #( FOR ls IN lt_stock ( uuid = ls_hdr-Uuid
      length  = ls-YY1_Length_No_MMI
      width = ls-YY1_WidthNo_MMI
      product = ls-Product
      batch = ls-Batch
      materialdoc = ls-MaterialDocument
      matdocitm = ls-MaterialDocumentItem
      purchaseorder = COND #( when ls-PurchaseOrder is not inITIAL then  ls-PurchaseOrder
      else 'No Po' )
      purchaseorderitem = cond #( when ls-PurchaseOrderItem is not inITIAL then ls-PurchaseOrderItem
      else '00010' )
      plant = ls-Plant
      quantity = ls-QuantityInBaseUnit
      aquatity = ls-disqty
      piecs = ls-YY1_Pieces_No_MMI
      storagelocation = ls-StorageLocation
      pripono = ls-YY1_PriorityPONO_PDH
      apiecs = ls-balance
      irno = ls-IRNno
      supp = ls-supplname
       ) ).

      gt_item5 = VALUE #( ( %cid_ref = keys[ 1 ]-%cid_ref
      %is_draft = keys[ 1 ]-%is_draft
      Uuid = keys[ 1 ]-Uuid
      %target = VALUE #( FOR ls3 IN zbp_pp_apps05_rv=>gt_item5 ( %cid = keys[ 1 ]-%cid_ref
      %is_draft = keys[ 1 ]-%is_draft
      %data = VALUE #( Uuid = keys[ 1 ]-Uuid
      length  = ls3-length
      width = ls3-width
      product = ls3-Product
      batch = ls3-Batch
      materialdoc = ls3-materialdoc
      matdocitm = ls3-matdocitm
      purchaseorder = ls3-PurchaseOrder
      purchaseorderitem = ls3-PurchaseOrderItem
      plant = ls3-Plant
      quantity = ls3-quantity
      piecs = ls3-piecs
      storagelocation = ls3-StorageLocation
      pripono = ls3-pripono
      irno = ls3-irno
      supp = ls3-supp
      Apiecs = ls3-apiecs
      Aquatity = ls3-aquatity
      )
      %control = VALUE #(
      Uuid =  if_abap_behv=>mk-on
      length  = if_abap_behv=>mk-on
      width = if_abap_behv=>mk-on
      product = if_abap_behv=>mk-on
      batch = if_abap_behv=>mk-on
      materialdoc = if_abap_behv=>mk-on
      matdocitm = if_abap_behv=>mk-on
      purchaseorder = if_abap_behv=>mk-on
      purchaseorderitem = if_abap_behv=>mk-on
      plant = if_abap_behv=>mk-on
      quantity = if_abap_behv=>mk-on
      piecs = if_abap_behv=>mk-on
      storagelocation = if_abap_behv=>mk-on
      pripono = if_abap_behv=>mk-on
      irno = if_abap_behv=>mk-on
      supp = if_abap_behv=>mk-on
      Apiecs = if_abap_behv=>mk-on
      Aquatity =  if_abap_behv=>mk-on
      )

      )
       )

       ) ).
**********************************************************************
      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _hdr
      CREATE BY \_itemftstock
      AUTO FILL CID WITH gt_item5.
**********************************************************************
    ELSE .
      DATA(lv_msg1) = 'No Stock is Available'.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky ) TO failed-_hdr.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky
       %state_area    = 'Validate_Header'
       %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg1 ) ) TO reported-_hdr .
    ENDIF.
**********************************************************************
    result = VALUE #(
       FOR ls2 IN lt_hdr (
         %tky   = ls2-%tky
         %param = ls2
       )
     ).
**********************************************************************
  ENDMETHOD.

  METHOD gt_data1.
**********************************************************************
    DATA gs_hdr TYPE zpp_apps05_htb.
    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].

**********************************************************************
    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
**********************************************************************
    IF ls_hdr-Plndt IS INITIAL.
      gs_hdr-Plndt = cl_abap_context_info=>get_system_date(  ).
    ELSE.
      gs_hdr-plndt = ls_hdr-Plndt.
    ENDIF.
**********************************************************************

    TRY.
        cl_numberrange_runtime=>number_get( " generating number
                                            EXPORTING nr_range_nr = '01'
                                                      object      = 'ZPP_VRNO'
                                            IMPORTING number      = nr_number ).
        IF nr_number IS NOT INITIAL.
          DATA(lv_numb) = nr_number+15(5).

          gs_hdr-vrno =  |{ ls_hdr-Vrcuting }{ sy-datum+2(2) }{ sy-datum+4(2) }-{ lv_numb }|.
        ENDIF.
      CATCH cx_nr_object_not_found cx_number_ranges.
        DATA(lv_err05) = 1.
    ENDTRY.

**********************************************************************
    APPEND gs_hdr TO zbp_pp_apps05_rv=>gt_hdr.
**********************************************************************
  ENDMETHOD.

*  METHOD Gtvrno.
*  ENDMETHOD.

  METHOD GtIntc.
**********************************************************************
    DATA: lv_header TYPE abap_bool,
          lv_item   TYPE abap_bool,
          wa_scrid  TYPE c LENGTH 20,
          lno       TYPE i,
          lno1      TYPE i,
          leng      TYPE p LENGTH 15 DECIMALS 0.

**********************************************************************
**********************************************************************

    TYPES : BEGIN OF zty_item,
              markno  TYPE matnr,
              length  TYPE p LENGTH 15 DECIMALS 0,
              reqty   TYPE menge_d,
              balqty  TYPE menge_d,
              process TYPE c LENGTH 30,
              orderno TYPE aufnr,
            END OF zty_item.

**********************************************************************
**********************************************************************

    DATA : lt_table8 TYPE TABLE OF zpp_apps05_itb8,
           ls_table8 TYPE zpp_apps05_itb8.

    DATA : ls_hdr   TYPE zpp_apps05_itb6,
           gs_hdr   TYPE zpp_apps05_itb6,
           ls_item  TYPE zpp_apps05_itb7,
           ls_item2 TYPE zpp_apps05_itb7,
           gt_item6 TYPE TABLE FOR CREATE zpp_apps05_rv\_itemrsult,
           gt_item7 TYPE TABLE FOR CREATE zpp_apps05_irv6\_citem,
           gt_item8 TYPE TABLE FOR CREATE zpp_apps05_rv\_itemsumry.

    DATA: lt_lines    TYPE STANDARD TABLE OF string,
          lt_fields   TYPE STANDARD TABLE OF string,
          lt_martable TYPE TABLE OF zty_item,
          ls_martable TYPE zty_item.
    DATA : lt_excel       TYPE TABLE OF zbp_pp_apps05_rv=>gt_excel,
           lo_table_desc  TYPE REF TO cl_abap_tabledescr,
           lo_struc_descr TYPE REF TO cl_abap_structdescr.

**********************************************************************
**********************************************************************

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

**********************************************************************
    READ ENTITY IN LOCAL MODE zpp_apps05_rv BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_stock).

**********************************************************************

    IF lt_stock IS INITIAL.
      DATA(lv_msg1) = 'No Stock is Available'.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky ) TO failed-_hdr.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky
       %state_area    = 'Validate_Header'
       %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg1 ) ) TO reported-_hdr .
      RETURN.

    ENDIF.

**********************************************************************

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(gt_hdr)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_markitemr)
    BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item8)
    BY \_itemgtlet
        ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_itemlet) .

**********************************************************************
    lt_martable = VALUE #( FOR lsmar IN lt_markitemr
                         ( markno = lsmar-Matnr
                           length = lsmar-Length
                           balqty = lsmar-Reqty
                           reqty = lsmar-Reqty
                           process = lsmar-Operation
                           orderno = lsmar-Orderno ) ).
**********************************************************************
    DATA(ls_hdr1)  = gt_hdr[ 1 ].
    DATA(ls_uuid) = gt_hdr[ 1 ]-Uuid.
    DATA(ls_uwt) = gt_hdr[ 1 ]-Unitwet.
**********************************************************************

    DATA(ls_attachment) = keys[ 1 ]-%param-_streamproperties-zattachment.
    DATA(ls_filety) = keys[ 1 ]-%param-_streamproperties-MineType.

    IF ls_filety <> 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'.

      DATA(lv_msg2) = 'You Selected Wrong File Type'.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky ) TO failed-_hdr.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky
       %state_area    = 'Validate_Header'
       %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                  text     = lv_msg2 ) ) TO reported-_hdr .

      RETURN.

    ENDIF.

**********************************************************************

    IF ls_attachment IS NOT INITIAL.


      DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = ls_attachment )->read_access(  ).
      DATA(lo_worksheet) = lo_xlsx->get_workbook(  )->worksheet->at_position( 1 ).
      DATA(lo_select_patrn) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to(  )->from_row( xco_cp_xlsx=>coordinate->for_numeric_value( 1 ) )->get_pattern(   ).
      DATA(lo_execute) = lo_worksheet->select( lo_select_patrn )->row_stream(  )->operation->write_to( REF #( lt_excel ) ).
      lo_execute->set_value_transformation( xco_cp_xlsx_read_access=>value_transformation->string_value  )->if_xco_xlsx_ra_operation~execute(  ).


      TRY .
          lo_table_desc ?= cl_abap_tabledescr=>describe_by_data( p_data = lt_excel ).
          lo_struc_descr ?= lo_table_desc->get_table_line_type(  ).
          DATA(lv_no_of_cols) = lines( lo_struc_descr->components ).
        CATCH cx_sy_move_cast_error.

      ENDTRY.

    ENDIF.

**********************************************************************
    LOOP AT lt_excel INTO DATA(ls_file).

      CONCATENATE
        ls_file-clum1
        ls_file-clum2
        ls_file-clum3
        ls_file-clum4
        ls_file-clum5
        INTO DATA(lv_line).

      CONDENSE lv_line NO-GAPS.
      REPLACE ALL OCCURRENCES OF '.0'  IN lv_line WITH ''.
      APPEND lv_line TO lt_lines.

    ENDLOOP.

    DELETE lt_lines WHERE
      table_line CP 'No.#*'
      OR table_line CP '######*'.

**********************************************************************

    LOOP AT lt_lines INTO DATA(lv_line2).

      CLEAR: lt_fields, lv_header, lv_item.

      FIND REGEX
      '(^\d+of\d+#[0-9]+###\d+#[0-9]+#[0-9]+x$)|(^\d+\s*of\s*\d+#[0-9]+####\d+#[0-9]+\s*x$)'
      IN lv_line2.

      lv_header = xsdbool( sy-subrc = 0 ).

      " Detect ITEM line
      FIND REGEX '^\d+#[0-9]+####[0-9]+#[0-9]+$' IN lv_line2.
      lv_item = xsdbool( sy-subrc = 0 ).


      SPLIT lv_line2 AT '#' INTO TABLE lt_fields.

**********************************************************************

      IF lv_header = abap_true.
        CLEAR lno1.
        lno += 1.
        CLEAR ls_hdr.

        ls_hdr-uuid     = gt_hdr[ 1 ]-uuid.
        ls_hdr-srcid    = lno.
        ls_hdr-wast     = lt_fields[ 5 ].
        ls_hdr-srclent  = lt_fields[ 6 ].
        ls_hdr-srcpcs   = replace( val  = lt_fields[ 7 ]
                                   sub  = 'x'
                                   with = ''     ).

        wa_scrid = ls_hdr-srcid.

        APPEND ls_hdr TO zbp_pp_apps05_rv=>gt_item6.

**********************************************************************


      ELSEIF lv_item = abap_true.

        CLEAR ls_item.

        ls_item-uuid   = gt_hdr[ 1 ]-uuid.
        ls_item-srcid  = wa_scrid.
        ls_item-parid  = lt_fields[ 2 ].
        ls_item-length = lt_fields[ 6 ].
        ls_item-pcs    = lt_fields[ 7 ].


        APPEND ls_item TO zbp_pp_apps05_rv=>gt_iteb7.

        DATA lv_required TYPE menge_d.

        lv_required = ls_hdr-srcpcs * ls_item-pcs.

        LOOP AT lt_martable INTO DATA(ls_markno)
             WHERE length = ls_item-length
             AND balqty > 0.

          IF lv_required <= 0.
            EXIT.
          ENDIF.

          DATA: lv_allocate TYPE menge_d.

          IF ls_markno-balqty >= lv_required.
            lv_allocate = lv_required.
          ELSE.
            lv_allocate = ls_markno-balqty.
          ENDIF.

          " Create allocation line
          lno1 += 1.
          CLEAR ls_item2.

          ls_item2-uuid    = ls_item-uuid.
          ls_item2-srcid   = ls_item-srcid.
          ls_item2-parid   = lno1.
          ls_item2-length  = ls_markno-length.
          ls_item2-marno   = ls_markno-markno.
          ls_item2-pcs     = lv_allocate.
          ls_item2-process = ls_markno-process.
          ls_item2-orderno = ls_markno-orderno.
          ls_item2-totqty =  ( (  ( ls_item2-length * ls_uwt ) / 1000  ) * ls_item2-pcs ).
          ls_item2-atotqty = ( (  ( ls_hdr-srclent * ls_uwt ) / 1000  ) * ls_hdr-srcpcs ).
          IF ls_hdr-wast > 1000.
            ls_item2-lentqty = ( (  ( ls_hdr-wast * ls_uwt ) / 1000 ) * ls_hdr-srcpcs ) .
          ENDIF.
          " Reduce mark balance
          ls_markno-balqty = ls_markno-balqty - lv_allocate.
          ls_item2-balpcs  = ls_markno-balqty.

          MODIFY lt_martable FROM ls_markno.

          " Reduce required qty
          lv_required = lv_required - lv_allocate.

          APPEND ls_item2 TO zbp_pp_apps05_rv=>gt_iteb7A.

        ENDLOOP.
      ENDIF.
*
    ENDLOOP.



    SELECT  FROM @zbp_pp_apps05_rv=>gt_item6 AS _hdr
    LEFT JOIN @zbp_pp_apps05_rv=>gt_iteb7a AS _item ON _item~uuid = _hdr~uuid AND _item~srcid = _hdr~srcid
    FIELDS
    _hdr~srclent,
    _hdr~srcpcs,
    _hdr~actlent,
    _hdr~vrno,
    _item~srcid,
    _item~pcs,
    _item~totqty,
    _hdr~wast,
    _item~atotqty,
    _item~lentqty,
    _item~length
    WHERE _hdr~uuid = @ls_uuid
    INTO TABLE @DATA(lt_custb).
********************************Validation**************************************

    DATA(lt_source) = lt_custb.
    DATA(lt_parts) = lt_custb.

********************************************************************************

    LOOP AT lt_source INTO DATA(ls_source) GROUP BY ( srclent = ls_source-srclent ) INTO DATA(ls_citm).
      ls_source = VALUE #( lt_source[ srclent = ls_citm-srclent  ] OPTIONAL ).
      READ TABLE lt_stock INTO DATA(ls_t2)
        WITH KEY Length = ls_source-srclent.

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = ls_hdr1-%tky )
                          TO failed-_hdr.

        APPEND VALUE #( %tky           = ls_hdr1-%tky
                        %state_area    = 'Validate_Header'
                        %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                text     = |Source Length Not Exist { ls_source-srclent } | )   )
               TO reported-_hdr.
        RETURN.

      ENDIF.


    ENDLOOP.

    LOOP AT lt_parts INTO DATA(ls_parts) GROUP BY ( length = ls_parts-length ) INTO DATA(ls_pits).

      ls_parts = VALUE #( lt_parts[ length = ls_pits-length   ] OPTIONAL ).
      READ TABLE lt_itemlet INTO DATA(ls_t3)
        WITH KEY Length = ls_parts-length.

      IF sy-subrc <> 0.
        APPEND VALUE #( %tky = ls_hdr1-%tky )
                          TO failed-_hdr.

        APPEND VALUE #( %tky           = ls_hdr1-%tky
                        %state_area    = 'Validate_Header'
                        %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                                text     = |Part Length Not Exist { ls_parts-length } | )   )

               TO reported-_hdr.
        RETURN.

      ENDIF.

    ENDLOOP.







*****************************End Of Validation*************************************

    SELECT FROM @lt_custb AS cus
    FIELDS
    vrno,
    srclent,
    srcid,
    actlent,
    srcpcs,
    wast,
    SUM( totqty ) AS totqty,
     atotqty  AS atotqty,
      lentqty
    GROUP BY

    vrno,
    srclent,
    srcid,
    actlent,
    srcpcs,
    wast,
    atotqty,
    lentqty
    INTO TABLE @DATA(lt_totble) .


    LOOP AT lt_item8 INTO DATA(ls_item8).

      DATA(lv_req) = ls_item8-quantity.
*  DATA(lv_per_unit_wt) = ls_item8-quanwt / ls_item8-quantity.

      LOOP AT lt_totble INTO DATA(ls_totble)
           WHERE srclent = ls_item8-length AND srcpcs > 0 .

        " Stop if requirement fulfilled
        IF lv_req <= 0.
          EXIT.
        ENDIF.

        " Skip empty stock
        IF ls_totble-srcpcs <= 0.
          CONTINUE.
        ENDIF.

        DATA(lv_alloc) = 0.

        " Allocation logic
        IF ls_totble-srcpcs >= lv_req.
          lv_alloc = lv_req.
        ELSE.
          lv_alloc = ls_totble-srcpcs.
        ENDIF.

        " Build output row
        CLEAR ls_table8.
        ls_table8-sno       = ls_item8-sno.
        ls_table8-length    = ls_item8-length.
        ls_table8-apcs   = ls_item8-Quantity.
        ls_table8-used = lv_alloc.
        ls_table8-rqty   = ls_totble-totqty.
*        ls_table8-uqty = ls_totble-atotqty. old Logic
        ls_table8-uqty = ( (  ( ls_table8-length * ls_uwt ) / 1000  ) * ls_table8-used ).
        ls_table8-irno = ls_item8-Irno.
        ls_table8-matnr = ls_item8-Matnr.
        ls_table8-batch = ls_item8-Batch.
        ls_table8-storagelocation = ls_item8-Storagelocation.
        ls_table8-plant = ls_item8-Plant.
        ls_table8-uuid = ls_uuid.
        ls_table8-rtrn = ls_totble-lentqty.
        ls_table8-matnoitno = ls_item8-Matnoitno.



        APPEND ls_table8 TO lt_table8.

        " Reduce stock
        ls_totble-srcpcs = ls_totble-srcpcs - lv_alloc.
        MODIFY lt_totble FROM ls_totble.

        " Reduce requirement
        lv_req = lv_req - lv_alloc.

      ENDLOOP.

    ENDLOOP.
**********************************************************************

    SELECT  FROM @lt_table8
    AS tbl8
    FIELDS
    uuid,
    sno,
    length,
    apcs,
    SUM( used ) AS used,
    SUM( rqty ) AS rqty,
    SUM( uqty ) AS uqty,
    irno,
    matnr,
    batch,
    storagelocation,
    plant,
    matnoitno,
     SUM( rtrn ) AS rtrn
    GROUP BY
    sno,
    length,
    apcs,
    irno,
    matnr,
    batch,
    matnoitno,
    storagelocation,
    plant,
    uuid
    INTO TABLE @DATA(lt_tb8).
**********************************************************************

    TYPES : zdec10 TYPE p LENGTH 10 DECIMALS 0.

    DATA :
      lv_sqty TYPE menge_d,
      lv_pqty TYPE p LENGTH 10 DECIMALS 0,
      lv_cqty TYPE p LENGTH 10 DECIMALS 0.
**********************************************************************
    lv_sqty = REDUCE dmbtr(
      INIT i TYPE dmbtr
      FOR ls_i IN lt_tb8
      WHERE ( uuid  = ls_hdr1-Uuid )
      NEXT i = i + ls_i-uqty ).

    lv_cqty = REDUCE zdec10(
      INIT s TYPE zdec10
      FOR ls_ia IN zbp_pp_apps05_rv=>gt_iteb7a
      WHERE ( uuid  = ls_hdr1-Uuid )
      NEXT s = s + ls_ia-pcs ).

    lv_pqty = REDUCE zdec10(
    INIT p TYPE zdec10
    FOR ls_ias IN lt_markitemr
    WHERE ( uuid  = ls_hdr1-Uuid )
    NEXT p = p + ls_ias-Reqty ).



**********************************************************************

    IF  lv_sqty > ls_hdr1-Totwithst  .
      APPEND VALUE #( %tky = ls_hdr1-%tky )
                            TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr1-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = |Stock Pcs OR Stock Is GT { ls_hdr1-Totwithst } | )   )

             TO reported-_hdr.

      RETURN.



    ENDIF.

    IF lv_cqty <> lv_pqty .
      APPEND VALUE #( %tky = ls_hdr1-%tky )
                              TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr1-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = |Pcs Is not Matched { lv_cqty } | )   )

             TO reported-_hdr.

      RETURN.



    ENDIF.




**********************************************************************



**********************************************************************

    IF lt_tb8 IS NOT INITIAL.
      MOVE-CORRESPONDING lt_tb8 TO zbp_pp_apps05_rv=>gt_item8.
    ENDIF.

**********************************************************************

    gt_item8 = VALUE #( ( %cid_ref = keys[ 1 ]-%cid_ref
        %is_draft = keys[ 1 ]-%is_draft
        Uuid = keys[ 1 ]-Uuid
        %target = VALUE #( FOR ls6 IN zbp_pp_apps05_rv=>gt_item8 ( %cid = keys[ 1 ]-%cid_ref
        %is_draft = keys[ 1 ]-%is_draft
        %data = VALUE #( Uuid = keys[ 1 ]-Uuid
        Sno = ls6-sno
        Irno = ls6-irno
        Length = ls6-length
        Apcs = ls6-apcs
        Used = ls6-used
        Uqty = ls6-uqty
        matnr = ls6-matnr
        batch = ls6-batch
        storagelocation = ls6-storagelocation
        plant = ls6-plant
        Vrno = ls6-vrno
        Rqty = ls6-rqty
        Rtrn = ls6-rtrn
        Matnoitno = ls6-matnoitno
        )
        %control = VALUE #( Uuid = if_abap_behv=>mk-on
        Length = if_abap_behv=>mk-on
        Sno = if_abap_behv=>mk-on
        Irno = if_abap_behv=>mk-on
         Uqty = if_abap_behv=>mk-on
        Apcs = if_abap_behv=>mk-on
         Used = if_abap_behv=>mk-on
        matnr = if_abap_behv=>mk-on
        batch = if_abap_behv=>mk-on
        storagelocation = if_abap_behv=>mk-on
        plant = if_abap_behv=>mk-on
        Vrno = if_abap_behv=>mk-on
        Rqty = if_abap_behv=>mk-on
        Rtrn = if_abap_behv=>mk-on
Matnoitno =  if_abap_behv=>mk-on
         )
         ) )
        ) ).
**********************************************************************
    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    CREATE BY \_itemsumry
    AUTO FILL CID WITH gt_item8.
**********************************************************************


    gt_item6        = VALUE #(   ( %cid_ref = keys[ 1 ]-%cid_ref
                                 %is_draft = keys[ 1 ]-%is_draft
                                 Uuid = keys[ 1 ]-Uuid
    %target         = VALUE #(   FOR ls3 IN zbp_pp_apps05_rv=>gt_item6
                                 ( %cid = keys[ 1 ]-%cid_ref
                                   %is_draft = keys[ 1 ]-%is_draft
    %data           = VALUE #(     Uuid = keys[ 1 ]-Uuid
                                   Srcid    = ls3-srcid
                                   Srclent  = ls3-srclent
**********************************************************************

    Lengthstr       = REDUCE string( INIT result1 TYPE string
                                     FOR ls2 IN zbp_pp_apps05_rv=>gt_iteb7
                                     WHERE ( srcid = ls3-srcid )
                                     NEXT result1 =
                                     COND string(
                                     WHEN result1 IS INITIAL
                                     THEN |{ ls2-length } x { ls2-pcs }|
                                     ELSE |{ result1 } + { ls2-length } x { ls2-pcs }|  )   )

**********************************************************************

   Actlent           = REDUCE  leng( INIT    actlen  TYPE decfloat16
                                     FOR ls2 IN zbp_pp_apps05_rv=>gt_iteb7
                                     WHERE ( srcid = ls3-srcid )
                                     NEXT
                                     actlen  = actlen + ( ls2-length * ls2-pcs )    )

**********************************************************************

                                Rtnlent    = ls3-rtnlent
                                Srcpcs     = ls3-srcpcs
                                Totlen     = ls3-totlen
                                Trmwste    = ls3-trmwste
                                Wast       = ls3-wast           )
   %control           = VALUE #( Srcid    = if_abap_behv=>mk-on
    							 Srclent  = if_abap_behv=>mk-on
    							 Lengthstr = if_abap_behv=>mk-on
    							 Actlent  = if_abap_behv=>mk-on
    							 Rtnlent  = if_abap_behv=>mk-on
    							 Srcpcs   = if_abap_behv=>mk-on
    							 Totlen   = if_abap_behv=>mk-on
    							 Trmwste  = if_abap_behv=>mk-on
    							 Wast     = if_abap_behv=>mk-on  )
    ) )  ) ).
**********************************************************************
    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
       ENTITY _hdr CREATE BY \_itemrsult
       AUTO FILL CID WITH   gt_item6
       MAPPED DATA(lt_mapped).
**********************************************************************

*LOOP AT zbp_pp_apps05_rv=>gt_item6 into data(ls_tabl5).
    LOOP AT lt_mapped-_itemrsult INTO DATA(ls_tabl5).

      gt_item7          =  VALUE #(  (
                                    %cid_ref    = keys[ 1 ]-%cid_ref
                                    %is_draft   = ls_tabl5-%is_draft
                                    Uuid        = ls_tabl5-Uuid
                                    Srcid       = ls_tabl5-Srcid

      %target        = VALUE #(     FOR ls4 IN zbp_pp_apps05_rv=>gt_iteb7a
                                    WHERE ( srcid   = ls_tabl5-srcid )
                                  (  %cid         = keys[ 1 ]-%cid_ref
                                     %is_draft    = ls_tabl5-%is_draft

      %data          = VALUE #(      Uuid       = ls_tabl5-Uuid
                                     Srcid      = ls4-srcid
                                     Parid      = ls4-parid
                                     Marno      = ls4-marno
                                     Pcs        = ls4-pcs
                                     Balpcs     = ls4-balpcs
                                     Length     = ls4-length
                                     Process    = ls4-process
                                     Orderno    = ls4-orderno
                                     Totqty     = ls4-totqty
                                     lentqty    = ls4-lentqty   )

      %control       = VALUE #(      Srcid      =  if_abap_behv=>mk-on
        							 Parid      =  if_abap_behv=>mk-on
        							 Marno      =  if_abap_behv=>mk-on
        							 Pcs        =  if_abap_behv=>mk-on
        							 Balpcs     =  if_abap_behv=>mk-on
        							 Length     =  if_abap_behv=>mk-on
        							 Process    =  if_abap_behv=>mk-on
        							 Orderno    =  if_abap_behv=>mk-on
        							 Totqty     =  if_abap_behv=>mk-on
        							 lentqty    =  if_abap_behv=>mk-on


   )
  ) )  ) ) .
**********************************************************************
      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
      ENTITY _itemrsult CREATE BY \_citem
      AUTO FILL CID WITH gt_item7
      FAILED DATA(lt_fieled)
      MAPPED DATA(lt_mapded).
**********************************************************************
    ENDLOOP.
**********************************************************************
    result = VALUE #( FOR ls7 IN gt_hdr
                ( %tky = ls7-%tky
                  %param = ls7 ) ).
**********************************************************************
  ENDMETHOD.

  METHOD GtOpers.

***********************************************************************
**********************************************************************

    DATA: nr_number    TYPE cl_numberrange_runtime=>nr_number,
          lv_jobsht    TYPE string,
          lv_count     TYPE i,
          lv_operation TYPE c LENGTH 40. "same type as OPERATION

**********************************************************************
**********************************************************************

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

**********************************************************************

    IF lt_item[ 1 ]-Jobsht IS NOT INITIAL.




    ELSE.

      SORT lt_item BY MATNR.

      SORT lt_item BY  operation.



      CLEAR: lv_count, lv_operation.

**********************************************************************

      LOOP AT lt_item ASSIGNING FIELD-SYMBOL(<fsitem>).

        " New operation → reset counter
        IF lv_operation IS INITIAL OR lv_operation <> <fsitem>-operation.
          CLEAR lv_count.
          lv_operation = <fsitem>-operation.
        ENDIF.

        " Every 10 rows → generate new JobSheet
        IF lv_count MOD 10 = 0.
          TRY.
              cl_numberrange_runtime=>number_get(
                EXPORTING
                  nr_range_nr = '01'
                  object      = 'ZPP_JOBNR'
                IMPORTING
                  number      = nr_number ).

              IF nr_number IS NOT INITIAL.
                DATA(lv_numb) = nr_number+15(5).
                lv_jobsht = |JC{ sy-datum+2(2) }{ sy-datum+4(2) }-{ lv_numb }|.
              ENDIF.

            CATCH cx_nr_object_not_found  cx_number_ranges.
              DATA(lv_error) = 1.
          ENDTRY.
        ENDIF.

        lv_count = lv_count + 1.
        <fsitem>-jobsht = lv_jobsht.
        MOVE-CORRESPONDING lt_item TO zbp_pp_apps05_rv=>gt_item2.
      ENDLOOP.
**********************************************************************
**********************************************************************

      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE ENTITY _itemftmark
      UPDATE FROM  VALUE #( FOR lsitem IN zbp_pp_apps05_rv=>gt_item2 ( Uuid = lsitem-uuid
                            Sno = lsitem-sno
                            %is_draft = keys[ 1 ]-%is_draft
                            Jobsht = lsitem-jobsht
       %control-Jobsht     = if_abap_behv=>mk-on ) )
       MAPPED DATA(ls_mapped1)
       FAILED DATA(ls_failed1)
       REPORTED DATA(ls_reported1).

**********************************************************************
**********************************************************************

    ENDIF.

    result = VALUE #(
      FOR ls IN lt_hdr
      ( %tky   = ls-%tky
        %param = ls )
    ).

  ENDMETHOD.

  METHOD Vtoncrt.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_markqt)
    BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_stock).
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    IF ls_hdr-Chckmrk IS INITIAL.
      APPEND VALUE #( %tky = ls_hdr-%tky )
               TO failed-_hdr.
    ENDIF.
**********************************************************************
  ENDMETHOD.

  METHOD gt_uporder.

**********************************************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemftmark
     ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item)
    BY \_itemsumry
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item8).
**********************************************************************

    IF lt_hdr[ 1 ]-Chckmrk IS NOT INITIAL.

**********************************************************************
      IF lt_item8 IS NOT INITIAL.

        MODIFY ENTITIES OF i_materialdocumenttp PRIVILEGED
        ENTITY MaterialDocument
        CREATE FROM VALUE #( ( %cid                          = 'CID_001'
                               goodsmovementcode             = '04'
                               postingdate                   = cl_abap_context_info=>get_system_date( )
                               documentdate                  = cl_abap_context_info=>get_system_date( )
                               %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
                               %control-postingdate                          = cl_abap_behv=>flag_changed
                               %control-documentdate                         = cl_abap_behv=>flag_changed
                           ) )
        ENTITY MaterialDocument
        CREATE BY \_MaterialDocumentItem
        FROM VALUE #( FOR ls1 IN lt_item8 INDEX INTO idx (
                        %cid_ref = 'CID_001'
                        %target = VALUE #( ( %cid                               = 'CID_ITM_' && idx
                                             GoodsMovementType                  = '311'
                                             plant                              = ls1-plant
                                             material                           = ls1-matnr
                                             storagelocation                    = ls1-Storagelocation
                                             QuantityInEntryUnit                = ls1-Uqty
                                             entryunit                          = 'KG'
                                             Batch                              = ls1-batch
                                             IssuingOrReceivingPlant            = ls1-Plant
                                             IssgOrRcvgMaterial                 = ls1-Matnr
                                             IssuingOrReceivingStorageLoc       = 'SF01'
                                             IssgOrRcvgBatch                    = ls1-batch
                                             YY1_Length_No_MMI                  = ls1-Length
                                             YY1_Pieces_No_MMI                  = ls1-Used
****************************************************************************************************************
****************************************************************************************************************
                                             %control-plant                         = cl_abap_behv=>flag_changed
                                             %control-material                      = cl_abap_behv=>flag_changed
                                             %control-GoodsMovementType             = cl_abap_behv=>flag_changed
                                             %control-storagelocation               = cl_abap_behv=>flag_changed
                                             %control-QuantityInEntryUnit           = cl_abap_behv=>flag_changed
                                             %control-entryunit                     = cl_abap_behv=>flag_changed
                                             %control-Batch                         = cl_abap_behv=>flag_changed
                                             %control-IssuingOrReceivingPlant       = cl_abap_behv=>flag_changed
                                             %control-IssgOrRcvgMaterial            = cl_abap_behv=>flag_changed
                                             %control-IssuingOrReceivingStorageLoc  = cl_abap_behv=>flag_changed
                                             %control-IssgOrRcvgBatch               = cl_abap_behv=>flag_changed
                                             %control-YY1_Length_No_MMI             = cl_abap_behv=>flag_changed
                                             %control-YY1_Pieces_No_MMI             = cl_abap_behv=>flag_changed


                                         ) )


                    ) )
        MAPPED   DATA(ls_create_mapped)
        FAILED   DATA(ls_create_failed)
        REPORTED DATA(ls_create_reported).
****************************************************************************************************************
****************************************************************************************************************
        IF ls_create_failed IS INITIAL.
          zbp_pp_apps05_rv=>cv_mat_doc = ls_create_mapped.
        ELSE.

        ENDIF.
****************************************************************************************************************
      ENDIF.

    ELSE.

**********************************************************************

      DATA(lv_msg4) = |Please Click On Check Button|.

      APPEND VALUE #( %tky           = lt_hdr[ 1 ]-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg4 )   ) TO reported-_hdr.
    ENDIF.

**********************************************************************
**********************************************************************
  ENDMETHOD.

  METHOD GtCheck.

*********************************Header_Details*************************************
    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemgtlet
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gitm)
    BY \_itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gmitm)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_fmitm)
    BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gsitm)
    BY \_itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_fsitm)
    BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(LT_rsult).
**********************************************************************
**********************************************************************

    DATA(ls_hdr) =   lt_hdr[ 1 ] .
**********************************************************************

    SELECT SINGLE FROM @lt_fmitm AS item FIELDS SUM( Netwt ) AS netwt WHERE Uuid = @ls_hdr-Uuid INTO @DATA(ls_marqty).
    SELECT SINGLE FROM @lt_gsitm AS stc FIELDS SUM( Quanwt ) AS qty WHERE Uuid = @ls_hdr-Uuid INTO @DATA(ls_stqt).
    SELECT SINGLE FROM @lt_fmitm AS item2 FIELDS Jobsht AS job WHERE uuid = @ls_hdr-Uuid INTO @DATA(ls_oper).

**********************************************************************

    IF lt_gmitm IS INITIAL.
      DATA(lv_msg1) = |Please Click On Get Mark Number Button|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg1 )   )
             TO reported-_hdr.
**********************************************************************

    ELSEIF lt_fmitm IS INITIAL  .
      DATA(lv_msg2) = |Please Select The Materials|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg2 )   )
             TO reported-_hdr.

**********************************************************************

    ELSEIF lt_gitm IS INITIAL.

      DATA(lv_msg3) = |Please Click On Get Length Details|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg3 )   )
             TO reported-_hdr.

**********************************************************************
    ELSEIF lt_fsitm IS INITIAL.

      DATA(lv_msg4) = |Please Click On Fetch Stock Details|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg4 )   )
             TO reported-_hdr.

**********************************************************************

    ELSEIF lt_gsitm IS INITIAL.

      DATA(lv_msg5) = |Please Select The Stocks |.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg5 )   )
             TO reported-_hdr.

**********************************************************************

    ELSEIF ls_marqty > ls_stqt.

      DATA(lv_msg6) = |Mark Qty { ls_marqty } > Stock Qty { ls_stqt }|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg6 )   )
             TO reported-_hdr.

**********************************************************************
    ELSEIF lt_rsult IS INITIAL AND ls_hdr-Vrcuting = 'CI'.
      DATA(lv_msg8) = |Please Integrate to Cut Logic|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg8 )   )
             TO reported-_hdr.

**********************************************************************

    ELSEIF ls_oper IS INITIAL.

      DATA(lv_msg7) = |Please Click On Group Operation Button|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg7 )   )
             TO reported-_hdr.
**********************************************************************

    ELSE.
      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
         ENTITY _hdr
         UPDATE FROM VALUE #( ( %tky = ls_hdr-%tky
         Chckmrk = 'X'
         %control-Chckmrk = if_abap_behv=>mk-on
          ) )
          MAPPED DATA(ls_mapped)
          FAILED DATA(ls_failed)
          REPORTED DATA(ls_reported).
**********************************************************************
      IF ls_failed IS INITIAL.
        DATA(lv_msg9) = |successfully Checked|.

        APPEND VALUE #( %tky           = ls_hdr-%tky
                        %state_area    = 'Validate_Header'
                        %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                                text     = lv_msg9 )   )
               TO reported-_hdr.


      ENDIF.

**********************************************************************
    ENDIF.

    result = VALUE #(
        FOR ls IN lt_hdr
        ( %tky   = ls-%tky
          %param = ls )
      ).

**********************************************************************
  ENDMETHOD.

  METHOD GtDelete.
**********************************************************************
    DATA : ls_del TYPE zpp_apps05_delim.

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemgtlet
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gitm)
    BY \_itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gmitm)
    BY \_itemftmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_fmitm)
    BY \_itemgtstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_gsitm)
    BY \_itemftstock
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_fsitm)
    BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(LT_rsult)
     BY \_itemsumry
     ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_sumry)
    ENTITY _itemrsult BY \_citem
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_citem)
    .
**********************************************************************
    DATA(ls_hdr) = lt_hdr[ 1 ].

    IF keys[ 1 ]-%param-Deletet IS INITIAL.

      APPEND VALUE #(  %tky = ls_hdr-%tky
      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
      text = |Please Maintain The Reason For Deletion| )
        ) TO reported-_hdr.
      APPEND VALUE #( %tky = lt_hdr[ 1 ]-%tky  ) TO failed-_hdr.

      RETURN.

    ENDIF.

    ls_del-vrno = ls_hdr-Vrno.
    ls_del-matno = ls_hdr-Matno.
    ls_del-delet = keys[ 1 ]-%param-Deletet.
    ls_del-uuid  = ls_hdr-Uuid.


    APPEND ls_del TO zbp_pp_apps05_rv=>gt_del.



    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE

          ENTITY _hdr
            DELETE FROM VALUE #( FOR <fs_hdr> IN lt_hdr ( %tky = <fs_hdr>-%tky ) )

          ENTITY _itemgtlet
            DELETE FROM VALUE #( FOR <fs_gitm> IN lt_gitm ( %tky = <fs_gitm>-%tky ) )

          ENTITY _itemgtmark
            DELETE FROM VALUE #( FOR <fs_gmitm> IN lt_gmitm ( %tky = <fs_gmitm>-%tky ) )

          ENTITY _itemftmark
            DELETE FROM VALUE #( FOR <fs_fmitm> IN lt_fmitm ( %tky = <fs_fmitm>-%tky ) )

          ENTITY _itemgtstock
            DELETE FROM VALUE #( FOR <fs_gsitm> IN lt_gsitm ( %tky = <fs_gsitm>-%tky ) )

          ENTITY _itemftstock
            DELETE FROM VALUE #( FOR <fs_fsitm> IN lt_fsitm ( %tky = <fs_fsitm>-%tky ) )

          ENTITY _itemrsult
            DELETE FROM VALUE #( FOR <fs_rsult> IN lt_rsult ( %tky = <fs_rsult>-%tky ) )

          ENTITY _itemsumry
            DELETE FROM VALUE #( FOR <fs_sumry> IN lt_sumry ( %tky = <fs_sumry>-%tky ) )

          ENTITY _item7
            DELETE FROM VALUE #( FOR <fs_citem> IN lt_citem ( %tky = <fs_citem>-%tky ) )

          FAILED   DATA(lt_deep_failed)
          REPORTED DATA(lt_deep_reported).

    " Forward any execution failures up to the runtime orchestration engine
    failed   = CORRESPONDING #( DEEP lt_deep_failed ).
    reported = CORRESPONDING #( DEEP lt_deep_reported ).


    IF failed IS INITIAL.
      APPEND VALUE #(
          %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-information
                    text     = 'Data Deleted Successfully'
                 )
      ) TO reported-_hdr.
      mapped-_hdr = VALUE #( BASE mapped-_hdr FOR lse IN keys ( %pky = lse-%pky ) ).
*      result = value #( base result for lsk in keys ( %pky = lsk-%pky ) ).
    ENDIF.

*    CLEAR result.














**********************************************************************





  ENDMETHOD.

  METHOD gt_plant.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
   ENTITY _hdr
   UPDATE FROM VALUE #( ( Uuid = ls_hdr-Uuid
   %is_draft = ls_hdr-%is_draft
   Werks = '1030'
   %control-Werks = if_abap_behv=>mk-on
    ) )
    MAPPED DATA(ls_mapped1)
    FAILED DATA(ls_failed1)
    REPORTED DATA(ls_reported1).
**********************************************************************


  ENDMETHOD.

  METHOD Gtcheckst.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_itemsumry
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item8).
**********************************************************************

    DATA(ls_hdr) = lt_hdr[ 1 ].

**********************************************************************
    SELECT FROM @lt_item8 AS hdr
    INNER JOIN I_StockQuantityCurrentValue_2( p_displaycurrency = 'INR' ) AS st ON st~Product = hdr~Matnr AND
    st~Plant = hdr~Plant AND st~StorageLocation = hdr~Storagelocation AND st~Batch = hdr~Batch AND st~ValuationAreaType = '1'
    FIELDS
    hdr~Matnr,
    hdr~Batch,
    hdr~Uqty,
    st~MatlWrhsStkQtyInMatlBaseUnit
    INTO TABLE @DATA(lt_sstock).

    SELECT SINGLE FROM @lt_item8 AS item FIELDS SUM( Uqty ) AS netwt WHERE Uuid = @ls_hdr-Uuid INTO @DATA(ls_marqty).
*    SELECT SINGLE FROM @lt_gsitm AS stc FIELDS SUM( Quanwt ) AS qty WHERE Uuid = @ls_hdr-Uuid INTO @DATA(ls_stqt).

    DATA lv_er TYPE c LENGTH 1.

    IF ls_hdr-Totwithmk > ls_marqty.
      DATA(lv_msg6) = |Mark Qty { ls_hdr-Totwithmk } > Stock Qty { ls_marqty }|.
      APPEND VALUE #( %tky = ls_hdr-%tky )
                  TO failed-_hdr.

      APPEND VALUE #( %tky           = ls_hdr-%tky
                      %state_area    = 'Validate_Header'
                      %msg           = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                              text     = lv_msg6 )   )
             TO reported-_hdr.
      RETURN.

    ENDIF.



    LOOP AT lt_sstock INTO DATA(ls_stock).
      IF ls_stock-MatlWrhsStkQtyInMatlBaseUnit < ls_stock-Uqty.
        APPEND VALUE #( %tky = ls_hdr-%tky  ) TO failed-_hdr.
        APPEND VALUE #(  %tky = ls_hdr-%tky
             %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
             text = |{ ls_stock-Matnr } BAL { ls_stock-MatlWrhsStkQtyInMatlBaseUnit } GT { ls_stock-Uqty } DIF{ ls_stock-MatlWrhsStkQtyInMatlBaseUnit - ls_stock-Uqty }| )
               ) TO reported-_hdr.
        lv_er = 'X'.
        CONTINUE.
      ENDIF.

    ENDLOOP.




    IF lv_er IS INITIAL.
*APPEND VALUE #(  %tky = ls_hdr-%tky
*             %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information
*             text = |No Stock issue you can proceed| )
*               ) TO reported-_hdr.

      MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
     ENTITY _hdr
     UPDATE FROM VALUE #( ( Uuid = ls_hdr-Uuid
     %is_draft = ls_hdr-%is_draft
     Status = 'S'
     %control-Status = if_abap_behv=>mk-on
      ) )
      MAPPED DATA(ls_mapped1)
      FAILED DATA(ls_failed1)
      REPORTED DATA(ls_reported1).

    ENDIF.

    result = VALUE #(
     FOR ls IN lt_hdr
     ( %tky   = ls-%tky
       %param = ls )
   ).

**********************************************************************
  ENDMETHOD.

  METHOD gt_uintwt.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv
    IN LOCAL MODE
    ENTITY _hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

    DATA(ls_hdr) = lt_hdr[ 1 ].

    SELECT SINGLE FROM i_product FIELDS yy1_unit_wgt_prd WHERE  Product = @ls_hdr-Sectmat INTO @DATA(ls_unit).
**********************************************************************
    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
   ENTITY _hdr
   UPDATE FROM VALUE #( ( Uuid = ls_hdr-Uuid
   %is_draft = ls_hdr-%is_draft
   Unitwet = ls_unit
   %control-Unitwet = if_abap_behv=>mk-on
    ) )
    MAPPED DATA(ls_mapped1)
    FAILED DATA(ls_failed1)
    REPORTED DATA(ls_reported1).
**********************************************************************
  ENDMETHOD.

  METHOD Gtstockclr.
  ENDMETHOD.

ENDCLASS.

CLASS lhc__item1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR _itemgtmark RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR _itemgtmark RESULT result.

    METHODS GtSelec FOR MODIFY
      IMPORTING keys FOR ACTION _itemgtmark~GtSelec RESULT result.
    METHODS reqty_val FOR VALIDATE ON SAVE
      IMPORTING keys FOR _itemgtmark~reqty_val.

ENDCLASS.

CLASS lhc__item1 IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_apps05_rv  IN LOCAL MODE ENTITY _itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT FINAL(lt_item).
**********************************************************************
    READ ENTITY IN LOCAL MODE zpp_apps05_rv BY \_itemrsult
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_rsult).
**********************************************************************
    result                          = VALUE #( FOR ls_item IN lt_item
                                                   ( %tky = ls_item-%tky

    %action-GtSelec                 = COND  #( WHEN ls_item-Reqty <> 0 AND lt_rsult IS INITIAL
                                                    THEN if_abap_behv=>fc-o-enabled
                                                    ELSE
                                                    if_abap_behv=>fc-o-disabled  )

    %features-%field-Reqty          = COND #( WHEN ls_item-Totopnqty = 0
                                                    THEN if_abap_behv=>fc-f-read_only
                                                    ELSE if_abap_behv=>fc-f-unrestricted  )

    %features-%update               = COND  #( WHEN lt_rsult IS INITIAL
                                                             THEN if_abap_behv=>fc-o-enabled
                                                             ELSE
                                                             if_abap_behv=>fc-o-disabled )

                                                                ) ).
**********************************************************************


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GtSelec.
**********************************************************************
**********************************************************************

    DATA nr_number      TYPE cl_numberrange_runtime=>nr_number.
    DATA : gtitem    TYPE TABLE OF zpp_apps05_itb,
           gsitem    TYPE zpp_apps05_itb,
           gs_item2  TYPE zpp_apps05_itb2,
           gs_hdr    TYPE zpp_apps05_htb,
           gt_item2  TYPE TABLE FOR CREATE zpp_apps05_rv\_itemftmark,
           lv_totwt1 TYPE p LENGTH 15 DECIMALS 3.

**********************************************************************

    READ ENTITIES OF zpp_apps05_rv
    IN LOCAL MODE ENTITY _itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item1)
    BY \_hdr
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).


**********************************************************************
    DATA(ls_item1) = lt_item1[ 1 ].
**********************************************************************
    IF ls_item1-Reqty > ls_item1-Totopnqty.
      APPEND VALUE #(  %tky = ls_item1-%tky
      %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
      text = |Requested Qty { ls_item1-Reqty } exceeds Open Qty { ls_item1-Totopnqty }| )
        ) TO reported-_itemgtmark.
      APPEND VALUE #( %tky = ls_item1-%tky  ) TO failed-_itemgtmark.

      RETURN.

    ENDIF.
**********************************************************************

*    IF ls_item1-%is_draft IS  INITIAL.
    MOVE-CORRESPONDING ls_item1 TO gsitem.

**********************************************************************

    SELECT SINGLE SUM( reqty ) AS totqty
    FROM zpp_apps05_ditb2 WHERE uuid = @ls_item1-Uuid AND orderno = @ls_item1-Orderno AND matnr = @ls_item1-Matnr AND draftentityoperationcode <> 'L'  INTO @DATA(wa_ord).

*    SELECT  SINGLE * FROM  zpp_apps05_htb   WHERE uuid = @ls_item1-Uuid INTO  @DATA(ls_hdr).

    IF wa_ord IS NOT INITIAL.
      gsitem-totreqty = wa_ord + ls_item1-Reqty.
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.
    ELSE.
      gsitem-totreqty = ls_item1-Reqty .
      gsitem-totopnqty = gsitem-plnqty - gsitem-totreqty.

    ENDIF.

**********************************************************************

    APPEND gsitem TO gtitem.

**********************************************************************

    SELECT SINGLE MAX( sno ) AS sno FROM zpp_apps05_ditb2  WHERE uuid = @ls_item1-Uuid INTO @DATA(LV_Sno).

**********************************************************************

    IF gtitem IS NOT INITIAL.

**********************************************************************
      zbp_pp_apps05_rv=>gt_item2 =  VALUE #( FOR ls IN gtitem INDEX INTO lv WHERE ( reqty <> 0 )  (
                                                            uuid        =   ls-uuid
                                                            sno         =   lv_sno + lv
                                                            vrno        =   lt_hdr[ 1 ]-vrno
                                                            matnr       =   ls-matnr
                                                            orderno     =   ls-orderno
                                                            reqty       =   ls-reqty
                                                            uom         =   ls-uom
                                                            plant       =   ls-plant
                                                            vbeln       =   ls-vbeln
                                                            plnqty      =   ls-plnqty
                                                            maktx       =   ls-maktx
                                                            length      =   ls-length
                                                            width       =   ls-width
**********************************************************************
                                                            wetpc       =  COND #(  WHEN ls-width IS INITIAL
                                                                           THEN
                                                                           ls-length * lt_hdr[ 1 ]-unitwet  / 1000
                                                                           ELSE
                                                                           ls-length * ls-width * lt_hdr[ 1 ]-unitwet / 1000000 )
**********************************************************************
                                                            netwt       =  COND #( WHEN ls-width IS INITIAL
                                                                           THEN
                                                                             ls-length * lt_hdr[ 1 ]-unitwet  / 1000 * ls-reqty
                                                                           ELSE
                                                                             ls-length * ls-width * lt_hdr[ 1 ]-unitwet / 1000000 * ls-reqty )

                                                            operation   = ls-operation
                                                            resv        = ls-rsnum
                                                                                    ) ).
**********************************************************************

      gt_item2        =      VALUE #( (  %cid_ref = keys[ 1 ]-%cid_ref
                             %is_draft = keys[ 1 ]-%is_draft
                             Uuid = keys[ 1 ]-Uuid
      %target         =      VALUE #( FOR ls3 IN zbp_pp_apps05_rv=>gt_item2 (
                             %cid = keys[ 1 ]-%cid_ref
      %is_draft       =      keys[ 1 ]-%is_draft

      %data           =      VALUE #( Uuid      = keys[ 1 ]-Uuid
                                      Orderno   = ls3-orderno
                                      Sno       = ls3-sno
                                      matnr     = ls3-matnr
                                      reqty     = ls3-reqty
                                      uom       = ls3-uom
                                      plant     = ls3-plant
                                      vbeln     = ls3-vbeln
                                      plnqty    = ls3-plnqty
                                      maktx     = ls3-maktx
                                      length    = ls3-length
                                      width     = ls3-width
                                      wetpc     = ls3-wetpc
                                      netwt     = ls3-netwt
                                      operation = ls3-operation
                                      Resv      = ls3-resv  )

      %control       =      VALUE #(  uuid         = if_abap_behv=>mk-on
                                      sno          = if_abap_behv=>mk-on
                                      matnr        = if_abap_behv=>mk-on
									  orderno      = if_abap_behv=>mk-on
									  reqty        = if_abap_behv=>mk-on
									  uom          = if_abap_behv=>mk-on
									  plant        = if_abap_behv=>mk-on
									  vbeln        = if_abap_behv=>mk-on
									  plnqty       = if_abap_behv=>mk-on
									  maktx        = if_abap_behv=>mk-on
									  length       = if_abap_behv=>mk-on
									  width        = if_abap_behv=>mk-on
									  wetpc        = if_abap_behv=>mk-on
									  netwt        = if_abap_behv=>mk-on
									  operation    = if_abap_behv=>mk-on
									  Resv         = if_abap_behv=>mk-on         ) ) )  ) ).

    ENDIF.
**********************************************************************

    gsitem-reqty = gsitem-totopnqty .

**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _itemgtmark
    UPDATE FROM VALUE #( ( %tky        = ls_item1-%tky
                           totopnqty   = gsitem-totopnqty
                           totreqty    = gsitem-totreqty
                           Reqty       = gsitem-reqty

                    %control-Totopnqty = if_abap_behv=>mk-on
                    %control-Totreqty  = if_abap_behv=>mk-on
                    %control-Reqty     = if_abap_behv=>mk-on ) )
    MAPPED      DATA(ls_mapped)
    FAILED      DATA(ls_failed)
    REPORTED    DATA(ls_reported).

**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr CREATE BY \_itemftmark
    AUTO FILL CID WITH   gt_item2.

**********************************************************************

    SELECT SINGLE  FROM    zpp_apps05_dthb  FIELDS totwithmk WHERE uuid = @ls_item1-Uuid INTO @DATA(lv_totwt).
    IF lv_totwt IS NOT INITIAL.
      lv_totwt1 =  zbp_pp_apps05_rv=>gt_item2[ 1 ]-netwt + lv_totwt.
    ELSE .
      lv_totwt1 = zbp_pp_apps05_rv=>gt_item2[ 1 ]-netwt.
    ENDIF.

**********************************************************************

    MODIFY ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _hdr
    UPDATE FROM VALUE #( ( Uuid = ls_item1-Uuid
    %is_draft = ls_item1-%is_draft
    Totwithmk = lv_totwt1
    %control-Totwithmk = if_abap_behv=>mk-on
     ) )
     MAPPED DATA(ls_mapped1)
     FAILED DATA(ls_failed1)
     REPORTED DATA(ls_reported1).

**********************************************************************
  ENDMETHOD.

  METHOD reqty_val.

**********************************************************************

    READ ENTITIES OF zpp_apps05_rv IN LOCAL MODE
    ENTITY _itemgtmark
    ALL FIELDS WITH CORRESPONDING #( keys  )
    RESULT DATA(lt_item).

*    reported-_itemgtmark = VALUE #( FOR ls IN lt_item ( %tky =  ls-%tky
*    %msg = COND #( WHEN ls-Reqty > ls-Totopnqty
*    THEN
*
*     new_message_with_text( severity = if_abap_behv_message=>severity-error
*    text = |Requested Qty { ls-Reqty } exceeds Open Qty { ls-Totopnqty }| )
*
*    ELSE
*      new_message_with_text( severity = if_abap_behv_message=>severity-success
*    text = |Requested Qty { ls-Reqty } Ok| )
*      )
*        ) ) .

**********************************************************************
    LOOP AT lt_item INTO DATA(ls1).
      IF ls1-Reqty > ls1-Totopnqty.
        APPEND VALUE #(  %tky = ls1-%tky
        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
    text = |Requested Qty { ls1-Reqty } exceeds Open Qty { ls1-Totopnqty }| )
          ) TO reported-_itemgtmark.
        APPEND VALUE #( %tky = ls1-%tky  ) TO failed-_itemgtmark.
      ENDIF.
    ENDLOOP.
**********************************************************************


  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS05_RV DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS05_RV IMPLEMENTATION.

  METHOD save_modified.
**********************************************************************
    IF create-_hdr IS NOT INITIAL.
      IF zbp_pp_apps05_rv=>gt_hdr IS NOT INITIAL.

        IF zbp_pp_apps05_rv=>cv_mat_doc IS NOT INITIAL .
          LOOP AT zbp_pp_apps05_rv=>cv_mat_doc-materialdocument ASSIGNING FIELD-SYMBOL(<fs_pr_mapped>).
            CONVERT KEY OF I_MaterialDocumentTP FROM <fs_pr_mapped>-%pid TO DATA(ls_pr_key).
            <fs_pr_mapped>-MaterialDocument = ls_pr_key-MaterialDocument.
          ENDLOOP.
          IF  zbp_pp_apps05_rv=>gt_hdr IS NOT INITIAL.
*        DATA(lt_hdrupd) = zbp_mm_app07_rv=>gt_hdrupd.
            LOOP AT zbp_pp_apps05_rv=>gt_hdr ASSIGNING FIELD-SYMBOL(<fs_upd>).
              <fs_upd>-matno = ls_pr_key-MaterialDocument.
*          <fs_upd>-mark = 'X'.
            ENDLOOP.
          ENDIF.
        ENDIF.

        MODIFY zpp_apps05_htb FROM TABLE @zbp_pp_apps05_rv=>gt_hdr.
        DATA(ls_VR) = zbp_pp_apps05_rv=>gt_hdr[ 1 ]-vrno.
        DATA(uuid) = zbp_pp_apps05_rv=>gt_hdr[ 1 ]-uuid.
        SELECT * FROM zpp_apps05_ditb WHERE uuid = @uuid  INTO TABLE @DATA(lt_item1).
        SELECT * FROM zpp_apps05_ditb2 WHERE uuid = @uuid AND draftentityoperationcode <> 'L' INTO TABLE @DATA(lt_item2).
        SELECT * FROM zpp_apps05_dibt3 WHERE uuid = @uuid INTO TABLE @DATA(lt_item3).
        SELECT * FROM zpp_apps05_ditb4 WHERE uuid = @uuid INTO TABLE @DATA(lt_item4).
        SELECT * FROM zpp_apps05_ditb5 WHERE uuid = @uuid INTO TABLE @DATA(lt_item5).
        SELECT * FROM zpp_apps05_ditb6 WHERE uuid = @uuid INTO TABLE @DATA(lt_item6).
        SELECT * FROM zpp_apps05_ditb7 WHERE uuid =  @uuid INTO TABLE @DATA(lt_item7).
        SELECT * FROM zpp_apps05_ditb8 WHERE uuid = @uuid INTO TABLE @DATA(lt_item8).

      ENDIF.
**********************************************************************
      IF lt_item1 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item = VALUE #( FOR wa IN lt_item1 (
        uuid = wa-uuid
        plant   =  wa-plant
        orderno   = wa-orderno
        matnr     = wa-matnr
        maktx     = wa-maktx
        length   = wa-length
        width    = wa-width
        plnqty   = wa-plnqty
        uom      = wa-uom
        totreqty = wa-totreqty
        totopnqty = wa-totopnqty
        reqty    = wa-reqty
        vbeln    = wa-vbeln
        soitem   = wa-soitem
        Operation = wa-operation

         ) ).
        MODIFY zpp_apps05_itb FROM TABLE @zbp_pp_apps05_rv=>gt_item.
      ENDIF.
**********************************************************************
      IF lt_item2 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item2 = VALUE #( FOR wa2 IN lt_item2 INDEX INTO lv (
        uuid = wa2-uuid
        plant   =  wa2-plant
        orderno   = wa2-orderno
        matnr     = wa2-matnr
        maktx     = wa2-maktx
        length   = wa2-length
        width    = wa2-width
        plnqty   = wa2-plnqty
        uom      = wa2-uom
        reqty    = wa2-reqty
        vbeln    = wa2-vbeln
        Operation = wa2-operation
        sno  = lv
        vrno = ls_VR
        netwt = wa2-netwt
        wetpc = wa2-wetpc
        jobsht = wa2-jobsht
        resv = wa2-resv
         ) ).

        MODIFY zpp_apps05_itb2 FROM TABLE @zbp_pp_apps05_rv=>gt_item2.
      ENDIF.
**********************************************************************

      IF lt_item3 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item3 = VALUE #( FOR  wa3 IN lt_item3 ( uuid = wa3-uuid
        length = wa3-length
        quantity = wa3-quantity
         ) ).

        MODIFY zpp_apps05_itb3 FROM TABLE @zbp_pp_apps05_rv=>gt_item3.
      ENDIF.
**********************************************************************

      IF lt_item5 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item5 = VALUE #( FOR wa5 IN lt_item5 (
        uuid = wa5-uuid
        length  = wa5-length
     width = wa5-width
     product = wa5-Product
     batch = wa5-Batch
     materialdoc = wa5-materialdoc
     matdocitm = wa5-matdocitm
     purchaseorder = wa5-PurchaseOrder
     purchaseorderitem = wa5-PurchaseOrderItem
     plant = wa5-Plant
     quantity = wa5-quantity
     piecs = wa5-piecs
     apiecs = wa5-apiecs
     aquatity = wa5-aquatity
     storagelocation = wa5-StorageLocation
     pripono = wa5-pripono
     irno = wa5-irno
     supp = wa5-supp
     mark = wa5-mark
        ) ).


        MODIFY zpp_apps05_itb5 FROM TABLE @zbp_pp_apps05_rv=>gt_item5 .
      ENDIF.
**********************************************************************
      IF lt_item4 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item4 = VALUE #( FOR wa4 IN lt_item4 (
        uuid = wa4-uuid
            Sno = wa4-sno
         Irno = wa4-irno
         Length = wa4-length
         Quantity = wa4-quantity
         Quanwt =  wa4-quanwt
         vrno = ls_vr
         matnr = wa4-matnr
         batch = wa4-batch
         plant = wa4-plant
         storagelocation = wa4-storagelocation
         matnoitno = wa4-matnoitno


         ) ).


        MODIFY zpp_apps05_itb4 FROM TABLE @zbp_pp_apps05_rv=>gt_item4.
      ENDIF.
**********************************************************************

      IF lt_item6 IS NOT INITIAL.
        zbp_pp_apps05_rv=>gt_item6 = VALUE #( FOR wa6 IN lt_item6 (
        uuid = wa6-uuid
        vrno = ls_vr
        srcid = wa6-srcid
        srclent = wa6-srclent
        actlent = wa6-actlent
        lengthstr = wa6-lengthstr
        srcpcs = wa6-srcpcs
        totlen = wa6-totlen
        trmwste = wa6-trmwste
        wast = wa6-wast
        wastepr = wa6-wastepr
        rtnlent = wa6-rtnlent
         ) ).

        MODIFY zpp_apps05_itb6 FROM TABLE @zbp_pp_apps05_rv=>gt_item6.


      ENDIF.
**********************************************************************

      IF lt_item7 IS NOT INITIAL.

        zbp_pp_apps05_rv=>gt_iteb7a = VALUE #( FOR wa7 IN lt_item7 (
        uuid = wa7-uuid
        srcid = wa7-srcid
        parid = wa7-parid
        vrno = ls_vr
        pcs = wa7-pcs
        process = wa7-process
        marno = wa7-marno
        balpcs = wa7-balpcs
        length = wa7-length
        orderno = wa7-orderno
        totqty = wa7-totqty
         lentqty = wa7-lentqty


         ) ).

        MODIFY zpp_apps05_itb7 FROM TABLE @zbp_pp_apps05_rv=>gt_iteb7a.




      ENDIF.

**********************************************************************
      IF lt_item8 IS NOT INITIAL.

        zbp_pp_apps05_rv=>gt_item8 = VALUE #(  FOR wa8 IN lt_item8 (
        uuid = wa8-uuid
        Sno = wa8-sno
            Irno = wa8-irno
            Length = wa8-length
            width = wa8-width
            Apcs = wa8-apcs
            Used = wa8-used
            uqty = wa8-uqty
            rqty = wa8-rqty
            matnr = wa8-matnr
            batch = wa8-batch
            storagelocation = wa8-storagelocation
            plant = wa8-plant
            Vrno = ls_vr
Rtrn = wa8-rtrn
matnoitno = wa8-matnoitno
        )  ).

        MODIFY zpp_apps05_itb8 FROM TABLE @zbp_pp_apps05_rv=>gt_item8.


      ENDIF.

    ENDIF.











    IF zbp_pp_apps05_rv=>gt_att IS NOT INITIAL.
      MODIFY zpp_apps05_att FROM TABLE @zbp_pp_apps05_rv=>gt_att.
    ENDIF.

    IF delete-_hdr IS NOT INITIAL.
      LOOP AT delete-_hdr INTO DATA(ls_hdrd).
        DELETE FROM zpp_apps05_htb WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb2 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb3 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb5 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb6 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb7 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb8 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_itb4 WHERE uuid =  @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_dthb WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_ditb WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_ditb2 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_dibt3 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_ditb4 WHERE uuid = @ls_hdrd-Uuid.
        DELETE FROM zpp_apps05_ditb5 WHERE uuid =  @ls_hdrd-Uuid.
      ENDLOOP.
    ENDIF.

    IF zbp_pp_apps05_rv=>gt_del IS NOT INITIAL.

      MODIFY zpp_apps05_delim FROM TABLE @zbp_pp_apps05_rv=>gt_del.
      DATA(ls_del) = zbp_pp_apps05_rv=>gt_del[ 1 ]-uuid.


*      DELETE FROM zpp_apps05_htb WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb2 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb3 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb5 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb6 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb7 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb8 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_itb4 WHERE uuid =  @ls_del.
*      DELETE FROM zpp_apps05_dthb WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_ditb WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_ditb2 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_dibt3 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_ditb4 WHERE uuid = @ls_del.
*      DELETE FROM zpp_apps05_ditb5 WHERE uuid =  @ls_del.




    ENDIF.

    IF delete-_itemftmark IS NOT INITIAL.
      LOOP AT delete-_itemftmark INTO DATA(ls_itemdel).
        DELETE FROM zpp_apps05_ditb2 WHERE uuid = @ls_itemdel-Uuid AND sno = @ls_itemdel-Sno.


      ENDLOOP.

    ENDIF.








  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
