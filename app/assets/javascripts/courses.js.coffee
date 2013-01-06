# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".bar").animate width: "0%", duration: 'slow', ->
    $(".bar").animate width: $("#course_progress").html(), duration: 'slow'
    0
  0

