CLASS lhc_ZPP_APPS06_RE DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zpp_apps06_re RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zpp_apps06_re RESULT result.

    METHODS Gtrelord FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps06_re~Gtrelord RESULT result.
    METHODS Gtmatchk FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps06_re~Gtmatchk RESULT result.
    METHODS GtContract FOR MODIFY
      IMPORTING keys FOR ACTION zpp_apps06_re~GtContract RESULT result.
    METHODS Gtunrelord FOR MODIFY
       keys FOR ACTION zpp_apps06_re~Gtunrelord RESULT result.
    METHODS Gtunrelord1 FOR MODIFY
      keys FOR ACTION ZPP_APPS06_RE~Gtunrelord1 RESULT result.

ENDCLASS.

CLASS lhc_ZPP_APPS06_RE IMPLEMENTATION.

  METHOD get_instance_features.
**********************************************************************
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).

    data(Wa_rel) =  VALUE #( lt_item[ OrderIsReleased = 'Released' ] OPTIONAL ).

**********************************************************************
    result =  VALUE #( FOR ls_data IN Lt_hdr
          (   %tky =  ls_data-%tky
          %action-Gtrelord = COND #( WHEN  ls_data-Statusr IS INITIAL

                                                      THEN if_abap_behv=>fc-o-enabled

                                                      ELSE if_abap_behv=>fc-o-disabled )
          %action-Gtmatchk =  COND #( WHEN  ls_data-Statusr IS INITIAL

                                                      THEN if_abap_behv=>fc-o-enabled

                                                      ELSE if_abap_behv=>fc-o-disabled )
           %action-GtContract =  COND #( WHEN  ls_data-Statusr IS INITIAL

                                                      THEN if_abap_behv=>fc-o-enabled

                                                      ELSE if_abap_behv=>fc-o-disabled )
%action-Gtunrelord1 =  COND #( WHEN  ls_data-Statusr IS NOT INITIAL and Wa_rel is INITIAL

                                                      THEN if_abap_behv=>fc-o-enabled

                                                      ELSE if_abap_behv=>fc-o-disabled )
                                                      ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations.
**********************************************************************
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    LOOP AT lt_hdr INTO DATA(ls_hdr).
      TRY.
          DATA(lv_user2) = cl_abap_context_info=>get_user_business_partner_id(  ).
        CATCH cx_abap_context_info_error INTO DATA(lv_error).
          DATA(lv_1) = 1.
      ENDTRY.

      IF lv_user2 = '9980000296' OR    lv_user2 = '9980000000' OR lv_user2 = '9980000110' OR lv_user2 = '9980000130'.
        APPEND VALUE #( %tky             = ls_hdr-%tky
                        %action-Gtmatchk = if_abap_behv=>auth-allowed
                        %action-Gtrelord = if_abap_behv=>auth-allowed
                         %action-GtContract = if_abap_behv=>auth-allowed
                         %action-Gtunrelord = if_abap_behv=>auth-allowed
                         %action-Gtunrelord1 = if_abap_behv=>auth-allowed
                        ) TO result.
      ELSE.
        APPEND VALUE #( %tky             = ls_hdr-%tky
                       %action-Gtmatchk = if_abap_behv=>auth-unauthorized
                        %action-Gtrelord = if_abap_behv=>auth-unauthorized
                          %action-GtContract = if_abap_behv=>auth-unauthorized
                           %action-Gtunrelord = if_abap_behv=>auth-unauthorized
                           %action-Gtunrelord1 = if_abap_behv=>auth-unauthorized

                       ) TO result.
      ENDIF.

    ENDLOOP.
**********************************************************************



  ENDMETHOD.

  METHOD Gtrelord.
**********************************************************************
    DATA : gs_hdr TYPE zpp_apps05_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    IF lt_item IS NOT INITIAL.

      LOOP AT lt_item INTO DATA(ls_item) WHERE OrderIsReleased <> 'Released'.

        MODIFY ENTITY PRIVILEGED  i_productionordertp
   EXECUTE release
   FROM VALUE #( ( %key-productionorder = ls_item-Orderno
                   %param-ordrelispmtddsptmisgparts = abap_true ) )
   REQUEST VALUE #(  )
   RESULT DATA(result1)
   FAILED DATA(failed1)
   REPORTED DATA(reported1).

        IF failed1 IS INITIAL.

          LOOP AT reported1-productionorder INTO DATA(ls_rep).
            APPEND VALUE #(
                %tky = ls_item-%tky
                %msg = ls_rep-%msg
            ) TO reported-zpp_apps06_irv.
          ENDLOOP.
        ELSE.
          LOOP AT failed1-productionorder INTO DATA(ls_rep1).
            APPEND VALUE #(
                %tky = ls_item-%tky
                %fail = ls_rep1-%fail
            ) TO failed-zpp_apps06_irv.
          ENDLOOP.




        ENDIF.


      ENDLOOP.
