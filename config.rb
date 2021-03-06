require 'sequel'
require 'sequel/extensions/pagination'
require 'logger'
require 'rack-flash'
require 'pony'
require 'carrierwave'
require 'carrierwave/orm/sequel'
require 'haml'
require 'cgi'

require File.join( File.expand_path(File.dirname(__FILE__)), 'lib/extend_string.rb' )

# Database connection.
DB = Sequel.mysql 'raptxt', :user => 'root', :password => '', :host => '127.0.0.1', :socket => '/Applications/MEPP/tmp/mysql/mysql.sock', :logger => Logger.new('tmp/db.log')

# Sequel schema plugins.
Sequel::Model.plugin :schema
Sequel::Model.plugin :force_encoding, 'UTF-8'
Sequel::MySQL.convert_invalid_date_time = nil

# Database models.
Dir['models/*.rb'].each { |model| require File.join( File.expand_path(File.dirname(__FILE__)), model ) }

# Blog configurations.
Settings = Struct.new(:title, :desc, :code, :feed)
$settings = Settings.new('raptxt.it', 'solo testi hip hop italiani')