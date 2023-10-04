class AddPhoneticsToWordPairs < ActiveRecord::Migration[7.0]
  def change
    add_column :word_pairs, :phonetic1, :string
    add_column :word_pairs, :phonetic2, :string
  end
end
