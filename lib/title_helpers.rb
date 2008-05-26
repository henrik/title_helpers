require "erb"

module TitleHelpers
  
  def self.included(klass)
    klass.helper_method :title, :title=, :full_title=,
                        :format_string_escape, :fs_escape
  end
  
protected

  def title(site_title = nil)
    unless site_title
      title = fs_escape(@title || @full_title)
    else
      title = @full_title || (@title && "#{fs_escape @title} – %s") || "%s"
    end
    ERB::Util.h(title % site_title)
  end
  
  # If the helpers are used in a view, then the code runs _after_ instance variables have
  # been copied from the controller to the template. Without manually copying them over like
  # this, they would not be available to layouts.
    
  def title=(title)
    @title = @template.instance_variable_set("@title", title)
  end
  
  def full_title=(title)
    @full_title = @template.instance_variable_set("@full_title", title)
  end
  
  def format_string_escape(string)
    string.to_s.gsub('%', '%%')
  end
  alias_method :fs_escape, :format_string_escape
  
end
