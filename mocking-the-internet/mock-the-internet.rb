require 'rubygems'
require 'mechanize'
require 'test/unit'
require 'fakeweb'

def my_code_to_find_links
  Mechanize.new.get('http://www.google.com').links
end

class TestGoogle < Test::Unit::TestCase
  def test_should_pass
    FakeWeb.register_uri :get , "http://www.google.com" , :body => '<a>Images</a> <a>Video</a>' , :content_type => "text/html"
    assert_equal 'Images' , my_code_to_find_links.first.text
  end
end

