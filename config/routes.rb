Rails.application.routes.draw do
  resources :invoices, only: [:new, :create, :show] do
    member do
      post 'void'
      post 'pay'
    end
  end

  resources :expenses
  resources :clients, except: [:show] do
    resources :contacts, except: [:index, :show]
  end

  resources :currencies, except: [:show] do
    resources :conversion_rates, except: [:index, :show]
  end

  root 'dashboard#index'
end
