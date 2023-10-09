Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  #homepage goes to index
  root "words#index"

  # /words goes to index and words/id goes to individual view
  #get "/words", to: "words#index"
  #get "/words/:id", to: "words#detailView"
  # Resources does this for us automatically
  resources :words
  post "words/new" => "words#create"

  get "about" => "about#index"
  get "mutaphones" => "mutaphones#index"

 
end
