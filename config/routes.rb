Rails.application.routes.draw do
  get 'search/landing'

  get 'search/search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root 'application#landing'
end
