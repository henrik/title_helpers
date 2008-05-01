module TitleHelpers
  
  def self.included(klass)
    klass.helper_method :title, :title=, :full_title=,
                        :format_string_escape, :fs_escape
  end
  
protected

  def title(site_title)
    ERB::Util.h((@full_title || "%s") % site_title)
  end
    
  def title=(title)
    self.full_title = "#{fs_escape(title)} – %s"
  end
  
  # If the helpers are used in a view, then the code runs _after_ instance variables have
  # been copied from the controller to the template. Without manually copying them over like
  # this, they would not be available to layouts.

  def full_title=(title)
    @full_title = @template.instance_variable_set("@full_title", title)
  end
  
  def format_string_escape(string)
    string.gsub('%', '%%')
  end
  alias_method :fs_escape, :format_string_escape
  
end
