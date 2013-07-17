class HomeController < ApplicationController
  include HomeHelper
  layout 'logged_out'

  def index
    if user_signed_in?
      redirect_to dashboard_path
    end
    #@homepage_content = HomePageContent.where(:active => true).first
  end

  def pricing

  end
end
