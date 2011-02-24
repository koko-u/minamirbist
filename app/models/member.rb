class Member < ActiveRecord::Base
  has_many :entries
  has_many :events, :foreign_key => "organizer"
  class CannotChangeValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << I18n.t('cannt_change') unless Member.find(record.id)[attribute] == value
    end
  end

  validates :twitter_id, :presence => true, :uniqueness => true
  validates :birthday, :presence => true
  validates :twitter_id,  :cannot_change => { :on => :update }

  def self.create_by_auth(auth)
    create!(:name => auth["user_info"]["name"], :twitter_id => auth["user_info"]["nickname"],
            :profile => auth["user_info"]["description"], :blog_url => auth["user_info"]["urls"]["Website"],
            :provider => auth["provider"], :uid => auth["uid"], :birthday => Date.today)
  end

end
