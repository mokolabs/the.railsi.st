require 'rubygems'
require 'sequel'
require 'fastercsv'
require 'fileutils'

# Simple format comment bodies
def simple_format(text, html_options={})
 # text = text.to_s.dup
 # text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
 # text.gsub!(/\n\n+/, "</p>\n\n<p>")  # 2+ newline  -> paragraph
 # text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />' + "\n") # 1 newline   -> br
 # text.insert 0, "<p>"
 # text << "</p>"
 text
end

# Let's get started
buffer = String.new

# Grab comments
QUERY = "SELECT author, author_url, body, created_at, title FROM contents WHERE type = 'Comment' AND article_id = 2 ORDER BY article_id, updated_at"
db = Sequel.mysql("railsist", :user => "root", :password => "", :host => "localhost")
db[QUERY].each do |post|
  
# Link author if possible
if post[:author_url] != ''
  post[:author] = '<a href="' + post[:author_url] + '">' + post[:author] + '</a>'
end
  
# Format comment
comment = <<eos
<!-- Comment -->
<div class="comment">
<div class="attribution">
<span class="author">#{post[:author]}</span>
<span class="date">#{post[:created_at].strftime("%B %d, %Y")}</span>
</div>
<div class="body">
#{simple_format(post[:body])}
</div>

eos

buffer = buffer + comment

end

puts "<h2>Comments</h2>"
puts
puts buffer