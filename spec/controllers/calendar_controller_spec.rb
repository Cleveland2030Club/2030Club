require 'spec_helper'

describe CalendarController do
  describe 'GET #index' do
    it 'will not throw exception on invalid requested date' do
      expect { get :index, month: 0, year: 2013 }.to_not raise_error
    end
  end
end
