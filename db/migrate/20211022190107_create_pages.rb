class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.text :body
      t.string :link
      t.references :word
      t.timestamps
    end
  end
end
