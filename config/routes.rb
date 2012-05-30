Barcamp::Application.routes.draw do
  root :to => "welcome#index"

  match '/:locale' => 'welcome#index', :locale => /en|de/

  scope "(:locale)", :locale => /en|de/ do
    resources :attendees
  end
end
