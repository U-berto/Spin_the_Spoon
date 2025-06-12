class PartiesController < ApplicationController
  skip_before_action :authenticate_user!, only: :join

  include ApplicationHelper

  PARTY_ID_SALT = "bananaloca"
  PARTY_ID_HASH_LENGTH = 8

  def create
    user_input = params[:category_name].strip.capitalize
    matched_cuisine = find_cuisine(user_input)
    risk_level = params[:risk_level]
    # return matched_cuisine = "tapas" if matched_cuisine = "Discover Local"
    if matched_cuisine && CUISINES.include?(matched_cuisine)
      @party = Party.new(category: matched_cuisine, user: current_user, risk_level: risk_level)

      if @party.save
        redirect_to party_path(@party), notice: "Party created for #{matched_cuisine}!"
      else
        flash[:alert] = "Something went wrong"
        redirect_to root_path
      end
    else
      flash[:alert] = "Cuisine not found. Please write a valid option."
      redirect_to root_path
    end
  end

  def show
    @party = Party.find(params[:id])
    hashids = Hashids.new(PARTY_ID_SALT, PARTY_ID_HASH_LENGTH)
    @pin = hashids.encode(@party.id)
    @url = join_party_url(@pin)
    @qr_code = RQRCode::QRCode.new(@url)

    @nearby_users = []

    if @party.category == "Discover Local" && current_user.latitude && current_user.longitude
      @nearby_users = User.near([current_user.latitude, current_user.longitude], 50).where(public: true).where.not(id: current_user.id)
      @existing_user_parties = UserParty.where(party: @party, user_id: @nearby_users.map(&:id)).index_by(&:user_id)
    end
  end

  def join
    set_up_guest_user

    pin = params[:pin]
    hashids = Hashids.new(PARTY_ID_SALT, PARTY_ID_HASH_LENGTH)
    party_id = hashids.decode(pin).first

    @party = Party.find(party_id)
    @user_1 = current_user
    if @party.members.include?(current_user)
      redirect_to party_path(@party)
      flash[:alert] = "Already part of this party"
    else
    @invite = UserParty.create(user: @user_1, party: @party, accepted:true)
    redirect_to party_path(@party)
    end
  end

  def my_party
    @party = current_user.all_parties.last
    if @party
      redirect_to party_path(@party)
    else
      redirect_to root_path, alert: "You haven't created a party yet."
    end
  end
end
