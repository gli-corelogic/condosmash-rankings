class Match < ActiveRecord::Base
  attr_accessor :player_a_name, :player_b_name, :created_at_formatted, :created_at_ago
end