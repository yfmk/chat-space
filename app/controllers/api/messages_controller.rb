class Api::MessagesController < ApplicationController
  before_action :set_group

  def index
    # binding.pry
    respond_to do |format|
      format.json{@messages = @group.messages.where('id > ?',params[:id]) }
    end
  end

  private
  
  def set_group
    @group = Group.find(params[:group_id])
  end

end