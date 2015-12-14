require_relative '../lib/application_controller'
model_files = File.join(File.dirname(__FILE__), "../models/*.rb")
Dir[model_files].each {|file| require file }

class ConversationsController < ApplicationController

  def create
    @conversation = Conversation.new(
      :sender_id => params["conversation"]["sender_id"],
      :recipient_id => params["conversation"]["recipient_id"]
    )

    if !(@conversation.sender_id.nil? || @conversation.recipient_id.nil?)
      @conversation.save
      redirect_to (
        "http://localhost:3000/users/#{params["conversation"]["sender_id"]}/conversations"
      )
    else
      render :new
    end

  end

  def new
    @conversation = Conversation.new
    render :new
  end

  def show
    conversations = Conversation.where(:sender_id => Integer(params['user_id']))
    conversations += Conversation.where(:recipient_id => Integer(params['user_id']))
    @conversation = conversations.select!{ |conversation| conversation.id == Integer(params['conversation_id'])}
    render @conversation.to_json
  end

  def index
    @conversations = Conversation.where(:sender_id => Integer(params['user_id']))
    @conversations += Conversation.where(:recipient_id => Integer(params['user_id']))
    render @conversations.to_json
  end

end
