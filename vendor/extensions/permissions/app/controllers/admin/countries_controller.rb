require ('/www/radiant/vendor/plugins/declarative_authorization/test/test_helper.rb')
require ('/www/radiant/vendor/plugins/declarative_authorization/lib/declarative_authorization/in_model')

ActiveRecord::Base.send :include, Authorization::AuthorizationInModel
#ActiveRecord::Base.logger = Logger.new(STDOUT)
class TestModel < ActiveRecord::Base
  has_many :test_attrs
  has_many :test_another_attrs, :class_name => "TestAttr", :foreign_key => :test_another_model_id
  has_many :test_attr_throughs, :through => :test_attrs
  has_many :test_attrs_with_attr, :class_name => "TestAttr", :conditions => {:attr => 1}
  has_many :test_attr_throughs_with_attr, :through => :test_attrs,
    :class_name => "TestAttrThrough", :source => :test_attr_throughs,
    :conditions => "test_attrs.attr = 1"
  has_one :test_attr_has_one, :class_name => "TestAttr"
  has_one :test_attr_throughs_with_attr_and_has_one, :through => :test_attrs,
    :class_name => "TestAttrThrough", :source => :test_attr_throughs,
    :conditions => "test_attrs.attr = 1"

  # TODO currently not working in Rails 3
  if Rails.version < "3"
    has_and_belongs_to_many :test_attr_throughs_habtm, :join_table => :test_attrs,
        :class_name => "TestAttrThrough"
  end

  if Rails.version < "3"
    named_scope :with_content, :conditions => "test_models.content IS NOT NULL"
  else
    scope :with_content, :conditions => "test_models.content IS NOT NULL"
  end

  # Primary key test
  # :primary_key only available from Rails 2.2
  unless Rails.version < "2.2"
    has_many :test_attrs_with_primary_id, :class_name => "TestAttr",
      :primary_key => :test_attr_through_id, :foreign_key => :test_attr_through_id
    has_many :test_attr_throughs_with_primary_id,
      :through => :test_attrs_with_primary_id, :class_name => "TestAttrThrough",
      :source => :n_way_join_item
  end

  # for checking for unnecessary queries
  mattr_accessor :query_count
  def self.find(*args)
    self.query_count ||= 0
    self.query_count += 1
    super(*args)
  end
end

class NWayJoinItem < ActiveRecord::Base
  has_many :test_attrs
  has_many :others, :through => :test_attrs, :source => :n_way_join_item
end

class TestAttr < ActiveRecord::Base
  belongs_to :test_model
  belongs_to :test_another_model, :class_name => "TestModel", :foreign_key => :test_another_model_id
  belongs_to :test_a_third_model, :class_name => "TestModel", :foreign_key => :test_a_third_model_id
  belongs_to :n_way_join_item
  belongs_to :test_attr
  belongs_to :branch
  belongs_to :company
  has_many :test_attr_throughs
  has_many :test_model_security_model_with_finds
  attr_reader :role_symbols
  def initialize (*args)
    @role_symbols = []
    super(*args)
  end
end

class TestAttrThrough < ActiveRecord::Base
  belongs_to :test_attr
end

class TestModelSecurityModel < ActiveRecord::Base
  has_many :test_attrs
  using_access_control
end
class TestModelSecurityModelWithFind < ActiveRecord::Base
  if Rails.version < "3.2"
    set_table_name "test_model_security_models"
  else
    self.table_name = "test_model_security_models"
  end
  has_many :test_attrs
  belongs_to :test_attr
  using_access_control :include_read => true,
    :context => :test_model_security_models
end

class Branch < ActiveRecord::Base
  has_many :test_attrs
  belongs_to :company
end
class Company < ActiveRecord::Base
  has_many :test_attrs
  has_many :branches
  belongs_to :country
end
class SmallCompany < Company
  def self.decl_auth_context
    :companies
  end
end

class Country2 < ActiveRecord::Base
  has_many :test_models
  has_many :companies
end

class ApplicationController < ActionController::Base

  def self.before_filter_in_instance(&block)
    before_filter do |controller|
      controller.instance_eval(&block)
    end
  end
end

class Admin::CountriesController < Admin::ResourceController

#  layout "application_flexid"
#  layout "application"

#  only_allow_access_to :index, :show, :new, :create, :edit, :update, :remove, :destroy,
#    :when => [:admin],
#    :denied_url => { :controller => 'admin/pages', :action => 'index' },
#    :denied_message => "You must have admin privileges to manage data filters."
#
#  make_resourceful do
#    actions :index, :show, :new, :create, :edit, :update, :remove, :destroy
#  end
  helper :application

  #before_filter  :conditions => ["iso3 like ? ", 'D%' ]
  #before_filter :secured
  before_filter do |c|
  #c.send(:authorize)
  end

  def authorize()
    conditions=params[:conditions]||{}
    conditions.merge!(:conditions => ["iso3 like ? ", 'D%' ])
  end

  def index

       #render :nothing => true
=begin

    reader = Authorization::Reader::DSLReader.new

    reader.parse %{
      authorization do
        role :reader_role do
          has_permission_on :Country, :to => :read do
            if_attribute :id => is_in { user.test_attr_value }
          end
        end
      end
    }
    Authorization::Engine.instance(reader)

    user = MockUser.new(:reader_role, :test_attr_value => [9,46,11])
    attr_value = [9,46,11]
=end
    #logger.warn "###########################   Engine reader='#{reader.inspect}'    ####################################"
    #logger.warn "#{Time.now.strftime("%H:%M:%S:%3N")} caller=#{calls}"
    #logger.warn Country.with_permissions_to(:read,:context => :Country, :user => user)

    #@countries = Country.published_only.secured
    
  @filters = Country::FILTERS
  @label='Dataspy'

  @fields = [
    {:field => "iso3",      :label => "iso3"},
    {:field => "name",      :label => "name"}   ]

  @conditions = [{:condition => "contains",      :label => "Contains"},{:condition => "started",      :label => "Begins"},
      {:condition => "ended",      :label => "Ended"},{:condition => "equal",      :label => "="}]



  logger.warn "###########################   params='#{params}'    ####################################"

  #    = select_tag_for_detailed_filter("countries", @label, @fields, @conditions, params)

  if params[:show] && @filters.collect{|f| f[:scope]}.include?(params[:show])
    @countries = Country.send(params[:show])
  else
    @countries = Country.find(:all) #Country.contains(:iso3, "BE")
  end
    #logger.warn "countries  = #{@countries.length}"

#=end

  end

  def show
    @countries = Country.find(:all) #Country.find(:all)
    #render :json => data.to_json
    #render :index
  end

end