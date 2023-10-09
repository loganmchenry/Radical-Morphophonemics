require 'rubygems'
require 'httparty' 

class WordsController < ApplicationController
  def index
    @words = WordPair.all
    # for initializing db 
    #@words.each do |wordPair|
      #wordPair.update(phonetic1: get_pronunciation(wordPair.word1))
      #wordPair.update(phonetic2: get_pronunciation(wordPair.word2))
      #wordPair.update(pronunciation1URL: get_sound_URL(wordPair.word1))
      #wordPair.update(pronunciation2URL: get_sound_URL(wordPair.word2))
    #end
  end

  def show
    @wordPair = WordPair.find(params[:id])
  end


  def new
    @wordPair = WordPair.new
  end

  def create
    @wordPair = WordPair.new(word_params)

    if @wordPair.save
      redirect_to @words
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def word_params
      puts params.inspect
      params.fetch(:wordPair, {}).permit(:word1, :word2)
    end




  # API stuff ---------------------------#
  private
  def get_pronunciation(word = "uninitialized")
    json = get_json(word.strip)
    if json[0]['hwi']
      pronunciation = json[0]['hwi']['prs'][0]['mw']
    else pronunciation = "poopy"
    end
    return pronunciation
  end

  # set the URL for pronunciation recording
  # to do subdirectory and base_filename
  private
  def get_sound_URL(word = "uninitialized")
    # http GET
    json = get_json(word.strip)

    # 
    language_code = 'en'
    country_code = 'us'
    audio_format = 'mp3'
    if json[0]['hwi']
      puts base_filename = json[0]['hwi']['prs'][0]['sound']['audio']
      if base_filename[0, 2] == "bix"
        subdirectory = 'bix'
      elsif base_filename[0, 1] == "gg"
        subdirectory = 'gg'
      elsif base_filename[0].match?(/[[:digit:]]/) || base_filename[0].match?(/[[:punct:]]/)
        subdirectory = 'number'
      else 
        subdirectory = base_filename[0]
      end
    else 
      base_filename = 'poop' 
      subdirectory = 'p'
    end




    audioURL = 'https://media.merriam-webster.com/audio/prons/' + language_code + '/' +
    country_code + '/' + audio_format+ '/' + subdirectory + '/' + base_filename +
    '.' + audio_format

    puts audioURL
    return audioURL
  end

  private 
  def get_json(word = "uninitialized'")
    requestURL = 'https://www.dictionaryapi.com/api/v3/references/collegiate/json/' + word + '?key=7d95c2a9-ea15-4738-9bdb-7bd0e2eb3a04'
    response = HTTParty.get(requestURL)
    if response.code == 200
      json = JSON.parse(response.body)
    else 
      return HTTParty.get('https://www.dictionaryapi.com/api/v3/references/collegiate/json/uninitialized?key=7d95c2a9-ea15-4738-9bdb-7bd0e2eb3a04')
    end
  end



  
end


