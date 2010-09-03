# setup the database code
ActiveRecord::Base.establish_connection(  :adapter   =>  Settings.db.adapter  ,
                                          :host      =>  Settings.db.host     ,
                                          :database  =>  Settings.db.database ,
                                          :username  =>  Settings.db.username ,
                                          :password  =>  Settings.db.password
                                       )

class Post < ActiveRecord::Base
  belongs_to :message_board

  def self.send_message_after_create!( should_enable = true )
    Settings.email.enable = !!should_enable
  end

  # sends an email/text message for each new post
  def after_create
    return unless Settings.email.enable
    Pony.mail   :to       =>  Settings.email.to         ,
                :from     =>  Settings.email.from       ,
                :subject  =>  "#{author} - #{subject}"  ,
                :body     =>  body                      ,
                :via      =>  :smtp                     ,
                :smtp     =>  { :host       => Settings.email.host  ,
                                :port       => Settings.email.port  ,
                                :tls        => Settings.email.tls   ,
                                :user       => Settings.email.from  ,
                                :password   => Settings.email.pass  ,
                                :auth       => Settings.email.auth  ,
                              }
  end
end


class MessageBoard < ActiveRecord::Base
  has_many :posts
  
  def self.save_all_new_posts
    each_new_post_from_board { |board,post_attributes| board.posts.build(post_attributes).save }
  end
  
  # yields the board, and the post attributes in a hash of subject, body, and author
  def self.each_new_post_from_board
    each_post_from_board do | db_board , post_attributes |
      yield( db_board , post_attributes ) unless Post.find( :first , :conditions => post_attributes )
    end
  end
  
  # yields the board, and the post attributes in a hash of subject, body, and author
  def self.each_post_from_board( &proc )
    BlackboardSite.each_post_from_board &proc
  end

end


