    class Organization < ActiveRecord::Base

      set_table_name 'organizations'
      #acts_as_tree

       has_many :ctrl_permission#,       :class_name => "CtrlFilter",
                                #:through => :ctrl_permission,
                                #:foreign_key => 'organization_id'

       has_many :user_organization#,          :class_name => "UserOrganization",
                                #:through => :user_organization,
                                #:foreign_key => 'organization_id'

       has_many :data_permission
                                #,   :class_name => "DataFilter",
                                #:through => :data_permission,
                                #:foreign_key => 'organization_id'
      def to_label
        "#{code.nil? ? '' : code}::#{(desc.nil? ? 'desc[0..30]' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

#      def code_form_column(record,input_name)
#
#      textbox :record, :code, :code=> input_name
#
#      end
#
#      # Label to display name
#
#      def code_column(record)
#
#      record.code
#
#      end

    end