--- 
layout: post
title: Roll your own in-place editor
---
Recently, I needed a quick way to edit a model name in place.

I ran across <code>#in\_place\_editor</code> in the Rails API and it worked perfectly... almost no work on my end, and sweet just-like-Flickr renaming goodness.

{% highlight ruby %}
<%= in_place_editor :name, :url => {:action => "rename_channel"}, :save_text => "Save", :with => "Form.serialize(form) + '&channel=#{@channel.id}'" %>
{% endhighlight %}

My happiness was short-lived, as I realized I needed to tweak some things (highlight color, submit button placement, etc.) And, strangely, Rails seem to ignore some of the options I was passing in.

But, hey, it's just a helper, right? So, when all else fails, let's write some code ourselves. Here's the standard output from this helper (and some ERB to insert the channel ID):

{% highlight javascript %}
<script type="text/javascript">
//<![CDATA[
new Ajax.InPlaceEditor('name', '/widgets/rename_channel', {callback:function(form) { return Form.serialize(form) + "&channel=<%= @channel.id %>" }, okText:'Save'})
//]]>
</script>
{% endhighlight %}

So, using [this script.aculo.us documentation](http://wiki.script.aculo.us/scriptaculous/show/Ajax.InPlaceEditor), let's throw in some custom options that Rails doesn't support.

{% highlight javascript %}
<script type="text/javascript">
//<![CDATA[
new Ajax.InPlaceEditor('name', '/widgets/rename_channel', {callback:function(form) { return Form.serialize(form) + "&channel=<%= @channel.id %>" }, okText:'Save', formClassName:"edit_name", clickToEditText:'Click to rename channel', highlightcolor:'#cdd8ea'})
//]]>
</script>
{% endhighlight %}

Perfect! Now our editor has a custom highlight color, better hover text, and a new form class name.
