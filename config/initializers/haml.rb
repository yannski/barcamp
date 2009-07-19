# Auto escape all outputs. Warning ! To render a partial or yield something in a view, you must now use != instead of =
Haml::Template.options[:escape_html] = true
Haml::Template.options[:attr_wrapper] = '"'

