class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @categories = ["Arabic", "Asian", "European", "South American", "Discover local"]
  end
end
