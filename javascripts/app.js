// Let's go
$(document).ready(function() {

  $(".highlight").each(function() {
  
    // Wrap .highlight pre blocks in span tags
    // (so we can grab the true width of code blocks)
    $(this).children().wrapInner("<span></span>");
  
    // Grab page width
    var page_width = $("#content").width() - 20;
    
    // Grab .highlight width
    var parent_width = $(this).width();
    
    // Grab width of code block
    var code_width = $(this).contents().contents().width();
    
    // Expand/shrink code blocks
    if (code_width > parent_width && code_width < page_width) {
      $(this).hover(
        function() {
          $(this).animate({ width: code_width + "px"}, 350);
        },
        function() {
          $(this).animate({ width: parent_width + "px" }, 450);
        }
      );
    }
    
    // Show horizontal scrollbar on super long code blocks
    if (code_width > page_width) {
      $(this).css("overflow-x", "scroll");
    }
  
  });

});