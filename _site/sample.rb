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

def stylesheets
  stylesheets = ["application", "#{controller.controller_name}", "ie7", "ie6"]
  stylesheets.collect! do |name| 
    if File.exist?("#{RAILS_ROOT}/public/stylesheets/#{name}.css")
      case name
      when "ie7"
        "<!--[if IE 7]>\n" + stylesheet_link_tag(name) + "\n<![endif]-->"
      when "ie6"
        "<!--[if IE 6]>\n" + stylesheet_link_tag(name) + "\n<![endif]-->"
      else
        stylesheet_link_tag(name)
      end
    end
  end
  stylesheets.compact.join("\n")
end