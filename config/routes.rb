Rails.application.routes.draw do
  root "home#index"
  resource :admin, only: %i(show create)
end
