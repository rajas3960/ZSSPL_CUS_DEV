INTERFACE zlif_textd_api.
    methods:
    read_text
      importing
        iv_id         type thead-tdid
        iv_object     type thead-tdobject
        iv_language   type thead-tdspras
        iv_name       type thead-tdname
      exporting
        et_linetab    type tline_tab.

ENDINTERFACE.

