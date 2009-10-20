--- 
layout: post
title: Roll your own attachment_fu validations
comments: 2
---
Lots of folks use attachment_fu to handle image uploads. It handles all the dirty work of uploading files, integrates with Amazon S3, and even supports all the different image libraries.

Which is awesome... but it kinda sucks at validating files. Take a pretty typical Photo class:

{% highlight ruby %}
class Photo < ActiveRecord::Base
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 5.megabytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>', :widget => "262x262>" },
                 :processor => MiniMagick
  validates_as_attachment

end
{% endhighlight %}

What happens when you forget to select a file before uploading?

<ul>
<li>Content type can't be blank</li>
<li>Content type is not included in the list</li>
<li>Size can't be blank</li>
<li>Size is not included in the list</li>
<li>Filename can't be blank</li>
</ul>

So, let's try uploading a Word document:

<ul>
<li>Content type is not included in the list</li>
</ul>

Or a file that's too big:

<ul>
<li>Size is not included in the list</li>
</ul>

Let's try it again, but in English:

{% highlight ruby %}
class Photo < ActiveRecord::Base
  has_attachment :content_type => :image, 
                 :storage => :file_system, 
                 :max_size => 5.megabytes,
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>', :widget => "262x262>" },
                 :processor => MiniMagick
  
  def validate
    errors.add_to_base("You must choose a file to upload") unless self.filename
    
    unless self.filename == nil
      
      # Images should only be GIF, JPEG, or PNG
      [:content_type].each do |attr_name|
        enum = attachment_options[attr_name]
        unless enum.nil? || enum.include?(send(attr_name))
          errors.add_to_base("You can only upload images (GIF, JPEG, or PNG)")
        end
      end
      
      # Images should be less than 5 MB
      [:size].each do |attr_name|
        enum = attachment_options[attr_name]
        unless enum.nil? || enum.include?(send(attr_name))
          errors.add_to_base("Images should be smaller than 5 MB in size")
        end
      end
        
    end
  end

end
{% endhighlight %}

To get started, let's drop the <code>validates_as_attachment</code> method. Or, more specifically, try extracting its useful parts into something more useful.

Since we're dropping attachment_fu's validations, we need to roll our own validations for the Photo class. You can do this by declaring a <code>validate</code> method in your class, and adding appropriate logic.

We can also use <code>errors.add_to_base</code> to get total control over your validation messages. By default, Rails pair the model attribute name with an error message ("person" + "is missing an ear"), but sometimes this can lead to awkward phrases ("person is empty").

You'll need to custom this for your application, of course, but this post should give you some examples.

(I'm planning to follow this blog post up with a series of posts about improving validation messages.)
