    class CtrlPermission < ActiveRecord::Base
      set_table_name 'ctrl_permissions'
      acts_as_tree

      belongs_to :ctrl_filter#,:foreign_key => 'security_function_id'
      belongs_to :group#,:foreign_key => 'group_id'
      belongs_to :organization#,:foreign_key => 'organization_id'

      def to_label
        "#{code.nil? ? '' : code}::#{(desc.nil? ? 'desc[0..30]' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

    end


=begin

    class Function < ActiveRecord::Base
        set_table_name 'secure.sec_functions'

#        has_many :role,     :class_name => "Role",
#                            :through => :role_permission,
#                            :foreign_key => 'per_role_id'
        has_many :group,    :class_name => "Group",
                            :through => :group_permission,
                            :foreign_key => 'per_group_id'

#        has_many :user,     :class_name => "User",
#                            :through => :user_permission,
#                            :foreign_key => 'per_user_id'
    end

end

module Security

   class Role < ActiveRecord::Base
        set_table_name 'secure.roles'

       has_many :function,      :class_name => "Function",
                                :through => :role_permission,
                                :foreign_key => 'per_function_id'

       has_many :user,          :class_name => "User",
                                :through => :user_role,
                                :foreign_key => 'id'
    end

sec_permissions,group_id,can_read!='-'
users_groups,group_id,user_id=


	  create_table "groups", :force => true do |t|
	    t.integer  "id",       :null => false
	    t.string   "name", :limit => 64
	    t.string   "desc", :limit => 512
	  end

	  create_table "users_groups", :force => true do |t|
	    t.integer "id",       :null => false
	    t.integer "user_id",  :null => false
	    t.integer "group_id", :null => false
	  end
	  add_index "users_groups", ["user_id", "group_id"], :name => "users_groups_ids", :unique => true

	  create_table  "data_permissions",  :force => true do |t|
	    t.integer   "id",          :null => false
	    t.string    "code",        :limit => 64

	    t.integer   "group_id", :null => false

	    t.string 	"controller", :limit => 64
	    t.string 	"method", 	:limit => 64

	    t.string    "can_create",      :limit => 1,   :default => "-", :null => false
	    t.string    "can_read",        :limit => 1,   :default => "-", :null => false
	    t.string    "can_update",      :limit => 1,   :default => "-", :null => false
	    t.string    "can_destroy",     :limit => 1,   :default => "-", :null => false

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table "data_filters", :force => true do |t|
	    t.integer "id",       :null => false
	    t.string "code",       :limit => 64

	    t.string "table_name",  :limit => 64
	    t.string "model",       :limit => 64

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table "data_filter_lines", :force => true do |t|
	    t.integer "data_filter_id",      :null => false

	    t.string "field", 	:limit => 64
	    t.string "value",  	:limit => 1024
	    t.string "negate",	:limit => 1 , 	:default =>  ""#'^' or ''
	    t.string "condition",:limit => 1, 	:default => "&"#'&' or '|'
	    t.string "order",	:limit => 1 , 	:default => "-"#'+' or '-'

	    t.timestamp "created_at",  :limit => 0
	    t.timestamp "updated_at",  :limit => 0
	    t.integer   "created_by"
	    t.integer   "updated_by"
	  end

	  create_table "group_data_filters", :force => true do |t|
	    t.integer "id",      :null => false
	    t.integer "group_id", :null => false
	    t.integer "data_filter_id", :null => false
	  end

class Article < ActiveRecord::Base
#######################################
  scope :active, proc {
    where("expires_at IS NULL or expires_at > '#{Time.now}'")
  }

  scope :by_newest_first, order("created_at DESC")

  #default_scope by_newest
  default_scope { active.by_newest_first }
#######################################
	default_scope do
	  { :conditions => ["created_at < ?", Time.now] }
	end
#######################################
default_scope lambda { {:order => column_translated(:name)} }
#######################################
default_scope :order => 'last_name, first_name'
#######################################

#######################################
#######################################
#######################################
#######################################
end



config.extensions = [
:share_layouts,
      #:multi_site, #:search_multi_site,
#:submenu,
:settings, :paperclipped,
#~ :globalize2,:globalize2_paperclipped,
    :taggable,#:reader,
    :paperclipped_taggable,
    #:page_options,
    :tags,
#:help,
#:page_attachments,#:page_attachments_xsendfile,
#:search, #:tags,
    #:reader,#:reader_group,
    #:tags_multi_site,
#:conditional_tags,:variables,
    #:rbac_base,#:rbac_page_edit,:rbac_snippets,
:mailer,#:database_mailer,
#:file_system,
:sns,#:sns_file_system,
#:member,
:all#,:sns_minifier


##:aggregation,
#:application_theme,
#:file_system_mirror,
#:archive,
#:archive_hacks,
#:file_system_resources,
##:help,
##:blogger,
#:conferences,
#:copy_move,
#:navigation_tags,
#:custom_fields,
#:no_dev_cache,
#:textile_filter,
#:cy_image,
#:tinymce_filter,
#:dashboard,
#:exception_notification,
#:reorder
]

