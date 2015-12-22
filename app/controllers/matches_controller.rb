class MatchesController < ApplicationController

  def show
    @match = Match.find(params[:id])
    @match.player_a_name = Player.find(@match.player_a_id).name
    @match.player_b_name = Player.find(@match.player_b_id).name
  end

  def new
    @all_players = Player.all
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    # TODO: calculate player rating deltas
    @match.player_a_rating_delta = 0;
    @match.player_b_rating_delta = 0;

    if @match.save
      redirect_to action: 'show', id: @match.id
    else
      render 'new'
    end
  end

  private

  def match_params
    params.require(:match).permit(:player_a_id, :player_b_id, :player_a_score, :player_b_score, :player_a_rating_delta, :player_b_rating_delta)
  end
end