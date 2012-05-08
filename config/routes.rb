Barcamp::Application.routes.draw do
  root :to => "welcome#index"

  match '/:locale' => 'welcome#index', :locale => /en/

  scope "(:locale)", :locale => /en/ do
    resources :attendees
  end
end
