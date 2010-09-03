# Creates setters and getters, ie you can now do:
# Settings.email.enable # => true
# and
# Settings.email.enable = false
# instead of
# SETTINGS[:email][:enable] = false
# and so on
#
# also, saves the settings after each setter is called

SETTINGS_FILE = 'settings.yaml'

module Settings

  # load settings
  File.open(SETTINGS_FILE) { |file| @@settings = YAML.load(file) }

  # create each set of methods
  @@settings.each { |namespace,settings|
    
    # creates root method, ie Settings.db or Settings.email
    define_method namespace do 
      settings
    end
    
    # dynamic setters and getters for interacting with the settings
    def settings.method_missing( *args )
      if 1==args.size  &&  has_key?(args.first)
        self[args.first]
      elsif 2==args.size  &&  args.first.to_s=~/^([^=]*)=$/  &&  has_key?($1.to_sym)
        self[$1.to_sym] = args.last
        Settings.save
      else
        super
      end
    end
  }
  
  # save the new settings into the yaml file
  def save
    File.open( SETTINGS_FILE , 'w' ).puts( @@settings.to_yaml )
  end
  
  extend self # <-- seems a little hacky, see if there is a better way
end
