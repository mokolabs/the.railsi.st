// Let's go
$(document).ready(function() {

  // Wrap code in spans to grab block length
  $(".highlight").wrapInner("<span></span>");

  // Expand long code blocks on hover
  $(".highlight").each(function(){
    if ($(this).contents().width() > 680) {
      var block = $(this).width();
      var content = $(this).contents().width();
      $(this).hover(
        function() {
          if (content > block && content < 1000) {
            $(this).animate({ width: content + "px"}, 350);
          }
        },
        function() {
          if (content > 680 && content < 1000) {
            $(this).animate({ width: "680px" }, 450);
          }
        }
      );
    }
  });

  // Add scrollbar to super long code blocks
  $(".highlight").each(function(){
    if ($(this).contents().width() > 1000) {
      $(this).css("overflow-x", "scroll");
    }
  });

});