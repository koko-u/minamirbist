class Event < ActiveRecord::Base
  has_many :entries
  belongs_to :organizer, :class_name => "Member", :foreign_key => "organizer"

  validates :organizer, :presence => true
  validates :name, :presence => true
  validates :place, :presence => true

  class FutureDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if options[:on] == :create && value <= Date.today
        record.errors[attribute] << "should organize in the future date"
      end
    end
  end
  validates :date_on, :future_date => { :on => :create }

  def join(member)
    Entry.create(:event => self, :member => member).valid?
  end

  def cancel(member)
    joined_entries = Entry.where(:event_id => self, :member_id => member)
    unless joined_entries.empty?
      joined_entries.map(&:destroy)
    else
      false
    end
  end
end
