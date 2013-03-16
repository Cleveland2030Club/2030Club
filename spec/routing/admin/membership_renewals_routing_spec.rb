require 'spec_helper'

module Admin
  describe MembershipRenewalsController do

    describe 'GET /admin/users/:id/membership_renewals/new' do
      it 'routes to membership_renewals#new' do
        get('admin/users/1/membership_renewals/new').should route_to(controller: 'admin/membership_renewals', action: 'new', user_id: '1')
      end
    end

    describe 'POST /admin/users/:id/membership_renewals/' do
      it 'routes to membership_renewals#create' do
        post('admin/users/1/membership_renewals/').should route_to(controller: 'admin/membership_renewals', action: 'create', user_id: '1')
      end
    end

  end
end