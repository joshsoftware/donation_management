# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#by_cash_radio').bootstrapSwitch()

  $('#by_cash_radio').on 'switchChange.bootstrapSwitch', (event, state) ->        
    if state == false
      $('.cheque_info').removeClass('hidden')
    else   
      $('.cheque_info').addClass('hidden')

  $('#donation_cheque_date').datepicker
   format: 'dd/mm/yyyy'
