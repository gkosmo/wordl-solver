require_relative "wordl_solver"
class WordlSolverInterface
  def self.run
    new.run
  end

  def initialize
    @yellows = {
      0 => [],
      1 => [],
      2 => [],
      3 => [],
      4 => []
    }
    @greys = []
    @greens = {
      0 => nil,
      1 => nil,
      2 => nil,
      3 => nil,
      4 => nil
    }
  end

  def run
    answer = ""
    while answer != "y"
      ask_for_letters_and_colours
      @possible_words = WordlSolver.find_possible_words(@greys, @greens, @yellows)
      present_possible_words
      puts "have you found it ? (y/n)"
      answer = gets.chomp
    end
  end

  private

  def sort_letter_upon_color(letters, t)
    case letters[0]
    when "s"
      @greys << letters[1]
    when "y"
      @yellows[t] << letters[1]
    else
      @greens[t] = letters[1]
    end
    @greys.reject! { |letter| @greens.include?(letter) || @yellows.values.flatten.include?(letter) }
  end

  def ask_for_letters_and_colours
    puts "Type two letters attached. First the initial of the color you have"
    puts "(s for silver (grey), y for yellow and g for green)"
    puts "and then the letter that was tried."
    puts "For example, if you have tried and arose and you get grey for a"
    puts "You'd type, after being prompted for the first position: sa "
    5.times do |position|
      puts @greens[position]
      if @greens[position].nil?
        puts "for position #{position + 1}"
        letters = retrieve_input_letters
        sort_letter_upon_color(letters, position)
      else
        puts "for position #{position + 1} this #{@greens[position]}"
      end
    end
  end

  def present_possible_words
    puts "here are the existing words"
    hash_word_frequency = {}
    set_letters_frequencies
    @possible_words.each do |word|
      count = 0
      word.chars.uniq.each do |char|
        count += @frenquencies[char]
      end
      hash_word_frequency[word] = count
    end
    hash_word_frequency = hash_word_frequency.sort_by { |_k, v| v }
    hash_word_frequency.each do |word, count|
      p "#{word} : #{count}"
    end
  end

  def word_is_correct?(letters)
    letters.length == 2 && %w[s y g].include?(letters[0])
  end

  def set_letters_frequencies
    @frenquencies = Hash.new(0)
    @possible_words.each do |word|
      word.chars.each do |letter|
        @frenquencies[letter] += 1
      end
    end
  end

  def retrieve_input_letters
    letters = gets.chomp
    until word_is_correct?(letters)
      puts "sorry, didn't catch that, try again:"
      letters = gets.chomp
    end
    letters
  end
end
