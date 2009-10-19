--- 
layout: post
title: "Styler: Stylesheets made easy"
---
Styler is designed to DRY up the process of including and generating stylesheets, so you can think less about stylesheet configuration and more about styling.

<h2>Usage</h2>

To use Styler, just update your layout(s) with this code:

{% highlight html %}
<head>
<title>the.rails.ist</title>
<%= stylesheets %>
</head>
{% endhighlight %}

Styler will then include your stylesheets automatically:

{% highlight html %}
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
{% endhighlight %}

Styler will also dynamically include stylesheets for each of your controllers (if such stylesheets are present), so you can keep your styles organized into logical sections.

<h2>Organize your stylesheets</h2>

Styler uses a simple set of conventions:

+ Styles for your entire application should be stored in <code>application.css</code>
+ Styles for specific controllers should be stored in <code>controller.css</code>
+ Styles for specific actions should be stored in <code>controller_action.css</code>
+ Styles for Internet Explorer 7 should be stored in <code>ie7.css</code>
+ Styles for Internet Explorer 6 should be stored in <code>ie6.css</code>

When used in combination, these conventions can scale up to support pretty big applications.

<h2>Include additional stylesheets</h2>

Conventions are great, but need to add your own stylesheets?

{% highlight ruby %}
<%= stylesheets :include => "reset" %>
<%= stylesheets :include => ["reset", "fonts"] %>
{% endhighlight %}

<h2>Use nested stylesheets (optional)</h2>

For bigger projects, you might wish to break your stylesheets into separate directories.

To use nested stylesheets, just create subdirectories in <code>public/stylesheets</code> for each of your controllers, and then add stylesheets for individual actions you wish to style.

+ Styles for an entire controller should be stored in <code>controller.css</code>
+ Styles for specific actions should be stored in <code>controller/action.css</code>

<h2>Generator</h2>

Styler also includes a generator that will create a default set of stylesheets (<code>application.css</code>, <code>ie7.css</code>, and <code>ie6.css</code>) and a separate stylesheet for each controller in your application.

To use the generator, run this command in your terminal:

{% highlight bash %}
script/generate stylesheets
{% endhighlight %}

If you add a new controller, just run the generator again and a new stylesheet for the controller will be created. (Styler will safely ignore any existing stylesheets.)

<h2>Install</h2>

{% highlight bash %}
script/plugin install git://github.com/mokolabs/styler.git
{% endhighlight %}
