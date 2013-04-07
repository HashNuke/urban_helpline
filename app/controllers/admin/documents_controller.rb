class Admin::DocumentsController < AdminController
  before_action :find_document, only: [:edit, :show, :update, :destroy]
  before_action :redirect_to_listings_if_required, only: :search

  def index
    @documents = Document.order_by(created_at: :desc).page(params[:page])
  end
  
  def search
    @query = Document.full_text_search(params[:search], { :max_results => 5 })
    @search_keywords = params[:search]

    respond_to do |format|
      format.json { render json: @query }
      format.html
    end
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def show
  end

  def create
    @document = Document.new(permitted_params.document)

    respond_to do |format|
      format.html {
        if @document.save
          redirect_to admin_document_path(@document)
        else
          render :new
        end
      }
    end
  end

  def update
    respond_to do |format|
      if @document.update_attributes(permitted_params.document)
        format.html {
          redirect_to admin_document_path(@document)
        }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if @document.destroy
      flash[:notice] = "The document has been deleted"
    else
      flash[:notice] = "There was a problem deleting that document"
    end

    redirect_to admin_documents_path
  end


  private
  
  def find_document
    @document = Document.find params[:id]
  end

  def redirect_to_listings_if_required
    if params[:search].empty?
      redirect_to admin_documents_path
    end
  end
end
