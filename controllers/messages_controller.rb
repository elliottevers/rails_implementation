require_relative '../lib/application_controller'
model_files = File.join(File.dirname(__FILE__), "../models/*.rb")
Dir[model_files].each {|file| require file }

class MessagesController < ApplicationController

  def create
    @message = Message.new(
      :body => params["message"]["body"],
      :user_id => params["message"]["user_id"],
      :conversation_id => params["message"]["conversation_id"]
    )

    if !(@message.body.nil? || @message.user_id.nil? || @message.conversation_id.nil?)
      @message.save
      redirect_to (
        "http://localhost:3000/conversations/#{params["message"]["conversation_id"]}/messages"
      )
    else
      render :new
    end

  end

  def new
    @message = Message.new
    render :new
  end

  def index
    @messages = Conversation
      .where(:id => Integer(params['conversation_id']))
      .first
      .messages
    render @messages.to_json
  end

end
