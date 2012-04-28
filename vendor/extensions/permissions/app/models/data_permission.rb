
    class DataPermission < ActiveRecord::Base
      set_table_name 'data_permissions'
      acts_as_tree

      belongs_to :data_filter      #,  :foreign_key => 'data_filter_id'
      belongs_to :group            #,  :foreign_key => 'group_id'
      belongs_to :organization     #,  :foreign_key => 'organization_id'

      def to_label
        "#{code.nil? ? '' : (desc.nil? ? code : code+'::')}#{(desc.nil? ? '' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

    end

