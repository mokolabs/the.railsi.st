--- 
layout: post
title: "Styler: Stylesheets made easy"
comments: 11
---
Styler is a Rails plugin which makes it easier to include stylesheets. That way, you can think less about stylesheet configuration and more about styling.

Styler works by replacing `stylesheet_link_tag`, the default stylesheet tag helper for Rails, with an improved helper called `stylesheets`.


## Install

{% highlight bash %}
script/plugin install git://github.com/mokolabs/styler.git
{% endhighlight %}


## Usage

To use Styler, just update your layouts with this code:

{% highlight erb %}
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
<!--[if IE 8]>
<link href="/stylesheets/ie8.css?1170968897" />
<![endif]-->
<!--[if IE 7]>
<link href="/stylesheets/ie7.css?1170968897" />
<![endif]-->
<!--[if IE 6]>
<link href="/stylesheets/ie6.css?1170968897" />
<![endif]-->
</head>
{% endhighlight %}

Styler will also dynamically include stylesheets for each of your controllers (if such stylesheets are present), so you can keep your styles organized into logical sections without adding tons of `stylesheet_link_tag` calls.


## Organize your stylesheets

Styler uses a simple set of conventions:

- Styles for your entire application should be stored in `application.css`
- Styles for specific controllers should be stored in `controller.css`
- Styles for specific actions should be stored in `controller_action.css`
- Styles for Internet Explorer 8 should be stored in `ie8.css`
- Styles for Internet Explorer 7 should be stored in `ie7.css`
- Styles for Internet Explorer 6 should be stored in `ie6.css`
- Styles for iPhone should be stored in `iphone.css`

When used in combination, these conventions can scale up to support pretty big applications.


## Include additional stylesheets

Conventions are great, but need to add your own stylesheets?

{% highlight erb %}
<%= stylesheets :include => "reset" %>
<%= stylesheets :include => ["reset", "fonts"] %>
{% endhighlight %}

Any additional stylesheets will be inserted before Internet Explorer and iPhone stylesheets, which means you'll still be able to apply tweaks and bug fixes.


## Use nested stylesheets (optional)

For bigger projects, you might wish to break your stylesheets into separate directories.

To use nested stylesheets, just create subdirectories in `public/stylesheets` for each of your controllers, and then add separate stylesheets for individual actions you wish to style.

- Styles for an entire controller should be stored in `controller.css`
- Styles for specific actions should be stored in `controller/action.css`

You can also set a general subpath for all stylesheets:

{% highlight erb %}
<%= stylesheets :path => "compiled" %>
{% endhighlight %}

This will force Styler to only load stylesheets from the `/public/stylesheets/compiled` directory.


## Generator

Styler also includes a generator that will create a default set of stylesheets (`application.css`, `ie8.css`, `ie7.css`, `ie6.css`, and `iphone.css`) and a separate stylesheet for each controller in your application.

To use the generator, run this command in your terminal:

{% highlight bash %}
script/generate stylesheets
{% endhighlight %}

If you add a new controller, just run the generator again and a new stylesheet for the controller will be created. (Styler will safely ignore any existing stylesheets already in your stylesheets directory.)


## Frequently Asked Questions

### Does Style work with Sass?

Yes, Styler works great with Sass. Just make sure your generated stylesheets are saved to `public/stylesheets` and you'll be fine. (Note: there is no support for Sass in Styler's generator, so you'll need to create your Sass files like normal.)

### Does Styler do asset bundling?

Not at the present time. Asset bundling can get complicated and it's definitely outside the intended scope of this application. If asset bundling is critical to your application, you can always revert back to using standard asset helpers or even write your own.


## Contributors

Special thanks to Rob Kaufman (for adding Ruby 1.9 compatibility) and Fabio Kreusch (for adding a custom :path option).


## Feedback

Comments and patches welcome at [http://github.com/mokolabs/styler/](http://github.com/mokolabs/styler/).

