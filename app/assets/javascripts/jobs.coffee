# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('.status_select').on 'change', ->
    $.ajax
      type: 'GET'
      url: '/jobs'
      dataType: 'script'
      data: search: $(this).val()
    return
  return
  