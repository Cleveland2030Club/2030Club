class BoardTerm < ActiveRecord::Base
  belongs_to :user
  attr_accessible :end_at, :position, :start_at, :user_id
end
