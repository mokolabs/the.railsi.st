--- 
layout: post
title: "Don't use finders with validation helpers"
comments: 9
---
Rather innocently, I tried using this validation on my Category model.

{% highlight ruby %}
validates_exclusion_of :name,
                       :within => Widget.find(:all).collect(&:name), 
                       :message => "used by a widget"
{% endhighlight %}

The idea behind this validation was to make sure a Category doesn't have the same name as a Widget.

But since validations are class methods, they get loaded whenever you access a model. So that means we get an extra SQL query <u>every time</u> we do anything with our Category class, not just on create or update.

{% highlight bash %}
User Load (0.001142)   SELECT * FROM widgets LIMIT 1
{% endhighlight %}

This might not seem like a big deal, but it's always good practice to keep database calls to a minimum.

So what's the workaround? Use a protected <code>#validate</code> method instead.

{% highlight ruby %}
def validate
  errors.add(:name, "used by a widget") if Widget.find_by_name(self.name)
end
{% endhighlight %}

You get the same validation, but without all the extra SQL love.

