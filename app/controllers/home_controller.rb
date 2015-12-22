class HomeController < ActionController::Base
  def index
    @players = Player.all
  end
end