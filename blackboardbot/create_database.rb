# code to create the database and boards
# run once

require 'environment'
require 'sqlite3'


# documentation at http://www.sqlite.org/lang_createtable.html
db = SQLite3::Database.new( Settings.db.database )

# create the tables
db.execute <<-__________________________________________________
              CREATE TABLE IF NOT EXISTS posts (
                id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
                subject           Text,
                body              Text,
                author            Text,
                message_board_id  Integer
              );
              __________________________________________________

db.execute <<-__________________________________________________
              CREATE TABLE IF NOT EXISTS message_boards (
                id INTEGER PRIMARY KEY ASC AUTOINCREMENT,
                name  Text,
                url   Text
              );
              __________________________________________________

# insert the message boards
Settings.db.boards.each do |board|
  unless MessageBoard.find :first , :conditions => board
    MessageBoard.new(board).save!
  end
end
