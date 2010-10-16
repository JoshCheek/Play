require File.dirname(__FILE__) + '/ar-setup'

# code to make the tests pass
class Setting < ActiveRecord::Base
  def self.[](name)
    setting = Setting.create :name => name
  end
end
























