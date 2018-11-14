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
import "../plugins/flatpickr";
import Fuse from 'fuse.js';
import _ from 'lodash';
// import "../packs/autocomplete";
import airports from "../packs/airports"

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


// Aiport Autocomplete


var options = {
  shouldSort: true,
  threshold: 0.4,
  maxPatternLength: 32,
  keys: [{
    name: 'iata',
    weight: 0.5
  }, {
    name: 'name',
    weight: 0.3
  }, {
    name: 'city',
    weight: 0.2
  }]
};


var fuse = new Fuse(airports, options)

$('.autocomplete').each(function() {
  var ac = $(this);

  ac.on('click', function(e) {
    e.stopPropagation();
  })
  .on('focus keyup', search)
  .on('keydown', onKeyDown);

  var wrap = $('<div>')
  .addClass('autocomplete-wrapper')
  .insertBefore(ac)
  .append(ac);

  var list = $('<div>')
  .addClass('autocomplete-results')
  .on('click', '.autocomplete-result', function(e) {
    e.preventDefault();
    e.stopPropagation();
    selectIndex($(this).data('index'), ac);
  })
  .appendTo(wrap);
});

$(document)
.on('mouseover', '.autocomplete-result', function(e) {
  var index = parseInt($(this).data('index'), 10);
  if (!isNaN(index)) {
    $(this).attr('data-highlight', index);
  }
})
.on('click', clearResults);

function clearResults() {
  results = [];
  numResults = 0;
  $('.autocomplete-results').empty();
}

function selectIndex(index, autoinput) {
  if (results.length >= index + 1) {
    autoinput.val(results[index].iata);
    clearResults();
  }
}

var results = [];
var numResults = 0;
var selectedIndex = -1;

function search(e) {
  if (e.which === 38 || e.which === 13 || e.which === 40) {
    return;
  }
  var ac = $(e.target);
  var list = ac.next();
  if (ac.val().length > 0) {
    results = _.take(fuse.search(ac.val()), 7);
    numResults = results.length;

    var divs = results.map(function(r, i) {
      return '<div class="autocomplete-result" data-index="'+ i +'">'
      + '<div><b>'+ r.iata +'</b> - '+ r.name +'</div>'
      + '<div class="autocomplete-location">'+ r.city +', '+ r.country +'</div>'
      + '</div>';
    });

    selectedIndex = -1;
    list.html(divs.join(''))
    .attr('data-highlight', selectedIndex);

  } else {
    numResults = 0;
    list.empty();
  }
}

function onKeyDown(e) {
  var ac = $(e.currentTarget);
  var list = ac.next();
  switch(e.which) {
    case 38: // up
    selectedIndex--;
    if (selectedIndex <= -1) {
      selectedIndex = -1;
    }
    list.attr('data-highlight', selectedIndex);
    break;
    case 13: // enter
    selectIndex(selectedIndex, ac);
    break;
    case 9: // enter
    selectIndex(selectedIndex, ac);
    e.stopPropagation();
    return;
    case 40: // down
    selectedIndex++;
    if (selectedIndex >= numResults) {
      selectedIndex = numResults-1;
    }
    list.attr('data-highlight', selectedIndex);
    break;

    default: return; // exit this handler for other keys
  }
  e.stopPropagation();
  e.preventDefault(); // prevent the default action (scroll / move caret)
}


// map scroll



$( document ).ready(function() {
  $(window).scroll(function() {
    var scroll = $(window).scrollTop();
    console.log(scroll);
    const mapdiv = document.querySelector("#map");
    if ((scroll >= 26 && mapdiv)) {
      console.log("map is present")
      $("#map").switchClass(" ","resize-map",500,"easeInOutQuad" );
    } else {
      $("#map").switchClass("resize-map"," ",500,"easeInOutQuad");
    }
  });
});




