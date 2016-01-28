require_relative '../lib/application_controller'
require_relative '../lib/router'

@execute = Proc.new do

  @router = Router.new

  @router.draw do
    get "^/users/(?<user_id>\\d+)$", to: 'users#show'
    get "^/users$", to: 'users#index'
    get "^/users/new$", to: 'users#new'
    post "^/users$", to: 'users#create'
    delete "^/users/(?<user_id>\\d+)", to: 'users#destroy'

    get "^/users/(?<user_id>\\d+)/conversations$", to: 'conversations#index'
    get "^/conversations/new$", to: 'conversations#new'
    post "^/conversations$", to: 'conversations#create'
    get "^/users/(?<user_id>\\d+)/conversations/(?<conversation_id>\\d+)$", to: 'conversations#show'

    get "^/conversations/(?<conversation_id>\\d+)/messages$", to: 'messages#index'
    get "^/messages/new$", to: 'messages#new'
    post "^/messages$", to: 'messages#create'
  end

end
