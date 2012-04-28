
class Admin::CategoriesController < Admin::ResourceController

#  layout "application_flexid"
#  layout "application"

  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
    :when => [:admin],
    :denied_url => { :controller => 'admin/pages', :action => 'index' },
    :denied_message => "You must have admin privileges to manage data filters."

  make_resourceful do
    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
  end

  def index
    @category = Category.find_tree_info()
  end

  def show
    lines = params[:rp].to_i
    page = params[:page].to_i
    @categories = Category.find_by_path(params[:id],
                               :order => params[:sortname] + ' '+ params[:sortorder],
                               :limit => lines,
                               :offset => (page - 1) * lines)
    count = Category.count_by_path(params[:id])
    data = {:page => page,
      :total => count,
      :rows => @categories.map {|u| {:cell =>
          [u.id, u.parent_id, u.name]}}}
    render :json => data.to_json
  end

end