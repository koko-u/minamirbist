class Member < ActiveRecord::Base
  validates :twitter_id, :presence => true

  def self.create_by_auth(auth)
    create!(:name => auth["user_info"]["name"], :twitter_id => auth["user_info"]["nickname"],
            :profile => auth["user_info"]["description"], :blog_url => auth["user_info"]["urls"]["Website"],
            :provider => auth["provider"], :uid => auth["uid"], :birthday => Date.today)
  end

end
