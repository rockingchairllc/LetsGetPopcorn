class Admin::DashboardController < Admin::BaseController
  
  before_filter :authenticate_admin!, :except => []
  
  def index
  end
end
