# frozen_string_literal: false

# Main Game Run Sequence
class Mastermind
  def make_or_break
    puts "Welcome to Mastermind."
    puts "Would you like to be Codemaker (M) or codebreaker (B)?"
    input = gets.chomp.downcase
    if input == "m"
      puts "You have chosen to be Codemaker"
      codemaker = CodeMaker.new
      codemaker.codemaker_logic
    elsif input == "b"
      puts "You have chosen to be Codebreaker"
      codebreaker = CodeBreaker.new
      codebreaker.codebreaker_logic
    else
      puts
      puts "Invalid response, please try again."
      puts
      make_or_break
    end
  end
end