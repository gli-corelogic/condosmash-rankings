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
  end
end