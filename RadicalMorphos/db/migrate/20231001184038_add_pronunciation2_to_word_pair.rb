class AddPronunciation2ToWordPair < ActiveRecord::Migration[7.0]
  def change
    add_column :word_pairs, :pronunciation2URL, :string
  end
end
