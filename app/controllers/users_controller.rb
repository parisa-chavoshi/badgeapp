class UsersController < ApplicationController
  def index 
    @users = User.all.includes(:badges)
    @badge_templates = BadgeTemplate.all
  end
end