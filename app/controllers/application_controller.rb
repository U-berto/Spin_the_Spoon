class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def set_up_guest_user
    return if current_user

    guest = User.create!(email: "guest_#{User.count}@sts.com", password: "password", address: "barcelona")
    sign_in(guest)
  end
end
