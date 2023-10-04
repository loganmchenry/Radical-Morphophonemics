class AddPronunciation1ToWordPair < ActiveRecord::Migration[7.0]
  def change
    add_column :word_pairs, :pronunciation1URL, :string
  end
end
