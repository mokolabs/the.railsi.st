require 'rubygems'
require 'sequel'
require 'fastercsv'
require 'fileutils'

# This code can be used to export comments from a single Mephisto blog post.

# INSTRUCTIONS

# 1. Place this file in _import within your Jekyll app directory
# 2. Update your db credentials below (:user, :pass, etc.)
# 3. Open the Mephisto admin interface.
# 4. Navigate to the article you want to grab comments from
# 5. Copy the numeric id from the query strong.
#     (Yes... there are better ways of doing this. Use them if necessary.)
# 6. Replace the article_id value in the QUERY below with the numeric id you copied.
# 7. Open up a Terminal and navigate to your Jekyll app directory
# 8  ruby comments.rb
# 9  Copy the resulting HTML block.
# 10  Place into a file of your choice.

# Simple format comment bodies
# (I've disabled this, but just uncomment to reactivate)
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
  
# Format comment (tweak as you see fit)
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

# Save comment to output buffer
output = output + comment

end

# Export all comments for this record
puts "<h2>Comments</h2>"
puts
puts output
