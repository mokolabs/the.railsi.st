--- 
layout: post
title: "Headliner: DRY up your page titles"
---
Normally, if your Rails application has lots of actions and a shared layout, you might find yourself setting custom page title names in your controllers.

Here's an example:

{% highlight ruby %}
class PagesController < ApplicationController
  def about
    @title = "About us"
  end
end
{% endhighlight %}

Then, in your main layout, you might have something like this:

{% highlight html %}
<head>
<title>My website<% if @title %>: <%= @title %><% end %></title>
</head
{% endhighlight %}

This works okay... but page titles don't really belong in controllers, do they?

So, by moving these titles into your views, we can DRY things up a bit and reinforce the MVC design pattern that's so fundamental to Ruby on Rails.

<h2>Usage</h2>

First, add this code to your main layout:

{% highlight ruby %}
<head>
<%= title :site => "My website" %>
</head>
{% endhighlight %}

Then, to set the page title, add this to each of your views:

{% highlight html %}
<h1><%= title "My page title" %></h1>
{% endhighlight %}

When views are rendered, the page title will be included in the right spots:

{% highlight html %}
<head>
<title>My website | My page title</title>
</head>
<body>
<h1>My page title</h1>
</body>
{% endhighlight %}

<h2>Options</h2>

Use these options to customize the title format:

+ :prefix (text between site name and separator)
+ :separator (text used to separate website name from page title)
+ :suffix (text between separator and page title)
+ :lowercase (when true, the page name will be lowercase)
+ :reverse (when true, the page and site names will be reversed)

And here are a few examples to give you ideas.

{% highlight ruby %}
<%= title :separator => "&mdash;" %>
<%= title :prefix => false, :separator => ":" %>
<%= title :lowercase => true %>
<%= title :reverse => true, :prefix => false %>
{% endhighlight %}

<h2>Dealing with special pages</h2>

How do you set the page title without showing it in the view?

{% highlight ruby %}
<% title "My page title" %>
{% endhighlight %}

What if your view headline is different from your page title?

{% highlight ruby %}
<%= title "My page title", "My headline" %>
{% endhighlight %}

<h2>Mr. T says, &#8216;Use my method, fool!&#8217;</h2>

Just like ERB's [HTML safe method](http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/), you can invoke Headliner with a single letter alias.

{% highlight html %}
<h1><%=t "My page title" %></h1>
{% endhighlight %}

<h2>How does it work?</h2>

Ruby on Rails renders actions *before* inserting them into layouts. So, if you set a variable in your view, it will be accessible in your layout. But, at first glance, it looks like you're using a variable (in the head) before it's been assigned a value (in the body). Cool, huh?

<h2>Credits</h2>

Special thanks to Nick Zadrozny and Jordan Fowler for their input.

<h2>Install</h2>

{% highlight bash %}
script/plugin install git://github.com/mokolabs/headliner.git
{% endhighlight %}
