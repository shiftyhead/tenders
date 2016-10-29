Rails.application.routes.draw do
  resource :tenders, only: :index do
    get :index2
    get :index3
  end
  root 'tenders#index'
end
