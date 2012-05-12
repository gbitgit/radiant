
    class DataFilter < ActiveRecord::Base
      set_table_name 'data_filters'


      has_many :data_permission#,    :class_name => "DataPermission",
                          #:through => :data_permission,
                          #:foreign_key => 'security_function_id'

#      has_many :data_filter_line,    :class_name => "DataFilterLine", :foreign_key => 'data_filter_id'

      def to_label
        "#{code.nil? ? '' : code}::#{(desc.nil? ? 'desc[0..30]' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

    end

