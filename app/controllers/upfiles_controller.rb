class UpfilesController < ApplicationController
  def index
    @upfiles = Upfile.all
  end

  def new
    @upfile = Upfile.new
  end

  def create
    @upfile = Upfile.new(upfile_params)

    if @upfile.save
      redirect_to upfiles_path, notice: "The file named #{@upfile.name} has been uploaded!"
    else
      render "new"
    end
  end

  def destroy
    @upfile = Upfile.find(params[:id])
    @upfile.destroy
    @upfile.save
    redirect_to upfiles_path, notice: " The file named #{@upfile.name} has been deleted!"
  end

  def show
    @upfile = Upfile.find(params[:id]) 
    #byebug
    @upfile.attachment.read
    pdf_filename = @upfile.attachment.path 
    send_file(pdf_filename, :filename =>  @upfile.attachment.file.filename, :disposition => 'inline', :type => @upfile.attachment.content_type)
  end

  private
    def upfile_params
      params.require(:upfile).permit(:name, :attachment)
    end
end
