class ContentsController < ApplicationController
  before_action :set_content, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :check_user, only: %i[ edit update destroy ]
  
  def index
    @contents = Content.all.order("created_at DESC").paginate(page: params[:page], per_page: 4)
  end

  def show
  end

  def new
    @content = current_user.contents.build
  end

  def edit
  end

  def create
    @content = current_user.contents.build(content_params)

    respond_to do |format|
      if @content.save
        format.html { redirect_to content_url(@content), notice: "L'articolo è stato caricato correttamente!" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @content.update(content_params)
        format.html { redirect_to content_url(@content), notice: "Content was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @content.destroy

    respond_to do |format|
      format.html { redirect_to contents_url, notice: "Content was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def content_params
      params.require(:content).permit(:titolo, :descrizione, :prezzo, :cover, :allegato)
    end

    def check_user
      if current_user != @content.user 
        redirect_to root_url, alert: "Tu non puoi passare!"
      end
    end
end
