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
    player_a = Player.find(@match.player_a_id)
    player_b = Player.find(@match.player_b_id)
    # TODO: check for division by 0
    player_a_outcome = 1.0 * @match.player_a_score / (@match.player_a_score + @match.player_b_score)
    player_b_outcome = 1.0 * @match.player_b_score / (@match.player_a_score + @match.player_b_score)
    @match.player_a_rating_delta = calculate_player_rating_delta(player_a.rating - player_b.rating, player_a_outcome)
    @match.player_b_rating_delta = calculate_player_rating_delta(player_b.rating - player_a.rating, player_b_outcome)
    player_a.rating += @match.player_a_rating_delta
    player_b.rating += @match.player_b_rating_delta
    player_a.save
    player_b.save

    # puts 'a outcome: ' + player_a_outcome.to_s
    # puts 'b outcome: ' + player_b_outcome.to_s
    # puts 'player_a_rating_delta: ' + @match.player_a_rating_delta.to_s
    # puts 'player_b_rating_delta: ' + @match.player_b_rating_delta.to_s

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

    def calculate_player_rating_delta(rating_difference, game_outcome)
      winning_expectancy = 1 / (10**(-1.0 * rating_difference/400) + 1)
      puts 'winning expectancy: ' + winning_expectancy.to_s
      points = game_outcome - winning_expectancy
      return (36.0 * points)
    end
end