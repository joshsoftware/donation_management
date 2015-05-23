# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#donation_submission_user_id').select2()

  $('#donation_submission_submission_date').datepicker()

  $('#donation_submission_user_id').change ->
    user_id = $(this).val()
    $.get '/users/' + user_id + '/donation_pending_amounts'
