class HomeController < ApplicationController
  def index
    flash.keep
    if user_signed_in?
      redirect_to dashboard_path
    else
      redirect_to proposals_path
    end
  end

  def motivation
    @users = User.with_signup_reasons.shuffle
    @losers = User.without_signup_reasons.shuffle
  end

  def champs
    @users = User.by_contribution
    @champs, @scamps = @users.partition { |u| u.contribution_score > 0 }
  end
end