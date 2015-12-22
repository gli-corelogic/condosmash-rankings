class PlayersController < ActionController::Base
  def show
    @player = Player.find(params[:id])
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)
    if @player.save
      render 'show'
    else
      render 'new'
    end
  end

  private

  def player_params
    params.require(:player).permit(:name, :description, :rating)
  end
end