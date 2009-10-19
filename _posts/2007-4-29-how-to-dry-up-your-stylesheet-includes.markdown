{% highlight ruby %}--- 
layout: post
title: How to DRY up your stylesheet includes
---
Here's a helper to automatically include stylesheets in your layouts.

This helper will include any stylesheets in public/stylesheets/ that match these conventions:

+ Styles for your entire application should be stored in application.css
+ Styles for specific controllers should be stored in controller_name.css
+ Styles for Internet Explorer 7 should be stored in ie7.css
+ Styles for Internet Explorer 6 should be stored in ie6.css

The IE6 and 7 stylesheets will be wrapped in conditional comments, so they'll only load when requested by matching browsers.

To install, just add this method to your helpers/application_helpers.rb

{% highlight ruby %}
def stylesheets
  stylesheets = ["application", "#{controller.controller_name}", "ie7", "ie6"]
  stylesheets.collect! do |name| 
    if File.exist?("#{RAILS_ROOT}/public/stylesheets/#{name}.css")
      case name
      when "ie7"
        "<!--[if IE 7]>\n" + stylesheet_link_tag(name) + "\n<![endif]-->"
      when "ie6"
        "<!--[if IE 6]>\n" + stylesheet_link_tag(name) + "\n<![endif]-->"
      else
        stylesheet_link_tag(name)
      end
    end
  end
  stylesheets.compact.join("\n")
end
{% endhighlight %}

Then add <code>&lt;%= stylesheets %&gt;</code> to your layout(s):

{% highlight html %}
<html>
<head>
<title>the.rails.ist</title>
<%= stylesheets %>
</head>
<body>
</body>
</html>
{% endhighlight %}

When the template is rendered, you'll get this:

{% highlight html %}
<html>
<head>
<title>the.rails.ist</title>
<link href="/stylesheets/application.css?1170968897" />
<!--[if IE 7]>
<link href="/stylesheets/ie7.css?1170968897" />
<![endif]-->
<!--[if IE 6]>
<link href="/stylesheets/ie6.css?1170968897" />
<![endif]-->
</head>
<body>
</body>
</html>
{% endhighlight %}

Note: to keep the example code clean, I removed the media, rel, and type attributes that Rails normally includes with stylesheet links. But, when you run the helper for real, they'll be included.

The cool part is that controller-specific stylesheets will only be included when the relevant controller is invoked. Looking at a page in your "products" controller? Then products.css will be included, but only on pages loaded by that controller.

Want to go further?

+ Need to support Internet Explorer 5.5 or earlier? Create a new stylesheet named ie55 (which will contain any IE5.5-specific styles), and then add <code>"ie55"</code> to the list of stylesheets at the start of the helper
+ Add <code>"#{controller.controller_name}_#{controller.action_name}"</code> to the list of stylesheets. This will allow you to include stylesheets that are specific to a single action.
+ Need to include a stylesheet for Lightbox or Redbox? Same deal... just update the stylesheet list (and make your any new stylesheets are copied into your <code>public/stylesheets/</code> directory).

Stay tuned... I'll be releasing a plugin based on this helper soon. UPDATE: the plugin <a href="/2007/5/3/styler-stylesheets-made-easy">has been released</a>.

(This code is loosely based on <a href="http://www.bigbold.com/snippets/posts/show/509">this snippet</a>.)
