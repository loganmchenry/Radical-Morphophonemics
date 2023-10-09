class WordPair < ApplicationRecord
    puts "checking params"
    validates :word1, presence: true, length: { maximum: 50 }
    validates :word2, presence: true, length: { maximum: 50 }


end
