# frozen_string_literal: false

### Mastermind Code Maker ###

# The Game
class CodeMaker
  include NewGame

  def initialize
    @correct = 0
    @new_possibilities = []
    @value_index = []
    @turn = 12
  end

  def input_code
    puts "Choose four colors."
    puts "Your choices are: "
    puts "Red (R), Yellow (Y), Blue (B), Green (G), Magenta (M) or Cyan (C)"

    input = gets.chomp.downcase

    if check_input(input) == true
      @code ||= input.split("")
    else
      puts "Please try again. "
      input_code
    end
  end

  def check_input(input)
    input = input.chars
    code = %w(r g b y c m )
    (input & code).size == 4
  end

  def first_guess
    return @first_guess if @first_guess

    set = %w[r c b y m g]
    @first_guess ||= set.sample(4)
  end

  def unlock
    @first_guess = nil
  end

  def code_generator
    @generated_code ||= %w[r g b y c m].permutation(4).to_a
  end

  def guess
    if @turn == 12
      first_guess
    else
      reasoning
    end
  end

  def compare_arrays(guess)
    @match = guess & @code

    @match.each do |number|
      puts
      puts "Match Found Element #{number}"
      if guess.rindex(number) == @code.rindex(number)
        @matched_index = guess.rindex(number)
        @matched_letter = "#{number}"
        @value_index.push(@matched_letter)
        @value_index.push(@matched_index)
        @value_index.uniq!
        @correct = (@value_index.length / 2)
        puts "Correct Color and Space Slot #{guess.rindex(number)}"
        narrow_results
      else
        puts "Correct Color Wrong Slot"
      end
    end
    puts
    puts "Correct = #{@correct}"
    puts
    check_win
  end

  def check_win
    if @correct == 4
      win
    else
      @turn -= 1
      puts "Turn # #{@turn}"
      puts "Calculating..."
      sleep(3)
    end
  end

  def narrow_results 
    x = 0
    code_generator.each do
      if code_generator[x][@matched_index] == @matched_letter
        @new_possibilities.push(code_generator[x]).uniq!
      end
      x += 1
    end
  end

  def reasoning
    if @correct == 0
      unlock
      first_guess
    elsif @correct == 1
      @new_possibilities.sample
    elsif @correct > 1 && @correct < 4
      filter_guesses
    elsif @correct == 4
      win
    end
  end

  def win
    puts "I have broken your code."
    new_game
  end

  def filter_guesses
    if @correct == 2
      filter_array2.sample
    elsif @correct == 3
      filter_array3.sample
    end
  end

  def filter_array2
    @new_possibilities.select {|arr| arr[@value_index[1].to_i] == @value_index[0] && arr[@value_index[3].to_i] == @value_index[2]}
  end

  def filter_array3
    @new_possibilities.select {|arr| arr[@value_index[1].to_i] == @value_index[0] && arr[@value_index[3].to_i] == @value_index[2] && arr[@value_index[5].to_i] == @value_index[4]}
  end

  def codemaker_logic
    input_code
    first_guess
    while @turn > 0 do
      compare_arrays(guess)
      if @turn == 0
        puts "Congratulations! Your code was difficult and I could not break it."
        new_game
      end
    end
  end
end
