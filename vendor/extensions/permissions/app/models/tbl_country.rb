
    class TblCountry < ActiveRecord::Base #Sequel::Model  #ActiveRecord::Base
      #include ActiveRecord
      #include Sequel

      set_table_name 'countries'

      default_scope :conditions => ["EXISTS (select 'X' from data_filters df, data_permissions dp
where df.id=dp.data_filter_id and df.model='Country' and dp.can_read='+')"]

      named_scope :contains2, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "%#{text.downcase}%"]} }
      named_scope :started2, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "#{text.downcase}%"]} }
      named_scope :ended2, lambda { |column, text|   {:conditions => ["lower(#{column}) LIKE ?", "%#{text.downcase}"]} }
      named_scope :equal2, lambda { |column, text|   {:conditions => ["lower(#{column}) = ?", "#{text.downcase}"]} }


      named_scope :published_only2, :conditions => ["id in (?)", [1,2,9]]
      named_scope :secured2, :conditions => ["id between ? and ?", 1,19]

named_scope :as2,      :conditions => [ "iso3 like ?", 'A%' ]
named_scope :buki2,    :conditions => [ "iso3 like ?", 'B%' ]

named_scope :high_rated2,  :conditions => [ "id > ?", 3 ]
named_scope :low_rated2,   :conditions => [ "id < ?", 3 ]

  FILTERS2 = [
    {:scope => "all",         :label => "All"},
    {:scope => "as",      :label => "from A"},
    {:scope => "buki",    :label => "from B"},
    {:scope => "high_rated",  :label => "High-Rated"},
    {:scope => "low_rated",   :label => "Low-Rated"}
  ]


    end