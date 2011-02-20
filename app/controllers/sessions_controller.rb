class SessionsController < ApplicationController
  def index
  end

  def create
    auth = request.env["omniauth.auth"]
    unknown_user = (@member = Member.find_by_uid_and_provider(auth["uid"], auth["provider"])).nil?

    if unknown_user
      @member = Member.create(auth)
      session[:uid] = @member.uid
      redirect_to edit_member_path(@member)
    else
      session[:uid] = @member.uid
      redirect_to events_path
    end

  end

  def destroy
    session[:uid] = nil
    redirect_to root_path, :notice => I18n.t('sessions.signout', :scope => [:views])
  end
end
