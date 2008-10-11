require "erb"
require "rubygems"
require "activesupport"

module TitleHelpers
  HINT = "~ PLEASE SET A TITLE ~"

  # Configuration
  mattr_writer :hints
  @@hints = true
  def self.hints?
    Rails.env == "development" && @@hints
  end
  
  def self.included(klass)
    klass.helper_method :title, :title=, :full_title=, :title!,
                        :format_string_escape, :fs_escape
  end
  
protected

  def title(site_title = nil)
    if TitleHelpers.hints? && !@title && !@full_title
      @full_title = HINT
    end
    
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
  
  def title!
    self.full_title=("%s")
  end
  
  def format_string_escape(string)
    string.to_s.gsub('%', '%%')
  end
  alias_method :fs_escape, :format_string_escape
  
end
