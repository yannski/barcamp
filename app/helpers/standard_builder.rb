class ActionView::Helpers::FormBuilder
  
  %w(text_field_with_auto_complete internationalized_text_area internationalized_text_field slider radio_buttons date_picker select fckeditor_textarea fck_textarea fckeditor_div_id audio_player_tag datetime_select).each do |name|
     define_method(name) do |*args|
       args = args.reverse.push(@object_name).reverse      
       @template.send(name, *args)
     end
   end
end

class StandardBuilder < ActionView::Helpers::FormBuilder
  # Configuration options are:
  # * +label_text+  - text that will be placed inside the label (default: labelo_s.humanize)
  # * +required+    - tells whether this field is required or not, if required not precised and object respond_to method 'def mandatory_field(label)' required is transparantly set
  # * +before_text+ - text that will be append before the input field
  # * +after_text+  - text that will be append after the input field
  #
  # Generate something like:
  #   <label for="product_description">label_text</label>
  #   before_text <%= formext_area 'description' %> after_text 
  def self.create_tagged_field(method_name)
    define_method(method_name) do |label, *args|
      if args.last.is_a? Hash
        options     = args.pop
        label_text  = options.delete(:label_text)
        container_class  = options.delete(:container_class)
        required    = options.delete(:required)
        textile     = options.delete(:textile)
        before_text = options.delete(:before_text)
        help        = options.delete(:help)
        readonly    = options[:readonly]? true : false
        errors       = @object.errors.on(label.to_sym) unless @object.nil?
        choices      = options.delete(:choices)
        auto_complete = options.delete(:auto_complete_url)
        #after_text  = options.delete(:after_text)
        #focus       = options.delete(:focus)
      end
      
      before_text_span = before_text ? @template.content_tag("span", before_text, :class => "before") : ""
      
      #if focus
      #  html_id = "#{@object_name}_#{label}"
      #  after_text += "\n" + @template.javascript_tag("$('#{html_id}').focus()")
      #end
      
      if textile == true
        label_text += ' - ' + @template.content_tag('span', "formatez le texte en utilisant #{@template.link_to('textile','http://hobix.com/textile/',:popup => true)}", :class => :textile)
      end
      
      content = (label_text && !%w(radio_button check_box).include?(method_name)) ? @template.content_tag("label", label_text, :for => "#{@object_name}_#{label}".gsub(/\[\]/,'').gsub(/[\[\]]/,'_') ) : ""
      content += before_text_span
      
      if %w(select country_select file_field).include? method_name
        content += @template.content_tag("span", super, :class => 'borders')
        content += @template.content_tag('span', "&nbsp;", :class => 'right_border')
      elsif method_name == "text_area"
        content += @template.content_tag("span", super, :class => 'borders')
      elsif method_name == "radio"
        choices.each do |choice|
          content += @template.content_tag('label', @template.radio_button(@object_name, label, choice[:value], choice[:checked]) + @template.content_tag('span','&nbsp;',:class => "radio_alt") + @template.content_tag('span',choice[:label], :class => "label"), :class => "choice")
        end
      elsif method_name == "radio_button"
        content += @template.content_tag('label',super + @template.content_tag('span','&nbsp;',:class => "radio_alt") + label_text)
      elsif method_name == "check_box"
        content += @template.content_tag('label',super + @template.content_tag('span','&nbsp;',:class => "box") + label_text, :class => "checkbox")
      elsif method_name == "date"
        value = (@object.respond_to?(label) && @object.send(label)) ? @object.send(label).strftime("%Y-%m-%d") : ""
        content += @template.text_field_tag("#{@object_name}[#{label}]", value) + @template.image_tag('/images/calendar_date_select/calendar.gif')
      else
        content += super
      end
      
      if auto_complete
        content += @template.hidden_field_tag "auto_complete_url", auto_complete, :class => "auto_complete_url", :id => nil
      end
      
      if help && !%w(check_box).include?(method_name)
        content += @template.link_to "Aide", '#', :class => "help_field"
      end
      
      if errors
        content += @template.content_tag("span", errors, :class => 'error')
      end
      
      # class_ary = %w(input)
      # class_ary << method_name
      # class_ary << container_class if container_class
      # class_ary << "required" if required
      # class_ary << "help" if help
      # class_ary << "readonly" if readonly
      # class_ary << "error" if errors
      # class_ary << "before" if before_text
      # class_ary << "text_field" if method_name == "calendar_date_select" or method_name == "date"
      # class_ary << "radio" if method_name == "radio_button"
      # class_ary << "auto_complete" if auto_complete
      # content = @template.content_tag("p", content, :class => class_ary.join(" "))
      if help && %w(check_box).include?(method_name)
        content += @template.content_tag('div', help, :class => "help #{method_name}")
      elsif help
        content += @template.content_tag('div',@template.content_tag('div', help, :class => 'container'), :class => 'bubble small bottom outside hidden') if help
      end
      return content
    end
  end
  
  %w(text_field password_field text_area country_select radio_button select file_field check_box time_zone_select text_field_with_auto_complete internationalized_text_area internationalized_text_field date_select date_picker slider fckeditor_textarea datetime_select calendar_date_select radio date).each do |name|
    create_tagged_field(name)
  end
  
  # Image file field is a special file_field that displays an image before the file_field tag
  def image_file_field(label, options = {})
    before_text  = ""
    before_text += if @object.size
      @template.image_tag(@object.public_filename)
    else
      "no file uploaded"
    end
    before_text += @template.tag('br')
    self.file_field(label, options.merge({:before_text => before_text}))
  end
  
  # Audio file field is a special file_field that displays an audio player
  def audio_file_field(label, options = {})
    before_text  = @template.content_tag('p', @object.send(label) ? @template.audio_player_tag(@object.send(label).public_filename) : "pas d'extrait uploadé")
    before_text += @template.tag "br"
    after_text  = @template.tag "br"
    after_text += @template.tag "br"
    self.file_field("#{label}_binary", options.merge({:before_text => before_text, :after_text => after_text}))
  end
  
  def checkbox(label, name, value, checked, options = {})
    containerClass = options[:class]? options[:class] : ""
    options[:class] = "checkbox"
    name = @object_name ? @object_name + "[" + name.to_s + "]" : name
    content = @template.check_box_tag name, value, checked, options
    content += @template.content_tag "span", "&nbsp;", :class => "box"
    content += label
    content = @template.content_tag("label", content, :for => options[:id])
    @template.content_tag("p", content, :class => "checkbox input" + containerClass)
  end
  
  # Configuration options are:
  # * +submit_name+ - name of the submit_tag
  def submit(value, options = {})
    options[:class] = options[:class] ? options[:class] + " submit" : "submit"
    @template.content_tag("p", @template.submit_tag(value, options), :class => "input_submit")
  end
  
  def fck_textarea(object, name, options = {})
    external_js = false #disabled for the moment because not necessary for now
    cols = options[:cols] ? options[:cols] : 30
    rows = options[:rows] ? options[:rows] : 8
    
    content = options[:label_text]? @template.content_tag("label", options[:label_text]) : ""
    if external_js == true
      content += @template.content_tag('span', @template.text_area_tag("#{object}[#{name}]", @object.send(name), :cols => cols, :rows => rows, :id => "#{object}_#{name}", :class => "fck"), :class => 'borders')
    else
      content += @template.fck_textarea(object, name, options)
    end
    
    class_ary = %w(input text_area fck)
    class_ary << "help" if options[:help]
    class_ary << "required" if options[:required] and options[:required]==true
    
    content = @template.content_tag('p', content, :class => class_ary.join(' '))
    content += @template.content_tag('div',@template.content_tag('div', options[:help], :class => 'container'), :class => 'bubble fulltop') if options[:help]
    
    return content
    
  end
  
end
