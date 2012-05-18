# lib/permission_check.rb
# Here we create a new subclass of Struct, an easy way to create a class with an attribute.
class PermissionCheck < Struct.new( :permission_name )

  # NOTE  - here it is assumed that you have
  # a) A method to find the current_user from the controller: ApplicationController#current_user
  # b) A method to check if the current_user has a specific permission: User#has_permission?
  # c) A method to redirect and notify the user if they do not have adequate permissions: ApplicationController#unauthorized_action

  # this is called from the controller automatically when we use before_filter
  def before( controller )
    # unless the current_user has permission...
    unless controller.current_user.has_permission?( permission_name )
    # redirect and notify user
      controller.unauthorized_action
    end
  end

  # after_filters can be defined in the same way
  def after( controller )

  end



end



#To make things neater still, we can create a class method for this in ApplicationController:
#
#class ApplicationController < ActionController::Base
#
#  # Helper method to add this before filter to the controller
#  def self.check_permission( permission, options = {} )
#    before_filter PermissionCheck.new( permission ), options
#  end
#
#end
#
#And our controllers now look like:
#
#class OrdersController < ApplicationController
#
#  check_permission :orders, :only => [:index, :show, :destroy]
#
#  # etc...
#
#end
#
#class CustomersController < ApplicationController
#
#  check_permission :customers, :only => [:index, :destroy]
#
#
#  # etc...
#end
#
