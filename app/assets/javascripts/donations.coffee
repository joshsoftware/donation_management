

$(document).on 'click', '#by_cash_radio', (event, state) ->        
  if $(this).val() == 'false'
    $('.cheque_info').removeClass('hidden')
  else   
    $('.cheque_info').addClass('hidden')

