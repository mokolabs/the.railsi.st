--- 
layout: post
title: Helper for converting links into Markdown
---
I'm working on importing lots of legacy content into Rails, so I came up with this little method to convert old-school link formats (like [BBCode](http://en.wikipedia.org/wiki/BBCode) and HTML) into [Markdown](http://daringfireball.net/projects/markdown/).

{% highlight ruby %}
def convert_links_to_markdown(text)
  # [url=http://google.com]Google[/url]
  text = text.gsub(/(\[url\=)(.*?)(\])(.*?)(\[\/url\])/, ('[\4](\2)'))
    
  # <a href="http://google.com">Google</a>
  text = text.gsub(/(<a href=")(.*?)(">)(.*?)(<\/a>)/, ('[\4](\2)'))
end
{% endhighlight %}

Here's a [Pastie version](http://pastie.caboo.se/170623), as well. (Special thanks to [Matt Aimonetti](http://railsontherun.com/) for fixing a bug in the Regexp.)