drop function "secure".insert_function_into_permission_trg() CASCADE;

CREATE OR REPLACE FUNCTION "secure".insert_function_into_permission_trg() RETURNS opaque AS '
DECLARE
    -- Declare a variable to hold the customer ID.
    id_number INTEGER;

BEGIN

      --if a trigger insert or update operation occurs
      IF TG_OP = ''INSERT'' THEN

        --NEW.id:=currval(''secure.functions_id_seq'');

        --inserts the row in the inventory
        --table into the inventory_audit table
        INSERT INTO secure.data_permissions(id,per_model,per_table_name,per_function_id,per_code,per_create,per_read,per_update,per_destroy,
        per_role_id,
        per_created_by,per_updated_by,per_created_at,per_updated_at)
        SELECT
nextval(''secure.permissions_id_seq'') as id,
model as per_model,
table_name as per_table_name,
fn.id as per_function_id,
code as per_code,
''-'' as per_create,
''-'' as per_read,
''-'' as per_update,
''-'' as per_destroy,
rol.id as per_role_id,
1 as per_created_by,
1 as per_updated_by,
now() as per_created_at,
now() as per_updated_at

		FROM secure.functions fn
	     left outer join secure.roles rol on 1=1
             WHERE fn.id=currval(''secure.functions_id_seq'') and rol.id is not NULL;

        INSERT INTO secure.data_permissions(id,per_model,per_table_name,per_function_id,per_code,per_create,per_read,per_update,per_destroy,
        per_group_id,
        per_created_by,per_updated_by,per_created_at,per_updated_at)
        SELECT
nextval(''secure.permissions_id_seq'') as id,
model as per_model,
table_name as per_table_name,
fn.id as per_function_id,
code as per_code,
''-'' as per_create,
''-'' as per_read,
''-'' as per_update,
''-'' as per_destroy,
grp.id as per_group_id,
1 as per_created_by,
1 as per_updated_by,
now() as per_created_at,
now() as per_updated_at

		FROM secure.functions fn
	    left outer join secure.groups grp on 1=1
             WHERE fn.id=currval(''secure.functions_id_seq'') and grp.id is not NULL;

      RETURN NEW;

      END IF;
END;
' LANGUAGE 'plpgsql';


CREATE TRIGGER aft_ins
after insert on secure.functions
FOR EACH ROW EXECUTE PROCEDURE "secure".insert_function_into_permission_trg();

--SELECT pg_size_pretty(pg_database_size('radiant_dev')) as "estimated database size";




-- Function: secure.insert_function_into_permission_trg()
-- DROP FUNCTION secure.insert_function_into_permission_trg();

CREATE OR REPLACE FUNCTION secure.insert_function_into_permission_trg()
  RETURNS "trigger" AS
$BODY$
DECLARE
    -- Declare a variable to hold the customer ID.
    id_number INTEGER;

BEGIN

      --if a trigger insert or update operation occurs
      IF TG_OP = 'INSERT' THEN

        --NEW.id:=currval('secure.functions_id_seq');

        --inserts the row in the inventory
        --table into the inventory_audit table
        INSERT INTO secure.data_permissions(id,per_model,per_table_name,per_function_id,per_code,per_create,per_read,per_update,per_destroy,
        per_role_id,
        per_created_by,per_updated_by,per_created_at,per_updated_at)
        SELECT
nextval('secure.permissions_id_seq') as id,
model as per_model,
table_name as per_table_name,
fn.id as per_function_id,
code as per_code,
'-' as per_create,
'-' as per_read,
'-' as per_update,
'-' as per_destroy,
rol.id as per_role_id,
1 as per_created_by,
1 as per_updated_by,
now() as per_created_at,
now() as per_updated_at

		FROM secure.functions fn
	     left outer join secure.roles rol on 1=1
             WHERE fn.id=currval('secure.functions_id_seq') and rol.id is not NULL;

        INSERT INTO secure.data_permissions(id,per_model,per_table_name,per_function_id,per_code,per_create,per_read,per_update,per_destroy,
        per_group_id,
        per_created_by,per_updated_by,per_created_at,per_updated_at)
        SELECT
nextval('secure.permissions_id_seq') as id,
model as per_model,
table_name as per_table_name,
fn.id as per_function_id,
code as per_code,
'-' as per_create,
'-' as per_read,
'-' as per_update,
'-' as per_destroy,
grp.id as per_group_id,
1 as per_created_by,
1 as per_updated_by,
now() as per_created_at,
now() as per_updated_at

		FROM secure.functions fn
	    left outer join secure.groups grp on 1=1
             WHERE fn.id=currval('secure.functions_id_seq') and grp.id is not NULL;

      RETURN NEW;

      END IF;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE;
ALTER FUNCTION secure.insert_function_into_permission_trg() OWNER TO postgres;

=end
