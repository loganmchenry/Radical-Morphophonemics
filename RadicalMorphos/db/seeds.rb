# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'radicalseeds.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")

csv.each do |row|
    t = WordPair.new(word1: row['word1'], word2: row['word2'])
    t.word1 = row['word1']
    t.word2 = row['word2']
    puts row['word1']
    t.save
end