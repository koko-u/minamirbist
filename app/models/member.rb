class Member < ActiveRecord::Base
  validates :twitter_id, :presence => true

  def self.create(auth)
    create!(:provider => auth["provider"], :uid => auth["uid"], :twitter_id => auth["user_info"]["name"])
  end
end
