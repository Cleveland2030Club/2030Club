class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :requires_admin

end
