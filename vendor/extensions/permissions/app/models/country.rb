
    class Country < ActiveRecord::Base #Sequel::Model  #ActiveRecord::Base
      #include ActiveRecord
      #include Sequel

      set_table_name 'countries'


#  named_scope :sec_country, lambda { |values|
#    { :conditions => { :id => values } }
#  }
      #default_scope :conditions => [ "id in (?)", [1,2,9] ]
      default_scope :conditions => ["EXISTS (select 'X' from data_filters df, data_permissions dp
where df.id=dp.data_filter_id and df.model='Country' and dp.can_read='+')"]

      named_scope :contains, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "%#{text.downcase}%"]} }
      named_scope :started, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "#{text.downcase}%"]} }
      named_scope :ended, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "%#{text.downcase}"]} }
      named_scope :equal, lambda { |column, text|   {:conditions => ["lower(#{column}) = ?", "#{text.downcase}"]} }

#The LIKE version of the query can now be written as:
   #user.active.contains(:iso3, "BEN")

#And if I want the results to be sorted, I just add another scope:
   #user.active.contains(:printable_name, "BEN")



      named_scope :published_only, :conditions => ["id in (?)", [1,2,9]]
      named_scope :secured, :conditions => ["id between ? and ?", 1,19]

named_scope :as,      :conditions => [ "iso3 like ?", 'A%' ]
named_scope :buki,    :conditions => [ "iso3 like ?", 'B%' ]

named_scope :high_rated,  :conditions => [ "id > ?", 3 ]
named_scope :low_rated,   :conditions => [ "id < ?", 3 ]

  FILTERS = [
    {:scope => "all",         :label => "All"},
    {:scope => "as",      :label => "from A"},
    {:scope => "buki",    :label => "from B"},
    {:scope => "high_rated",  :label => "High-Rated"},
    {:scope => "low_rated",   :label => "Low-Rated"}
  ]


#      def initialize
#        @sm=Sequel::Model.new
#      end

#      class Sequel::Model
#      def_dataset_method(:f10) do
#      @sm.filter('id < 10')
#      end
#
#      def_dataset_method(:f16) do
#      @sm.filter('id < 15')
#      end
#      end

    end