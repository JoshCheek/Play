# resolve stupid relative path issues, from http://tomafro.net/2010/01/tip-relative-paths-with-file-expand-path
Dir.chdir File.expand_path( '..' , __FILE__ )

# load gems
require 'rubygems'      # allows the other gems to be loaded. 
                        # I've thought about this a lot, and decided that 
                        # requiring rubygems is the best decision in this case:
                        # 1) this code is not a gem so will probably not be required by other code
                        # 2) the rake task that installs the gems uses rubygems, so this is congruent
                        # 3) the users who may potentially use this app are schoolmates who know little of Ruby,
                        #    I don't wish to add to their burden by requiring them to know even more esoteric
                        #    little tricks like setting environment variables
                        # 4) the people who use other gem managers are not likely to use this code, and if they are,
                        #    then they are competent enough to resolve the issue (why burden most noobs for a handful of experts?)
                        
require 'mechanize'     # traverse the internet
require 'sqlite3'       # database adaptor
require 'activerecord'  # interact with database
require 'pony'          # send email (text message)
require 'yaml'          # reads the settings.yaml file into memory

# load files that establish environment
require 'settings'
require 'blackboard_site'
require 'models'
