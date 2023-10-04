class CreateWordPairs < ActiveRecord::Migration[7.0]
  def change
    create_table :word_pairs do |t|
      t.string :word1
      t.string :word2

      t.timestamps
    end
  end
end
