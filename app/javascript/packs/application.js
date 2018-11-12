/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')
import "bootstrap";
import "../plugins/flatpickr"

$(".js-plus").click(function() {
  var parent = $(this).parents(".hometown");
  var value = parent.find(".js-counter").text();
  value = parseInt(value) + 1;
  parent.find(".js-counter").text(value);
  parent.find(".js-input").val(value);
});

$(".js-minus").click(function() {
  var parent = $(this).parents(".hometown");
  var value = parent.find(".js-counter").text();
  value = parseInt(value) - 1;
  value = value <= 0 ? 0 : value;
  parent.find(".js-counter").text(value);
  parent.find(".js-input").val(value);
});


$("#add-extra-field").click(function () {
  $(".hometown:hidden").first().show();
});

$("#remove-extra-field").click(function () {
  if( $(".hometown:visible").length !== 1 ){
    $(".hometown:visible").last().hide();
  }
});

console.log('ciao Lucrezia')




