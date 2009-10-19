--- 
layout: post
title: "Helper for making FAQ top links"
---
Here's a simple helper for adding top-style links to a long frequently asked questions document.

Add the code below to your helpers/application_helpers.rb file.

{% highlight ruby %}
def top
  '<a href="#" class="top" onclick="window.scrollTo(0,0);return false;">top</a>'
end
{% endhighlight %}

Then add <code>&lt;%= top %&gt;</code> to each FAQ answer:

{% highlight html %}
<h2><a>Does Rails scale?</a><%= top %></h2>
{% endhighlight %}

For extra credit, style and tweak the markup to your liking.
