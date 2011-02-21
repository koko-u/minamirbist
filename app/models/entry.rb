class Entry < ActiveRecord::Base
  belongs_to :event
  belongs_to :member

  validates :member_id, :uniqueness => { :scope => :event_id }

end
