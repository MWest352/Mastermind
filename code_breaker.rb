# frozen_string_literal: false

### Command Line Mastermind ###

# The Game
class CodeBreaker < Player
  include NewGame

  def initialize
    @player_one = make_player_one
  end

  def make_player_one
    puts
    puts "P1 enter name"
    player_name = gets.chomp
    player = Player.new(player_name)
    puts "Welcome #{player.name}."
    puts
    player
  end

  def input_code
    @correct = 0
    puts "Choose four colors."
    puts "Your choices are: Red (R), Yellow (Y), Blue (B), Green (G), Magenta (M) or Cyan (C)"
    input = gets.chomp.downcase
    if input.to_s.length == 4
      @input_arr = input.split("")
    else
      puts "Please try again. "
      input_code
    end
  end

  def check_win
    if @correct == 4
      win
    else
      try_again
    end
  end

  def win
    puts "Congratulations, you won!"
    new_game
  end

  def try_again
    if @tries > 1
      @tries -= 1
      puts "Try again, you have #{@tries} guesses left"
      puts
      input_code
      compare_arrays
    else
      game_over
    end
  end

  def game_over
    puts "Game Over."
    new_game
  end

  def compare_arrays
    matches = @input_arr & @code_generator
    matches.each do |number|
      puts
      puts "Match Found Element #{number}"
      if @input_arr.rindex(number) == @code_generator.rindex(number)
        puts "Correct Color and Space Slot #{@code_generator.rindex(number)}"
        @correct += 1
      else
        puts "Correct Color Wrong Slot"
      end
    end
    check_win
  end

  def code_generator
    @code_generator ||= %w[r g b y c m].permutation(4).to_a.sample
  end

  def codebreaker_logic
    @tries = 12
    input_code
    code_generator
    compare_arrays
  end
end
