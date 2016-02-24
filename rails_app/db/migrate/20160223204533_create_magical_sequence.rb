class CreateMagicalSequence < ActiveRecord::Migration
  def change
    execute "CREATE SEQUENCE magical_seq INCREMENT BY 1 START WITH 1000"
  end
end
