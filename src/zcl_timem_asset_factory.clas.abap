CLASS zcl_timem_asset_factory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS create_instance
      IMPORTING
        !asset_type TYPE string
        !is_parts     TYPE ztimem_parts
      RETURNING
        VALUE(result) TYPE REF TO zif_timem_asset .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TIMEM_ASSET_FACTORY IMPLEMENTATION.


  METHOD create_instance.
    DATA(options) = zcl_timem_options=>get_instance( ).
    result = SWITCH #(
      asset_type
      WHEN 'CSS' THEN NEW zcl_timem_asset_css( options->theme )
      WHEN 'HTML' THEN
        SWITCH #(
          options->mode
          WHEN zif_timem_consts=>mode-blame THEN NEW zcl_timem_asset_html_blame( is_parts )
          WHEN zif_timem_consts=>mode-time_machine THEN NEW zcl_timem_asset_html_tmachine( is_parts ) ) ).
  ENDMETHOD.
ENDCLASS.
