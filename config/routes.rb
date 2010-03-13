ActionController::Routing::Routes.draw do |map|
  Translate::Routes.translation_ui(map)
  map.filter 'locale'

  map.root :controller => "welcome"

  map.resources :attendees
end
