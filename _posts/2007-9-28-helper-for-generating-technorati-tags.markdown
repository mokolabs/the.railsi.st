--- 
layout: post
title: Helper for generating Technorati tags
comments: 4
---
Need to support [Technorati tags](http://technorati.com/help/tags.html) in your application?

Here's a helper that does all the work. Just give it a list of tags and the helper will spit out all the necessary html for Technorati to index your content. (When you deploy, don't forget to [ping them](http://technorati.com/ping/) so they index you.)

{% highlight ruby %}
def technorati_tags_for(model)
  tag_links = Array.new
  model.tags.split(',').sort.each do |tag|
  tag_links << '<a href="http://technorati.com/tag/' + 
                tag.split(" ").join("+") + '" rel="tag">' + 
                tag + '</a>'
  end
  tag_links.join("\n")
end
{% endhighlight %}

<h2>Assumptions</h2>

Your tags are comma delimited and stored in a model attribute called <code>tags</code>. (This helper should be placed on each individual blog post... typically the <code>"show"</code> action.)

<h2>Extra credit</h2>

+ If you have a tag cloud, replace <code>http://technorati.com/tag/</code> with the path to your local tag pages.
+ Don't need to show the tags? Wrap them in a div that's styled with <code>display: none;</code>.
+ Think about automatically adding a default set of tags to each post. If, for instance your blog was 100% about Rails, add tags for "rails" and "ruby on rails". You can add these in the helper without cluttering up your database or admin interface with redundant information.
