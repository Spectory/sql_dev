class CreatePotions < ActiveRecord::Migration
  def change
    execute "CREATE TABLE potions(magical_id INTEGER DEFAULT NEXTVAL('magical_seq'), name VARCHAR(32));"
  end
end
