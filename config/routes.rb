Rails.application.routes.draw do
  root 'admin#index'

  resources :orders, only: [:index, :show], param: :number

  resources :reports, only: :index do
    get :coupon_users, on: :collection, defaults: { format: 'csv' }
  end
end
