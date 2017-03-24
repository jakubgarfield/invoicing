Rails.application.routes.draw do
  resources :invoices, only: [:new, :create, :show] do
    member do
      post 'void'
      post 'pay'
    end
  end

  resources :expenses, only: [:new, :create, :edit, :update, :destroy]
  resources :clients, except: [:show] do
    resources :contacts, except: [:index, :show]
  end

  root 'dashboard#index'
end
