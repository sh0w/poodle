# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".bar").animate width: "0%", duration: 'slow', ->
    $(this).animate width: $(this).data("progress")+"%", duration: 'slow'
    0
  0
 
$ -> 
  $("#stars .star").click ->
    alert "click"
  0
0

