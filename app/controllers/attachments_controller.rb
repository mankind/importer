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
    filename = @attachment.original_csv_filename
    @data = @attachment.csv_text
    @csv_string = @attachment.csv_string

    respond_to do |format|
      format.html
      format.csv {send_data @csv_string, :type => "text/csv", filename: filename}
    end
  end
  

  private

  def attachment_params
    params.require(:attachment).permit(:csv_file, :user_id)
  end

  def set_attachment
    @attachment = Attachment.find(params[:id])
  end


end
