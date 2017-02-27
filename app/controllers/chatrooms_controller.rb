class ChatroomsController < ApplicationController
  before_action :require_user

  def show
    @chef = current_chef
    @message = Message.new
    @messages = Message.most_recent
  end
end
