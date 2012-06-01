Barcamp::Application.routes.draw do
  root :to => "welcome#index"

  match '/:locale' => 'welcome#index', :locale => /fr|de/

  scope "(:locale)", :locale => /fr|de/ do
    resources :attendees
  end
end
