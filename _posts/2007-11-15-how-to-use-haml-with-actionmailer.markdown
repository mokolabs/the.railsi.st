--- 
layout: post
title: How to use Haml with ActionMailer
---
Poor ActionMailer. It just doesn't get enough love.

If you try using [Haml](http://haml.hamptoncatlin.com/) in your email templates, Rails will ignore your pretty little Haml code.

Why does this happen? Because, by default, ActionMailer only recognizes .erb or .rhtml extensions with templates that use a specific mime type (example: <code>forgot_password.text.html.erb</code>).

But thanks to [changest 7534](http://dev.rubyonrails.org/ticket/7534), ActionMailer can now use Haml too.

Just drop this into your environment.rb and restart:

{% highlight ruby %}
ActionMailer::Base.register_template_extension('haml')
{% endhighlight %}

This should work on Rails 1.2.4 and up.

<h2>Extra credit</h2>

Don't use HTML email unless you really need it. You'll upset users and go crazy trying to make things work in a hundred email clients. Stick to text unless HTML can really add substantial value to your notifications.
