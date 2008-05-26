require 'test/unit'
require File.join(File.dirname(__FILE__), '../lib/title_helpers')

class FakeController
  def self.helper_method(*args); end
  
  def initialize
    @template = Object.new
  end
  
  include TitleHelpers
end


class TitleHelpersTest < Test::Unit::TestCase
  
  def setup
    @controller = FakeController.new
  end
  
  def assert_equal_in_controller(expected, &block)
    t = nil
    assert_equal expected, @controller.instance_eval(&block)
  end
  
  
  def test_format_string_escape
    assert_equal_in_controller("x") { format_string_escape("x") }
    assert_equal_in_controller("%%s") { format_string_escape("%s") }
  end


  def test_title_with_suffix
    assert_equal_in_controller("Welcome – My Site") do
      self.title = "Welcome"
      title("My Site")
    end
  end

  def test_title_with_no_suffix
    assert_equal_in_controller("Welcome") do
      self.title = "Welcome"
      title
    end
  end
  
  def test_title_with_format_string_without_suffix
    assert_equal_in_controller("%s") do
      self.title = "%s"
      title
    end
  end
  
  def test_title_with_format_string_with_suffix
    assert_equal_in_controller("%s – My Site") do
      self.title = "%s"
      title("My Site")
    end
  end
  
  def test_title_escapes_html
    assert_equal_in_controller("&lt;b&gt;ad") do
      self.title = "<b>ad"
      title
    end
  end

    

  def test_full_title_without_format_string
    assert_equal_in_controller("Welcome!") do
      self.full_title = "Welcome!"
      title("My Site")
    end
  end

  def test_full_title_with_format_string
    assert_equal_in_controller("Welcome to My Site!") do
      self.full_title = "Welcome to %s!"
      title("My Site")
    end
  end
  
  def test_full_title_without_suffix_without_format_string
    assert_equal_in_controller("Welcome") do
      self.full_title = "Welcome"
      title
    end
  end

  def test_full_title_without_suffix_with_format_string
    assert_equal_in_controller("Welcome to %s") do
      self.full_title = "Welcome to %s"
      title
    end
  end
  
  def test_full_title_with_percentage_sign_and_suffix
    assert_raises(ArgumentError) do
      assert_equal_in_controller("100% French bulldogs") do
        self.full_title = "100% French bulldogs"
        title("My Site")
      end
    end
    assert_nothing_raised do
      assert_equal_in_controller("100% French bulldogs") do
        self.full_title = "100%% French bulldogs"
        title("My Site")
      end
    end
  end
  
  def test_full_title_with_percentage_sign_and_no_suffix
    assert_equal_in_controller("100% French bulldogs") do
      self.full_title = "100% French bulldogs"
      title
    end
  end
  
  def test_full_title_escapes_html
    assert_equal_in_controller("&lt;b&gt;ad") do
      self.full_title = "<b>ad"
      title("My Site")
    end
  end
  
  
  def test_combining_title_and_full_title
    assert_equal_in_controller(["Welcome to My Site!", "Welcome"]) do
      self.title = "Welcome"
      self.full_title = "Welcome to %s!"
      [title("My Site"), title]
    end
  end

end
