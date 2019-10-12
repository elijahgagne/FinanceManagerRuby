Rails.application.routes.draw do
  get 'welcome/index'

  resources :transactions

  get "transactions/:id/complete", to: "transactions#complete", as: 'complete_transaction'

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
