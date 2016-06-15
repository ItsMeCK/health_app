Rails.application.routes.draw do
  # API Definition
  namespace :web, defaults: { format: :json }, path: '/' do
    scope module: :v1 do
    # We are going to list our resources here
    end
  end
end