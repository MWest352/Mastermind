module NewGame
  def new_game
    puts "Would you like to play again? (Y/N)"
    input = gets.chomp.downcase
    if input == "y"
      game = Mastermind.new
      game.make_or_break
    else
      exit
    end
  end
end