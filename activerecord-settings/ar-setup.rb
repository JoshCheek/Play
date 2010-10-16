require 'rubygems'
require 'sqlite3'
require 'active_record'


ActiveRecord::Base.establish_connection :adapter => 'sqlite3' , :database => ":memory:" 

class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.string  :name  , :null => false , :size => 30
      t.text    :value
      t.timestamps
    end
  end
end

CreateSettings.migrate :up
