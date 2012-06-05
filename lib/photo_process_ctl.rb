#require 'rubygems'        # if you use RubyGems
require 'daemons'

Daemons.run('./lib/photo_process.rb')