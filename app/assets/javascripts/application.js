//= require rails-ujs
//= require_tree .

$(".js-open-wait").click(function() {
     setTimeout(function() {
        $(".wait").show();
     }, 100);
   });
