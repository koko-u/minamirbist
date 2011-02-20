class Member < ActiveRecord::Base
  def self.create(auth)
    create!(:provider => auth["provider"], :uid => auth["uid"], :twitter_id => auth["user_info"]["name"])
  end
end
