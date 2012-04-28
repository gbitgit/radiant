class CreateSecuritySetups < ActiveRecord::Migration
  def self.up

	  create_table "groups", :force => true do |t|
	    t.integer  "id",       :null => false
	    t.integer  :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level
	    t.string   "code", :limit => 32
	    t.string   "desc", :limit => 128
	  end

	  create_table "user_groups", :force => true do |t|
	    t.integer  :user_id,       :null => false
	    t.integer  :group_id,       :null => false
	  end

	  create_table "organizations", :force => true do |t|
	    t.integer  "id",       :null => false
	    t.integer  :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level

	    t.string   "code", :limit => 32
	    t.string   "desc", :limit => 128
	  end

	  create_table "user_organizations", :force => true do |t|
	    t.integer  :user_id,       :null => false
	    t.integer  :organization_id,       :null => false
	  end

	  create_table  "ctrl_filters",  :force => true do |t|
	    t.integer   "id",          :null => false
	    t.string    "code",        :limit => 64
	    t.string    "desc",        :limit => 128
	    t.string    "crud_flag",        :limit => 1, :null => false, :default=>'-'

	    t.string "controller", :limit => 128
	    t.string "method", :limit => 128
	    t.integer :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table  "ctrl_permissions",  :force => true do |t|
	    t.integer   "id",          :null => false
	    t.string    "code",        :limit => 64
	    t.string 	"desc",        :limit => 128
	    t.integer   :parent_id
	    t.integer   :lft
            t.integer   :rgt
            t.integer   :level

	    t.integer	:ctrl_filter_id,          :null => false

	    t.integer 	:group_id, :null => false
	    t.integer 	:organization_id, :null => false

	    t.string    :can_create,      :limit => 1,   :default => '-'
	    t.string    :can_read,        :limit => 1,   :default => '-'
	    t.string    :can_update,      :limit => 1,   :default => '-'
	    t.string    :can_delete,      :limit => 1,   :default => '-'

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table "data_filters", :force => true do |t|
	    t.integer "id",       :null => false
	    t.string "code",       :limit => 64
	    t.string "desc",       :limit => 128

	    t.string "model",       :limit => 64

	    t.integer :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level

	    t.string    "crud_flag",        :limit => 1, :null => false, :default=>'-'

	    t.string "select",       :limit => 1024
	    t.string "from",       :limit => 1024
	    t.string "includes",       :limit => 8000
	    t.string "conditions",       :limit => 1024

	    t.string "arel",       :limit => 8000

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table "data_permissions", :force => true do |t|
	    t.integer   "id",          :null => false
	    t.string    "code",        :limit => 64
	    t.string 	"desc",       :limit => 128
	    t.integer   "data_filter_id", :null => false
	    t.integer   :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level

	    t.string    :can_create,      :limit => 1,   :default => '-'
	    t.string    :can_read,        :limit => 1,   :default => '-'
	    t.string    :can_update,      :limit => 1,   :default => '-'
	    t.string    :can_delete,      :limit => 1,   :default => '-'

	    t.integer 	:group_id, :null => false
	    t.integer 	:organization_id, :null => false

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end
	  
	  create_table "categories", :force => true do |t|
	    t.integer "id", :null => false
	    t.string  "code", :limit => 32
	    t.string  "desc", :limit => 128
	    t.integer "name", :null => false
	    t.integer :parent_id
	    t.integer :lft
            t.integer :rgt
            t.integer :level
	  end
	  
	  add_column :users, :code, :string, :limit=>32
    
    
    u = User.find_by_code(nil)
    if u
      u.code = u.name
      u.save
    end


end

  def self.down
    drop_table :groups
    drop_table :user_groups
    drop_table :security_functions
    drop_table :organizations
    
    drop_table :ctrl_permissions
    drop_table :categories
    drop_table :data_filters
    drop_table :data_permissions
    drop_table :user_organizations
  end
end
