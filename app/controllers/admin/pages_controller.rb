class Admin::PagesController < Admin::BaseController
  
  before_filter :authenticate_admin!, :except => []
  
  def index
      @pages = Page.find(:all)
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(params[:page])
      if @page.save
        flash[:notice] = "Pages created successfully"
        redirect_to admin_pages_path
      else
        render :new
      end
    end
    
    def edit
      @page = Page.find(params[:id])
    end

    def update
      @page = Page.find(params[:id])
      if @page.update_attributes(params[:page])
        flash[:notice] = "Pages saved successfully"
        redirect_to admin_pages_path
      else
        render :new
      end
    end
    

    def destroy
      @page = Page.find(params[:id])
     
      if @page.destroy
        flash[:notice] = "Pages deleted successfully"
        redirect_to admin_pages_path
      end
      
    end
   
  
end
