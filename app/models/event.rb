class Event < ActiveRecord::Base
  has_many :entries
  belongs_to :organizer, :class_name => "Member", :foreign_key => "organizer"

  def join(member)
    Entry.create(:event_id => self.id, :member_id => member.id)
  end

end
