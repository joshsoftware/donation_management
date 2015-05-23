

$(document).on 'switchChange.bootstrapSwitch', '#by_cash_radio', (event, state) ->        
  if state == false
    $('.cheque_info').removeClass('hidden')
  else   
    $('.cheque_info').addClass('hidden')

