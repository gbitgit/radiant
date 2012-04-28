    class UserOrganization < ActiveRecord::Base
      set_table_name 'user_organizations'

      belongs_to :user
      belongs_to :organization

    end