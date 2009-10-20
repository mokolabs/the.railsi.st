--- 
layout: post
title: Problems installing restful_auth?
comments: 7
---
When installing <code>restful_authentication</code>, you run this command:

{% highlight bash %}
patrick$: script/generate authenticated user sessions --include-activation
{% endhighlight %}

And get this error.

{% highlight bash %}
invalid option: --include-activation
{% endhighlight %}

What's wrong with this picture? Remove <code>acts_as_authenticated</code>. You can't use both plugins at the same time.

Dumb, but I'm sure I won't be the only one.
