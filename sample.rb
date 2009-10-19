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