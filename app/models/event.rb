class Event < ActiveRecord::Base
  has_many :entries

  def join(member)
    Entry.create(:event_id => self.id, :member_id => member.id)
  end
end
