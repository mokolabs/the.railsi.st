--- 
layout: post
title: How to customize attachment_fu file names
---
For uploading files, it's pretty hard to beat [attachment_fu](http://svn.techno-weenie.net/projects/plugins/attachment_fu/). But it can be overkill for smaller projects.

One issue is that attachment_fu uses id partioning. This is a great way to overcome native file system limitations when you have more than 32,000 attachments. By segmenting files into different directories, you can have millions of attachments, if necessary. Empahsis on "if necessary". It usually isn't.

Also, attachment_fu preserves original filenames. While this make sense for many projects, sometimes you need to have control over the naming of attachments.

Since a lot of people use Mike Clark's excellent [File Upload Fu tutorial](http://clarkware.com/cgi/blosxom/2007/02/24), let's use that as our starting point for customizing file names.

If we complete the tutorial, here's how attachment_fu will store our first image upload:

{% highlight bash %}
public/mugshots/0000/0001/chunkybacon.png
public/mugshots/0000/0001/chunkybacon_thumb.png
{% endhighlight %}

Hmmm, not bad. But I'd like to customize things:

+ Images should be stored in <code>public/images/</code>
+ Thumbnails should be organized by size
+ ID partioning (<code>0000/0001/</code>) should be disabled
+ Images should be renamed with the Mugshot id

So let's open up our Mugshot model and tweak it a bit.

{% highlight ruby %}
class Mugshot < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => 500.kilobytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' },
                 :path_prefix => 'public/images/mugshots'
  validates_as_attachment

  def full_filename(thumbnail = nil)
    file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix]
    case self.thumbnail
    when "thumb"
      File.join(RAILS_ROOT, file_system_path, 'thumb', thumbnail_name_for(thumbnail, self.parent_id))
    else
      File.join(RAILS_ROOT, file_system_path, 'fullsize', thumbnail_name_for(thumbnail, self.id))
    end
  end

  def thumbnail_name_for(thumbnail = nil, asset = nil)
    extension = filename.scan(/\.\w+$/)
    return "#{asset}#{extension}"
  end
end
{% endhighlight %}

Now, when we upload an image, it will be stored like so:

{% highlight bash %}
public/images/mugshots/fullsize/2.png
public/images/mugshots/thumb/2.png
{% endhighlight %}

How does this work?

Well, first, we customize the <code>:path\_prefix</code> value in <code> has_attachment</code> to set the base location of our files.

Second, we override the <code>full\_filename</code> method to force attachment\_fu to save each thumbnail type into its own directory. This way, all large thumbnails are stored in <code>images/mugshots/fullsize</code> and all small thumbnails are stored in <code>images/mugshots/thumb</code>. (By default, attachment\_fu stores all thumbnail sizes for an object in a single directory.)

Lastly, we override the <code>thumbnail\_name\_for</code> method to customize the filename to our liking... in this case, the file name will consist of the parent mugshot id, plus the original file's file extension.

That's all we need to do... now our files are stored exactly where we want them!

(Thanks to AirBlade Software for [showing the way](http://blog.airbladesoftware.com/2007/6/20/how-to-store-thumbnails-and-full-size-images-in-different-directories-with-attachment_fu).)

<h2>Extra credit</h2>

If your attachments belong to another model (like a user), you'll need to use a before filter to associate the parent model id with the thumbnail you wish to store.

{% highlight ruby %}
before_thumbnail_saved do |record, thumbnail|
  thumbnail.user_id = record.user_id
end
{% endhighlight %}

You'll also need an extra migration to store the parent id. (Don't use the parent\_id field... that's reserved by attachment_fu.)

<h2>Extra, extra credit</h2>

What if you want three sizes? Large (original image), medium, and small?

{% highlight ruby %}
has_attachment :content_type => :image,
               :storage => :file_system,
               :max_size => 500.kilobytes,
               :thumbnails => { :small => '100x100>', :medium => '200x200>' },
               :path_prefix => 'public/images/mugshots'
validates_as_attachment

def full_filename(thumbnail = nil)
  file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix]
  case self.thumbnail
  when "small"
    File.join(RAILS_ROOT, file_system_path, 'small', thumbnail_name_for(thumbnail, self.parent_id))
  when "medium"
    File.join(RAILS_ROOT, file_system_path, 'medium', thumbnail_name_for(thumbnail, self.parent_id))
  else
    File.join(RAILS_ROOT, file_system_path, 'large', thumbnail_name_for(thumbnail, self.id))
  end
end
{% endhighlight %}
