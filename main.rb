# frozen_string_literal: false

### Command Line Mastermind ###

require_relative 'modules/new_game.rb'
require_relative 'player.rb'
require_relative 'code_breaker.rb'
require_relative 'code_maker.rb'
require_relative 'mastermind'

game = Mastermind.new
game.make_or_break