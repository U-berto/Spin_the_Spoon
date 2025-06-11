class PagesController < ApplicationController
  before_action :set_up_guest_user, only: [:home]
  before_action :authenticate_user!

  def home
    @categories = ["Arabic", "Asian", "Mediterranean", "South American", "Discover local"]
  end
end
