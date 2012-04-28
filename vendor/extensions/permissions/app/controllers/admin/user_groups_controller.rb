class Admin::UserGroupsController < Admin::ResourceController
  active_scaffold :user_group
  layout "application_active_scaffold"

    active_scaffold :user_group do |config|

  #config.left_handed = true
#    config.create.persistent = true

#    config.actions.exclude :update
  config.actions.exclude :show
#    config.actions.exclude :delete

  config.list.sorting = {:id => 'DESC'}
  config.list.per_page = 22


    #config.columns[:user].form_ui = :select

    end
end
