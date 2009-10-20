--- 
layout: post
title: "Javascripter: Organize your javascript"
comments: 5
---
Just like [Styler](/2007/05/03/styler-stylesheets-made-easy), you can use Javascripter to keep javascript organized in your application.

<h2>Usage</h2>

To use Javascripter, replace your <code>javascript\_include\_tags</code> with a single tag:

{% highlight erb %}
<head>
<title>the.rails.ist</title>
<%= javascripts %>
</head>
{% endhighlight %}

Once you do, your javascripts will be included automatically, using the conventions below.

{% highlight html %}
<head>
<title>the.rails.ist</title>
<script src="/javascripts/application.js?1183566571" />
</head>
{% endhighlight %}

<h2>Organize your javascripts</h2>

Javascripter uses a simple set of conventions:

- Javascript for your entire application should be stored in application.js
- Javascript for specific controllers should be stored in controller.js
- Javascript for specific actions should be stored in controller_action.js
- Javascript for specific actions should be stored in controller/action.js (optional)

Follow these conventions and Javascripter will reward you with automagic goodness, loading javascripts for specific controllers or actions whenever they are active.

<h2>Support for :defaults</h2>

Need Prototype? Just use the :defaults parameter, like normal.

{% highlight erb %}
<head>
<title>the.rails.ist</title>
<%= javascripts :defaults %>
</head>
{% endhighlight %}

And you'll get this:

{% highlight html %}
<head>
<title>the.rails.ist</title>
<script src="/javascripts/prototype.js?1187404678"></script>
<script src="/javascripts/effects.js?1187404678"></script>
<script src="/javascripts/dragdrop.js?1187404678"></script>
<script src="/javascripts/controls.js?1187404678"></script>
<script src="/javascripts/application.js?1187404678" />
</head>
{% endhighlight %}

<h2>Include additional javascripts</h2>

Need to include extra javascript libraries? Use the :include parameter:

{% highlight erb %}
<%= javascripts :include => "lowpro" %>
<%= javascripts :include => ["lowpro", "lightbox"] %>
{% endhighlight %}

<h2>Generator</h2>

Javascripter also includes a generator that will create a default application.js 
script and separate javascript files for each controller in your application.

To use the generator, run this command in your terminal:

{% highlight bash %}
script/generate javascripts
{% endhighlight %}

If you add a new controller, just run the generator again and a new javascript
for the controller will be created. (Existing javascripts will be ignored.)

<h2>Credits</h2>

Special thanks to [Lachie Cox](http://blog.smartbomb.com.au) and the rest of my [RORO Sydney](http://rubyonrails.com.au/sydney-meetups) comrades who asked for this plugin.

<h2>Install</h2>

{% highlight bash %}
script/plugin install git://github.com/mokolabs/javascripter.git
{% endhighlight %}
