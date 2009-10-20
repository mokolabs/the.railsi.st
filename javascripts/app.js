// Let's go
$(document).ready(function() {

  // Wrap code in spans to grab block length
  $(".highlight").wrapInner("<span></span>");

  // Expand long code blocks on hover
  $(".highlight").hover(
    function() {
      var block = $(this).width();
      var content = $(this).contents().width();
      if (content > block && content < 1020) {
        $(this).animate({ width: content + "px"}, 350);
      }
    },
    function() {
      var content = $(this).contents().width();
      if (content > 680 && content < 1020) {
        $(this).animate({ width: "680px" }, 350);
      }
    }
  );
  
  // Add scrollbar to super long code blocks
  $(".highlight").each(function(){
    if ($(this).contents().width() > 1020) {
      $(this).css("overflow-x", "scroll");
    }
  });

});