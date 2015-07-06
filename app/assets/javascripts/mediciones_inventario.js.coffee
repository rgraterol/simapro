#= require moment
#= require bootstrap-datetimepicker
#= require jquery-ui/jquery-ui.js
#= require jquery.appendGrid/jquery.appendGrid-1.5.2.js
#= require moment/es

jQuery(document).ready ($) ->

  $('#bloque_manejo').change ->
    if $(this).val() != ''
      $('#loading_parcela').show()
      $.ajax
        type: "POST"
        url: "/mediciones_inventario_estatico/select_parcela_inventario"
        dataType: "HTML"
        data:
          bloque_manejo_id: $(this).val()
        success: (data) ->
          $('#parcela_inventario_medicion').empty()
          $('#parcela_inventario_medicion').append(data)
          load_formulario()
    else
      $('#parcela_inventario_medicion').empty()


load_formulario = ->
  $('#parcela_manejo_select').change ->
    if $(this).val() != ''
      $('#loading_formulario').show()

      $.ajax
        type: "POST"
        url: "/mediciones_inventario_estatico/load_form"
        dataType: "HTML"
        data:
          parcela_id: $(this).val()
        success: (data) ->
          $('#form_parcela').empty()
          $('#form_parcela').append(data)
          load_tipo_parcela()
    else
      $('#form_parcela').empty()

load_tipo_parcela = ->
  $('#tipo_parcela_inventario_select').change ->
    if $(this).val() != ''
      $('#loading_form_tipo_parcela').show()
      $.ajax
        type: "POST"
        url: "/mediciones_inventario_estatico/load_tipo_parcela"
        dataType: "HTML"
        data:
          tipo_parcela_inventario: $(this).val()
          parcela_id: $('#parcela_inventario_id').val()
        success: (data) ->
          $('#form_tipo_parcela').empty()
          $('#form_tipo_parcela').append(data)
          datetime_pickers()
          form_parcela_submit()
    else
      $('#form_tipo_parcela').empty()

datetime_pickers = ->
  $('#fecha_inicio_datetimepicker').datetimepicker
    viewMode: 'months',
    locale: 'es'

  $('#fecha_fin_datetimepicker').datetimepicker
    viewMode: 'months',
    locale: 'es'

form_parcela_submit = ->
  $('#send_form').click ->
    form = $('#form-parcela-inventario , #form-parcela-inventario-1').serialize();
    console.log(form)
    $.ajax
      url: '/mediciones_inventario_estatico/save'
      type: 'POST'
      dataType: 'json'
      beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
      data: form
      success: (data) ->
        console.log(data)
  $('#table_arboles_inventario').appendGrid
    caption: 'Arboles de Inventario'
    initRows: 20,
    columns: [
      {name: 'duad', display: 'Cuad.', type: 'text', ctrlAttr: { maxlength: 1 }, ctrlCss: { width: '70px'}, ctrlClass: 'required'},
      {name: 'fi', display: 'Fi', type: 'text', ctrlAttr: { maxlength: 1 }, ctrlCss: { width: '70px'}, ctrlClass: 'required'},
      {name: 'arbol', display: 'Árbol', type: 'text', ctrlAttr: { maxlength: 2 }, ctrlCss: { width: '70px'}, ctrlClass: 'required'},
      {name: 'bi', display: 'BI', type: 'text', ctrlAttr: { maxlength: 1 }, ctrlCss: { width: '70px'}, ctrlClass: 'required'},
      {name: 'especie', display: 'Especie', type: 'text', ctrlAttr: { maxlength: 60 }, ctrlCss: { width: '300px'}, ctrlClass: 'required'},
      {name: 'dap_cap', display: 'CAP/DAP', type: 'text', ctrlAttr: { maxlength: 4 }, ctrlCss: { width: '100px'}, ctrlClass: 'required'},
      {name: 'altura_fuste', display: 'Altura Fuste', type: 'text', ctrlAttr: { maxlength: 4 }, ctrlCss: { width: '100px'}, ctrlClass: 'required'},
      {name: 'calidad', display: 'Calidad', type: 'select', ctrlCss: { width: '100px'}, ctrlOptions: { 0: 'B', 1: 'R', 2: 'M'}},
    ]
    hideButtons:
      removeLast: true
  return false

