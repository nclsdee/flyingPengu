class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @navbar = true
  end

  def show
    render template: "pages/#{params[:page]}"
  end

end