**********************************************************************


      MOVE-CORRESPONDING  ls_hdr TO gs_hdr.
      gs_hdr-statusr = 'R'.
      TRY.
          DATA(ls_user) =  cl_abap_context_info=>get_user_description(  ).
        CATCH   cx_abap_context_info_error .
          DATA(lv) = 1.
      ENDTRY.
      gs_hdr-relusr = ls_user.

      APPEND gs_hdr TO zbp_pp_apps06_re=>gt_hdr.
**********************************************************************

    ENDIF.

    result = VALUE #(
         FOR ls1 IN lt_hdr (
           %tky   = ls1-%tky
           %param = ls1
         )
       ).
**********************************************************************








**********************************************************************

  ENDMETHOD.

  METHOD Gtmatchk.

    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
      ENTITY zpp_apps06_re
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_hdr)
      BY \_item
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_item).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
    IF lt_item IS NOT INITIAL.

      LOOP AT lt_item INTO DATA(ls_item).

        MODIFY ENTITY PRIVILEGED i_productionordertp
          EXECUTE checkmaterialavailability
          FROM VALUE #( ( %key-productionorder = ls_item-Orderno ) )
          REQUEST VALUE #(  )
          RESULT DATA(result1)
          FAILED DATA(failed1)
          REPORTED DATA(reported1).


        IF failed1 IS INITIAL.
*  APPEND VALUE #( %tky = ls_item-%tky
*      %msg =  new_message_with_text( severity = if_abap_behv_message=>severity-success
*                                                              text = |All checked mrtl in Ord { ls_item-Orderno ALPHA = OUT }are available| )
*                               ) TO reported-zpp_apps06_irv.
          LOOP AT reported1-productionorder INTO DATA(ls_rep).
            APPEND VALUE #(
                %tky = ls_item-%tky
                %msg = ls_rep-%msg
            ) TO reported-zpp_apps06_irv.
          ENDLOOP.



        ENDIF.


      ENDLOOP.
    ENDIF.
    result = VALUE #(
   FOR ls1 IN lt_hdr (
     %tky   = ls1-%tky
     %param = ls1
   )
 ).













  ENDMETHOD.

  METHOD GtContract.
**********************************************************************
    DATA : gs_hdr TYPE zpp_apps05_htb.
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).
**********************************************************************
    IF lt_hdr IS NOT INITIAL.
      DATA(ls_hdr) = lt_hdr[ 1 ].
    ENDIF.
    MOVE-CORRESPONDING ls_hdr TO gs_hdr.
    gs_hdr-contr = keys[ 1 ]-%param-BusinessPartner.
    gs_hdr-contrname = keys[ 1 ]-%param-BusinessPartnerName.
**********************************************************************
    APPEND gs_hdr TO zbp_pp_apps06_re=>gt_hdr.
**********************************************************************
    result = VALUE #( FOR ls IN lt_hdr ( %tky = ls-%tky
    %param = ls ) ).
**********************************************************************

  ENDMETHOD.

  METHOD Gtunrelord.

**********************************************************************
    DATA : gs_hdr TYPE zpp_apps05_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
*    IF lt_item IS NOT INITIAL.


**********************************************************************


      MOVE-CORRESPONDING  ls_hdr TO gs_hdr.
      gs_hdr-statusr = ' '.
      TRY.
          DATA(ls_user) =  cl_abap_context_info=>get_user_description(  ).
        CATCH   cx_abap_context_info_error .
          DATA(lv) = 1.
      ENDTRY.
      gs_hdr-relusr = ' '.

      APPEND gs_hdr TO zbp_pp_apps06_re=>gt_hdr.
**********************************************************************

*    ENDIF.

    result = VALUE #(
         FOR ls1 IN lt_hdr (
           %tky   = ls1-%tky
           %param = ls1
         )
       ).
**********************************************************************

  ENDMETHOD.

  METHOD Gtunrelord1.

**********************************************************************
    DATA : gs_hdr TYPE zpp_apps05_htb.
**********************************************************************
    READ ENTITIES OF zpp_apps06_re IN LOCAL MODE
    ENTITY zpp_apps06_re
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr)
    BY \_item
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_item).
    DATA(ls_hdr) = lt_hdr[ 1 ].
**********************************************************************
*    IF lt_item IS NOT INITIAL.


**********************************************************************


      MOVE-CORRESPONDING  ls_hdr TO gs_hdr.
      gs_hdr-statusr = ''.
      gs_hdr-relusr = ' '.

      APPEND gs_hdr TO zbp_pp_apps06_re=>gt_hdr.
**********************************************************************

*    ENDIF.

    result = VALUE #(
         FOR ls1 IN lt_hdr (
           %tky   = ls1-%tky
           %param = ls1
         )
       ).
**********************************************************************
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZPP_APPS06_RE DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZPP_APPS06_RE IMPLEMENTATION.

  METHOD save_modified.
    IF zbp_pp_apps06_re=>gt_hdr IS NOT INITIAL.
      MODIFY zpp_apps05_htb FROM TABLE @zbp_pp_apps06_re=>gt_hdr.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
