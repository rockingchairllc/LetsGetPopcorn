class Admin::ZipcodesController < Admin::BaseController
  
  before_filter :authenticate_admin!, :except => []
  
  def index
      @zipcodes = Zipcode.find(:all, :order => 'id desc').paginate(:per_page => 12, :page => params[:page])
    end

    def new
      @zipcode = Zipcode.new
    end

    def create
      @zipcode = Zipcode.new(params[:zipcode])
      if @zipcode.save
        flash[:notice] = "Zipcodes created successfully"
        redirect_to admin_zipcodes_path
      else
        render :new
      end
    end
    
    def edit
      @zipcode = Zipcode.find(params[:id])
    end

    def update
      @zipcode = Zipcode.find(params[:id])
      if @zipcode.update_attributes(params[:zipcode])
        flash[:notice] = "Zipcode saved successfully"
        redirect_to admin_zipcodes_path
      else
        render :new
      end
    end
    
end
