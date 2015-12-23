include ActionView::Helpers::DateHelper

class HomeController < ApplicationController
  def index
    @players = Player.all

    @recent_matches = Match.order('created_at DESC').limit(10)
    @recent_matches.each do |match|
      match.player_a_name = Player.find(match.player_a_id).name
      match.player_b_name = Player.find(match.player_b_id).name
      match.created_at_formatted = match.created_at.in_time_zone.strftime('%m/%d/%Y %I:%M %p')
      match.created_at_ago = time_ago_in_words(match.created_at)
    end

    if @recent_matches.size > 0
      @last_match = @recent_matches[0]
      @last_match_player_a = Player.find(@recent_matches[0].player_a_id)
      @last_match_player_b = Player.find(@recent_matches[0].player_b_id)
    end
  end
end