class BoardTerm < ActiveRecord::Base
  belongs_to :user
  attr_accessible :end_at, :position, :start_at, :user_id

  default_scope order('position ASC, end_at DESC')
end
