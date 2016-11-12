Rails.application.routes.draw do
  resource :tenders, only: :index do
    get :index2
    get :index3
    get :tender_details
  end
  root 'tenders#index'
end
