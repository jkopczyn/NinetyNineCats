NinetyNineCats::Application.routes.draw do
  resources :cats
  resources :cat_rental_requests do
    post "approve", :on => :member
    post "deny", :on => :member
  end
end
