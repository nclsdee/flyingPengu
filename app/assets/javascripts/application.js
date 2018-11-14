//= require rails-ujs
//= require_tree .

$(".js-open-wait").click(function() {
     setTimeout(function() {
        $(".wait").show();
     }, 100);
   });



$(window).load(function() {
  $('.post-module').hover(function() {
    $(this).find('.description').stop().animate({
      height: "toggle",
      opacity: "toggle"
    }, 300);
  });
});
