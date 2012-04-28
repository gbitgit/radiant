# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class PermissionsExtension < Radiant::Extension
  version "#{File.read(File.expand_path(File.dirname(__FILE__)) + '/VERSION')}"
  description "Web based administration for Radiant security data_permissions."
  url "https://github.com/orphist/radiant-data_permissions-extension"


  def activate
    #Radiant::Config.extend ConfigFindAllAsTree
    #Radiant::Config.class_eval { include ConfigProtection }

    User.send(:include,UserExtension)

    tab 'Permissions' do
      add_item "Ctrl filters", "/admin/ctrl_filters"#,:after=>"User data filters"
      add_item "Ctrl permissions", "/admin/ctrl_permissions",:after=>"Ctrl filters"
      add_item "User groups", "/admin/groups",:after=>"Ctrl permissions"
      add_item "User organizations", "/admin/organizations",:after=>"User groups"
      add_item "Data filters", "/admin/data_filters",:after=>"User organizations"
      add_item "Data permissions", "/admin/data_permissions",:after=>"Data filters"
      add_item "Categories", "/admin/categories",:after=>"Data permissions"
    end

    #Page.class_eval { include PermissionsTags }
    Radiant::AdminUI.class_eval do
      attr_accessor :ctrl_filters
      attr_accessor :ctrl_permissions
      attr_accessor :groups
      attr_accessor :organizations
      attr_accessor :data_filters
      attr_accessor :data_permissions
      attr_accessor :categories
      alias_method "ctrl_filters", :ctrl_filters
      alias_method "ctrl_permissions", :ctrl_permissions
      alias_method "groups", :groups
      alias_method "organizations", :organizations
      alias_method "data_filters", :data_filters
      alias_method "data_permissions", :data_permissions
      alias_method "categories", :categories
    end

    admin.ctrl_filters = load_default_ctrl_filters_regions
    admin.ctrl_permissions = load_default_ctrl_permissions_regions
    admin.groups = load_default_groups_regions
    admin.organizations = load_default_organizations_regions
    admin.data_filters = load_default_data_filters_regions
    admin.data_permissions = load_default_data_permissions_regions
    admin.categories = load_default_categories_regions
  end

  def load_default_ctrl_filters_regions
    OpenStruct.new.tap do |security_functions|
      security_functions.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end

  def load_default_ctrl_permissions_regions
    OpenStruct.new.tap do |ctrl_permissions|
      ctrl_permissions.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end

  def load_default_data_filters_regions
    OpenStruct.new.tap do |data_filters|
      data_filters.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end

  def load_default_data_permissions_regions
    OpenStruct.new.tap do |data_permissions|
      data_permissions.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end
  def load_default_categories_regions
    OpenStruct.new.tap do |categories|
      categories.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end

  def load_default_groups_regions
    OpenStruct.new.tap do |groups|
      groups.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end


  def load_default_organizations_regions
    OpenStruct.new.tap do |organizations|
      organizations.index = Radiant::AdminUI::RegionSet.new do |index|
        index.top.concat %w{}
        index.main.concat %w{list}
        index.bottom.concat %w{new_button}
      end
    end
  end

end
