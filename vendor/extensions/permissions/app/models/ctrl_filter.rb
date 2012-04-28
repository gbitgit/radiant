    class CtrlFilter < ActiveRecord::Base
      set_table_name 'ctrl_filters'

      has_many :ctrl_permission#,    :class_name => "CtrlPermission",
                          #:through => :ctrl_permission,
                          #:foreign_key => 'security_function_id'
      def to_label
        "#{code.nil? ? '' : code}::#{(desc.nil? ? 'desc[0..30]' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

    end