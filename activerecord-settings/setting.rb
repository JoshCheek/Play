require File.dirname(__FILE__) + '/ar-setup'

# code to make the tests pass
class Setting < ActiveRecord::Base

  DEFAULT      = false    # default value
  MAX_NAME     = 30       # characters long
  InvalidName  = Class.new Exception
  
  # on 2.3.8, if this throws a lot of warnings
  # you can get around it with
  # gem uninstall i18n
  # gem install i18n -v 0.3.7
  validates_uniqueness_of :name 
  
  def self.[]( name , default=DEFAULT )
    setting name do |setting|
      setting.value = default unless setting.value_initialized?
      setting.value
    end
  end
  
  def self.[]=(name,value)
    setting name do |setting|
      setting.value = value
    end
  end
  
  # returns the result of the block
  def self.setting(name)
    validate_name name
    name = name.to_s
    setting = find_by_name(name) || new( :name => name )
    result  = yield setting
    setting.save! if setting.changed?
    result
  end
  
  def name=(name)
    validate_name name
    super
  end
  
  def value=(value)
    super(serialize value)
  end

  def value
    deserialize super
  end
  
  def value_initialized?
    value?
  end
  
private

  def serialize(object)
    YAML.dump object
  end
  
  def deserialize(object)
    YAML.load object
  end
  
  def validate_name(name)
    self.class.validate_name name
  end
  
  def self.validate_name(name)
    raise InvalidName.new("#{name.inspect} is not a String or Symbol.") unless name.kind_of?(String) || name.kind_of?(Symbol)
    raise InvalidName.new("#{name} is too long, cannot be more than #{MAX_NAME} characters.") if name.length > MAX_NAME
  end
    
end
























