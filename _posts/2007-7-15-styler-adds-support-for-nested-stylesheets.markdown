--- 
layout: post
title: Styler adds support for nested stylesheets
---
What happens when you have a really big application? You wind up with a ton of stylesheets in <code>public/stylesheets</code>. It can get messy.

That's why Styler now supports <em>nested</em> stylesheet directories.

To use this feature, just create subdirectories in <code>public/stylesheets</code> for each of your controllers, and then add stylesheets for individual actions you wish to style.

+ Styles for an entire controller should be stored in <code>controller.css</code>
+ Styles for specific actions should be stored in <code>controller/action.css</code>

Also... there's no configuration required, and you can use flat and nested stylesheets at the same time.
