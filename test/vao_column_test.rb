require 'test/unit'
require 'rubygems'
require 'active_record'
require 'vao_column'

ActiveRecord::Base.send :include, VAoColumn
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => "vao_column.sqlite3.db")
ActiveRecord::Schema.define do
  create_table :pirates, :force => true do |t|
    t.column :catchphrase, :string
  end
end

class Pirate < ActiveRecord::Base; end

class VAoColumnTest < Test::Unit::TestCase
  def test_validates_acceptance_of_as_database_column  
    Pirate.validates_acceptance_of(:catchphrase, :accept => "Argh!")
    pirate = Pirate.create("catchphrase" => "Argh!")
    assert pirate.save
    assert_equal "Argh!", pirate["catchphrase"]
  end
end
