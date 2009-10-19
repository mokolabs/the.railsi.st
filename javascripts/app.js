// Let's go
$(document).ready(function() {

  $(".highlight").wrapInner("<span></span>");

  $(".highlight").hover(function() {
      var contentwidth = $(this).contents().width();
      var blockwidth = $(this).width();    
      if(contentwidth > blockwidth) {
        $(this).animate({ width: "1020px"}, 250);
        }
      }, function() {
        $(this).animate({ width: "680px" }, 250);
  });

});