#!/usr/bin/env ruby
require 'test/unit'
require File.dirname(__FILE__) + '/setting'


# run the unit tests
class TestSettingModel < Test::Unit::TestCase
  
  # some dummy classes for use with test data
  Example1 = Struct.new :a , :b
  Example2 = Class.new do 
    attr_accessor :a , :b
    def initialize(a,b) @a,@b=a,b end
    def ==(ex2) @a,@b=ex2.a,ex2.b end
  end
  
  def object_menagerie
    [ 'a' , :a , 1 , /a/ , [1,2] , true , false , nil , {:a => 1,:b => 2} , Example1.new(1,2) , Example2.new(1,2) ]
  end
  
  def self.to_method_name(str)
    str.gsub(/\s+/,'_').gsub(/\W+/,'')
  end
  
  def self.context(context)
    @context = to_method_name(context)
    yield
    @context = nil
  end
  
  def self.verify( to_verify , &verification )
    prefix = "test_"
    prefix << @context << '_' if @context && !@context.empty?
    define_method prefix << to_method_name(to_verify) , &verification if verification
  end
    
  def setup
    Setting.delete_all
  end
  
  def assert_count(count)
    assert_equal count , Setting.count
  end
  
  def assert_invalid(&block)
    assert_raises ActiveRecord::RecordInvalid , &block
  end
  
  def assert_invalid_name(&block)
    assert_raises Setting::InvalidName , &block
  end
  
  context 'validations' do
    verify 'does not allow duplicate names' do
      assert_count 0
      assert_nothing_raised { Setting.create! :name => 'n' , :value => 'v' }
      assert_count 1
      assert_invalid { Setting.create! :name => 'n' , :value => 'v2' }
      assert_count 1
    end
  end
  
  context 'querying' do
  
    verify "creates a setting when it doesn't exist" do
      assert_count 0
      Setting[:abc]
      assert_count 1
    end
  
    verify "doesn't create a setting when it exists" do
      assert_count 0
      Setting[:abc]
      assert_count 1
      Setting[:abc]
      assert_count 1
    end
    
    verify 'returns the value' do
      Setting[:abc] = 'a'
      assert_equal 'a' , Setting[:abc]
    end
    
    verify 'value has a default' do
      assert_equal Setting::DEFAULT , Setting[:abc]
      assert_equal 123 , Setting[ :xyz , 123 ]
    end
        
    verify 'returns the new value after the value has been changed' do
      Setting[:abc] = 1
      assert_equal 1 , Setting[:abc]
      Setting[:abc] = 2
      assert_equal 2 , Setting[:abc]
    end
    
    verify 'can take string or symbol' do
      Setting[:abc] =  12
      assert_equal     12 , Setting[ :abc  ]
      assert_equal     12 , Setting[ 'abc' ]
      Setting['xyz'] = 13
      assert_equal     13 , Setting[ :xyz  ]
      assert_equal     13 , Setting[ 'xyz' ]
    end
    
    verify 'raises InvalidName on non string or symbol' do
      object_menagerie.each do |object|
        next if object.kind_of?(String) || object.kind_of?(Symbol)
        assert_invalid_name { Setting[object] }
      end
    end
    
    verify 'raises error on string or symbol with over 30 chars' do
      assert_nothing_raised { Setting['aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' ] = '' }
      assert_nothing_raised { Setting[:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  ] = '' }
      assert_invalid_name   { Setting['aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'] = '' }
      assert_invalid_name   { Setting[:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ] = '' }
    end
    
    verify 'queries from the db and not just saving in memory' do
      Setting[:abc] = 12
      setting = Setting.find_by_sql('SELECT * FROM settings').first
      setting.value = 13
      assert_equal 12 , Setting[:abc]
      setting.save
      assert_equal 13 , Setting[:abc]
    end
  end  
  
  
  context 'setting' do
    
    verify "creates a new setting when one doesn't exist" do
      assert_equal 0 , Setting.count
      Setting[:abc] = 1
      assert_equal 1 , Setting.count
    end
    
    verify 'changes the value of the setting' do
      Setting[:abc] = '1'
      assert_equal '1' , Setting[:abc]
      Setting[:abc] = '2'
      assert_equal '2' , Setting[:abc]
    end
    
    verify 'raises error on name with over 30 chars' do
      assert_nothing_raised { Setting['aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa' ] = '' }
      assert_nothing_raised { Setting[:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  ] = '' }
      assert_invalid_name   { Setting['aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'] = '' }
      assert_invalid_name   { Setting[:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ] = '' }
    end
    
    verify 'assert raises error on name that is not string or symbol' do
      assert_nothing_raised { Setting[ 'a' ] = '' }
      assert_nothing_raised { Setting[ :a  ] = '' }
      assert_invalid_name   { Setting[ /a/ ] = '' }
      assert_invalid_name   { Setting[ 0xa ] = '' }
    end
    
    verify 'can set value to be pretty much any type' do
      object_menagerie.each do |object|
        Setting[:serialize] = object
        assert_equal object , Setting[:serialize]
      end
    end
  end


end
