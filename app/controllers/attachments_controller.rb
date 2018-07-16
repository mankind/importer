class AttachmentsController < ApplicationController

  before_action :set_attachment, only: [:show]

  def index
   @attachments = Current.user.attachments
  end

  def import
    file = params[:file]
    @book = Attachment.import(params[:file])
    redirect_to root_url, notice: "file uploaded"
  end

  def show
  end
  

  private

  def attachment_params
    params.require(:attachment).permit(:csv_file, :user_id)
  end

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end


end
