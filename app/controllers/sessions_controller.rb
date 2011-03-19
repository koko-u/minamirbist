class SessionsController < ApplicationController
  def index
  end

  def create
    auth = request.env["omniauth.auth"]
    session[:uid] = auth["uid"]

    if Member.find_by_uid_and_provider(auth["uid"], auth["provider"]).nil?
      session[:member] = {
        :name => auth["user_info"]["name"], 
        :twitter_id => auth["user_info"]["nickname"],
        :profile => auth["user_info"]["description"],
        :blog_url => auth["user_info"]["urls"]["Website"],
        :provider => auth["provider"],
        :birthday => Date.today
      }
      redirect_to new_member_path
    else
      redirect_to events_path
    end

  end

  def destroy
    session[:uid] = nil
    session[:member] = nil
    redirect_to root_path, :notice => I18n.t('sessions.signout', :scope => [:views])
  end

  def failure
    redirect_to root_path, :notice => I18n.t('failed', :scope => [:views])
  end
end
