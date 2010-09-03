# pulled this off the internetz      http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/176496
class String
  def remove_nonascii(replacement)
    n=self.split("")
    self.slice!(0..self.size)
    n.each { |b|
      if b[0].to_i< 32 || b[0].to_i>127 then
        self.concat(replacement)
      else
        self.concat(b)
      end
    }
    self.to_s
  end
end


# module that knows how to log on, log out, and generally traverse blackboard
module BlackboardSite
  
  # bread and butter of this module
  # yields the board, and the post attributes in a hash of subject, body, and author
  def self.each_post_from_board
    login
    MessageBoard.all.each do |db_board|
      each_forum_for_board internet.get(db_board.url) do |forum|
        each_forum_thread forum do |thread|
          each_forum_post( thread ) { |post| yield db_board , attributes_for_forum_post(post) }
        end
      end
    end
  ensure
    logout
  end

private


  # ---------- SUPPORT FUNCTIONS ----------
  
  # removes html tags that get stuck inside the code
  def self.remove_html( str )
    str && str.gsub( /<[^>]*?>/ , '' ).remove_nonascii('').strip
  end

  # parses a uri for the options passed, returns them as a hash
  def self.get_options( uri )
    uri.gsub(/^[^m]*message\?/,'').split('&').inject({}) do |hash,option|
      key,value = option.split('=')
      hash[key] = value
      hash
    end
  end

  # turns a uri from a forum into a thread link
  def self.thread_link_from_page_uri( uri )
    options = get_options uri
    options[    'action' ] = "message_tree"
    options[ 'thread_id' ] = options['message_id']
    "message?nav=db_thread_list_entry&#{ options.map { |k,v| "#{k}=#{v}" }.join('&') }"
  end

  # turns a uri from a thread into a post link
  def self.post_link_from_thread_uri( thread_uri , post_uri )
    options = get_options thread_uri
    post_uri =~ /javascript:display\('([\d_]*)','([\d_]*)','[^']*'\)/
    options[  'thread_id' ] = $1
    options[ 'message_id' ] = $2
    options[     'action' ] = 'message_frame'
    options[   'forum_id' ].gsub!(/_1$/,'')
    "message?nav=db_thread_list_entry&#{ options.map { |k,v| "#{k}=#{v}" }.join('&') }"
  end

  # receives mechanize object for the post, returns attributes hash
  # ugly because their code is inconsistent
  def self.attributes_for_forum_post( post )
    post.at('//html/body/form/table/tr/td').inner_html =~ /<\/strong>\s(.*)$/                      ;  subject = $1
    post.at('/html/body/form/table/tr[2]').inner_html  =~ /<strong>Author:<\/strong>\s*(.*?)<br>/  ;  author  = $1
    body = post.at('/html/body/form/table').children[-2].children[-2].children.last.children.last.children[-2].inner_html
    { :subject => remove_html(subject) , :body => remove_html(body) , :author => remove_html(author) }
  end
  
  
  # ---------- TRAVERSAL FUNCTIONS ----------
  
  # receives mechanize object for the thread with the links to the posts
  def self.each_forum_post(thread)
    thread.links.each { |post_link|
      next unless post_link.uri.to_s =~ /javascript:display/
      post = internet.get post_link_from_thread_uri( thread.uri.to_s , post_link.uri.to_s )
      yield post
    }
  end

  # receives mechanize object for the forum with the links to the threads
  def self.each_forum_thread(forum)
    forum.links.each { |thread_link|
      next unless thread_link.href =~ /action=list_messages/
      thread = internet.get thread_link_from_page_uri( thread_link.uri.to_s )
      yield thread
    }
  end

  # receives mechanize object for the message board with links to the forums
  # each forum (each course creates however many forums they need, usually 1)
  def self.each_forum_for_board(board) 
    board.links.each { |forum_link|
      yield internet.get(forum_link.uri) if forum_link.href =~ %r'webapps/discussionboard/do/forum'
    }
  end


  # ---------- SETUP / TEARDOWN ----------

  def self.internet
    @internet ||= WWW::Mechanize.new
  end
  
  def self.login
    login_page                     =  internet.get Settings.blackboard.login_url
    login_form                     =  login_page.form 'login'
    login_form.user_id             =  Settings.blackboard.user_id
    login_form.encoded_pw          =  Settings.blackboard.encoded_pw
    login_form.encoded_pw_unicode  =  Settings.blackboard.encoded_pw_unicode
    internet.submit(login_form)
  end
  
  def self.logout
    internet.get Settings.blackboard.logout_url
  end
  
end

