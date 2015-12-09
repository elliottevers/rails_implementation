require_relative '../lib/controller_base'
require_relative '../lib/router'

@execute = Proc.new do

  @router = Router.new

  @router.draw do
    get "^/users/(?<user_id>\\d+)$", :users, :show
    get "^/users$", :users, :index
    get "^/users/new$", :users, :new
    post "^/users$", :users, :create

    get "^/users/(?<user_id>\\d+)/conversations$", :conversations, :index
    get "^/conversations/new$", :conversations, :new
    post "^/conversations$", :conversations, :create
    get "^/users/(?<user_id>\\d+)/conversations/(?<conversation_id>\\d+)$", :conversations, :show

    get "^/conversations/(?<conversation_id>\\d+)/messages$", :messages, :index
    get "^/messages/new$", :messages, :new
    post "^/messages$", :messages, :create
  end

end
