
    class Group < ActiveRecord::Base

       set_table_name 'groups'
       acts_as_tree

       has_many :ctrl_permission#,       :class_name => "CtrlFilter",
                                #:through => :ctrl_permission,
                                #:foreign_key => 'group_id'
        
       has_many :user_group#,          :class_name => "User",
                           #     :through => :user_group,
                           #     :foreign_key => 'group_id'

#       has_many :data_permission,   :class_name => "DataPermission",
#                                :through => :data_permission,
#                                :foreign_key => 'group_id'
       has_many :data_permission

      def to_label
        "#{code.nil? ? '' : code}::#{(desc.nil? ? 'desc[0..30]' : (desc.length>30 ? desc[0..30]+'...' : desc))}"
      end

    end
    

=begin

class Character < ActiveRecord::Base
   has_many :links, :dependent => destroy
   has_many :characters, :through => :links

   has_many :source_links, :class_name => "Link",
     :foreign_key => "to_character_id", :dependent => :destroy
   has_many :source_characters, :class_name => "Character",
     :through => :destination_links
 end

 class Link < ActiveRecord::Base
   belongs_to :character
   belongs_to :source_character, :class_name => "Character",
    :foreign_key => "to_character_id"
 end
=end
