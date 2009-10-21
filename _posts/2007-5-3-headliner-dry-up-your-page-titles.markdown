--- 
layout: post
title: "Headliner: DRY up your page titles"
comments: 10
---
Headliner is a Rails plugin that makes it easier to assign and format page titles from your views.

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

{% highlight erb %}
<head>
<title>My website<% if @title %>: <%= @title %><% end %></title>
</head
{% endhighlight %}

This works okay... but page titles don't really belong in controllers, do they?

So, by moving these titles into your views, we can DRY things up a bit and reinforce the MVC design pattern that's so fundamental to Ruby on Rails.


##  Install

To install, just add Headliner to your `vendor/plugins` directory:

{% highlight erb %}
script/plugin install git://github.com/mokolabs/headliner.git
{% endhighlight %}


## Usage

First, add this code to your main layout:

{% highlight erb %}
<head>
<%= title :site => "My website" %>
</head>
{% endhighlight %}

Then, to set the page title, add this to each of your views:

{% highlight erb %}
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


## Options

Use these options to customize the title format:

+ :prefix (text between site name and separator)
+ :separator (text used to separate website name from page title)
+ :suffix (text between separator and page title)
+ :lowercase (when true, the page name will be lowercase)
+ :reverse (when true, the page and site names will be reversed)

And here are a few examples to give you ideas.

{% highlight erb %}
<%= title :separator => "&mdash;" %>
<%= title :prefix => false, :separator => ":" %>
<%= title :lowercase => true %>
<%= title :reverse => true, :prefix => false %>
{% endhighlight %}


## Dealing with special pages

How do you set the page title without showing it in the view?

{% highlight erb %}
<% title "My page title" %>
{% endhighlight %}

What if your view headline is different from your page title?

{% highlight erb %}
<%= title "My page title", "My headline" %>
{% endhighlight %}


## Mr. T says, ‘Use my method, fool!’

Just like ERB's [HTML safe method](http://www.ruby-doc.org/stdlib/libdoc/erb/rdoc/), you can invoke Headliner with a single letter alias.

{% highlight erb %}
<h1><%=t "My page title" %></h1>
{% endhighlight %}

Note: this alias conflicts with the translate method in the [Rails Internationalization (I18n) API](http://guides.rubyonrails.org/i18n.html), since it provides the same alias. If you need I18n support, you should use one of [these](http://github.com/nivanson/headliner) [forks](http://github.com/galfert/headliner) on Github.


## How does it work?

Ruby on Rails renders actions *before* inserting them into layouts. So, if you set a variable in your view, it will be accessible in your layout. But, at first glance, it looks like you're using a variable (in the head) before it's been assigned a value (in the body). Cool, huh?


## Contributors

Special thanks to James Chan, Nick Zadrozny, and Jordan Fowler.


## Feedback

Comments and patches welcome at [http://github.com/mokolabs/headliner/](http://github.com/mokolabs/headliner/).
