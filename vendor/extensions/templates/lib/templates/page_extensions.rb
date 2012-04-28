module Templates::PageExtensions

  def self.included(base)
    base.class_eval do
      before_save :match_with_template
    end
  end

  def match_with_template
    unless self.template.blank?
      self.class_name = self.template.page_class_name
      self.layout_id = self.template.layout_id
    end
  end

  def template_name
    template ? template.name : "Blank Page"
  end

  def is_a_blank_page?
    ! template_id?
  end

  # Meta-programming methods to determine if page is built on a specific template
  # e.g. @page.is_a_press_release? assuming you have "Press Release" template defined.
  begin
    Template.all.each do |unique_template|
      class_eval <<-CODE, __FILE__, __LINE__
        def is_a_#{unique_template.name.titleize.scan(/\w+/).join.underscore}?
          template_id? && template.name == "#{unique_template.name}"
        end
      CODE
    end
  rescue
    # This won't run before initial migrations, which create the Template table
  end

end