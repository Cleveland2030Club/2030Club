require 'spec_helper'

module Admin
  describe BoardTermsController do

    describe 'GET admin/users/:user_id/board_terms' do
      it 'routes to admin/board_terms#index' do
        get('admin/users/1/board_terms').should route_to(controller: 'admin/board_terms',
                                                         action: 'index', user_id: '1')
      end
    end

    describe 'GET admin/users/:user_id/board_terms/new' do
      it 'routes to admin/board_terms#new' do
        get('admin/users/1/board_terms/new').should route_to(controller: 'admin/board_terms',
                                                             action: 'new', user_id: '1')
      end
    end

    describe 'GET admin/users/:user_id/board_terms/:id/edit' do
      it 'routes to admin/board_terms#edit' do
        get('admin/users/1/board_terms/1/edit').should route_to(controller: 'admin/board_terms',
                                                                action: 'edit', user_id: '1', id: '1')
      end
    end

    describe 'POST admin/users/:user_id/board_terms' do
      it 'routes to admin/board_terms#create' do
        post('admin/users/1/board_terms').should route_to(controller: 'admin/board_terms',
                                                          action: 'create', user_id: '1')
      end
    end

    describe 'PUT admin/users/:user_id/board_terms/:id' do
      it 'routes to admin/board_terms#update' do
        put('admin/users/1/board_terms/1').should route_to(controller: 'admin/board_terms',
                                                           action: 'update', user_id: '1', id: '1')
      end
    end

    describe 'DELETE admin/users/:user_id/board_terms/:id' do
      it 'routes to admin/board_terms#destroy' do
        delete('admin/users/1/board_terms/1').should route_to(controller: 'admin/board_terms',
                                                              action: 'destroy', user_id: '1', id: '1')
      end
    end

  end
end