require 'rubygems'
require 'sqlite3'
require 'active_record'


ActiveRecord::Base.establish_connection :adapter => 'sqlite3' , :database => ":memory:" 

class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.text :name
      t.text :value
    end
  end
end

CreateSettings.migrate :up
