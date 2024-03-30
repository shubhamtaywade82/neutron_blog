# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# To remove the fields with error css class in the html after getting an error
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  html_tag.html_safe
end
