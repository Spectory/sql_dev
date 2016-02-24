class CreateCharms < ActiveRecord::Migration
  def change
    execute "CREATE TABLE charms(magical_id INTEGER DEFAULT NEXTVAL('magical_seq'), name VARCHAR(32));"
  end
end
