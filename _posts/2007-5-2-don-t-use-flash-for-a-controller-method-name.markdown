--- 
layout: post
title: "Don't use flash for a controller method name"
---
While working on a [Flash developers page](http://chumby.com/developers/flash) for the Chumby website, I kept getting this error:

{% highlight bash %}
Error in DevelopersController#flash

You have a nil object when you didn't expect it!
The error occured while evaluating nil.sweep
{% endhighlight %}

Pretty puzzling at first. The method was empty, so what could be wrong here?

{% highlight ruby %}
class DevelopersController < ApplicationController

  def flash
  end

end
{% endhighlight %}

Eventually... it hit me! ActionController has its own [flash method](http://api.rubyonrails.org/classes/ActionController/Flash.html) which is used to display flash notices and warnings.

<p>But, in this case, I was making a page about Adobe Flash, so I was running over a reserved word for controller method names. Kinda obvious, once you think about it.</p>

<p>What's the workaround? Well... if you really need your page to be named "flash" (and I did), just remove the method from your controller. As long as you have a template named flash.rhtml, the page will still load.</p>
