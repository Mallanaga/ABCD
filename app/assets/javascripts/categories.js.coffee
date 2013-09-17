# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#entry_category_tokens').tokenInput '/categories.json',
    theme: 'facebook'
    prePopulate: $('#entry_category_tokens').data('load')
    preventDuplicates: true
    tokenLimit: 5

  $('#design_category_tokens').tokenInput '/categories.json',
    theme: 'facebook'
    prePopulate: $('#design_category_tokens').data('load')
    preventDuplicates: true
    tokenLimit: 5