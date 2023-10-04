require 'rubygems'
require 'httparty' 

class WordsController < ApplicationController
  def index
    @words = WordPair.all
  end

  def show
    @wordPair = WordPair.find(params[:id])
    @wordPair.phonetic1 = get_pronunciation(@wordPair.word1)
    @wordPair.phonetic2 = get_pronunciation(@wordPair.word2)
    @wordPair.pronunciation1URL = get_sound_URL(@wordPair.word1)
    @wordPair.pronunciation2URL = get_sound_URL(@wordPair.word2)
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
      params.require(:words).permit(:word1, :word2)
    end




  # API stuff ---------------------------#
  private
  def get_pronunciation(word = "uninitialized")
    json = get_json(word)
    pronunciation = json[0]['hwi']['prs'][0]['mw']
    return pronunciation
  end

  # set the URL for pronunciation recording
  # to do subdirectory and base_filename
  private
  def get_sound_URL(word = "uninitialized")
    # http GET
    json = get_json(word)

    # 
    language_code = 'en'
    country_code = 'us'
    audio_format = 'mp3'
    subdirectory = 'number'
    base_filename = '3d000001'

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
    json = JSON.parse(response.body)
  end 

  
end


