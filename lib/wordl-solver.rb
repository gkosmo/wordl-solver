require "csv"
require "fileutils"

FILE_PATH = "5_words.csv"
LETTER_WORDS = []
LETTER_FRENQUENCY = %w(e t a o i n s h r d l c u m f w y g p b v k j x q z)
INITIAL_POSITIONED_LETTER_MESSAGE = "enter in order the letters for which you know the position \n if you don't know the position press enter"
INITIAL_EXISTING_LETTER_MESSAGE = "enter all the letters you know exist in the word but for which you don't know the position"
INITIAL_NOT_EXISTING_MESSAGE = "enter all the letters you know DO NOT exist in the word"
POSITIONED_LETTER_MESSAGE = "enter all the letters in their position \n if you don't know the position press enter"
EXISTING_LETTER_MESSAGE = "add the letters you know exist in the word but for which you don't know the position"
NOT_EXISTING_MESSAGE = "enter all the letters you know DO NOT exist in the word"

CSV.foreach(FILE_PATH) do |row|
  LETTER_WORDS << row[0]
end
class WordlSolver

  def self.run
    WordlSolver.new.run
  end

  def run
    existing_letters, not_existing_letters, posish = initial_run
    iterating_run(existing_letters, not_existing_letters, posish)
  end

  private 

  def ask_and_list_words(positioned_letter_message, existing_letter_message, not_existing_message, existing_letters, not_existing_letters, posish)
    puts positioned_letter_message
    
    posish.each do |position, value|
      if value.nil? || value == ""
        puts "for position #{position + 1} enter a letter"
        posish[position] = gets.chomp
      else
        puts "for position #{position + 1} you've found: #{value}"
      end
    end
    puts existing_letters
    puts existing_letter_message
    exist = existing_letters | gets.chomp.split('')
    puts not_existing_message
    puts not_existing_letters
    not_exist = not_existing_letters | gets.chomp.split('')
    possible_words = []
    LETTER_WORDS.each do |word|
      put_in = true 
      posish.each do |key, value|
        next if value == ""
        put_in = false unless word[key] == value
      end
      possible_words << word if put_in
    end
    possible_words = possible_words.select do |word|
      exist.all? { |letter| word.include?(letter) }
    end

    possible_words = possible_words.select do |word|
      !not_exist.any? { |letter|  word.include?(letter) }
    end
    "here are the existing words"
    hash_word_frequency = Hash.new()
    possible_words.each do |word| 
      count = 0
      word.chars.each do |char|
        count += LETTER_FRENQUENCY.index(char) + 2 * word.chars.count(char)
      end
      hash_word_frequency[word] = count
    end
    hash_word_frequency = hash_word_frequency.sort_by { |k, v| v }
    hash_word_frequency.first(30).each do |word, count|
      puts "#{word} : #{count}"
    end
    return [exist, not_exist, posish]
  end

  def initial_run
    existing_letters = []
    not_existing_letters = []
    posish = {
      0 => nil,
      1 => nil,
      2 => nil,
      3 => nil,
      4 => nil,
    }
    history = ask_and_list_words(INITIAL_POSITIONED_LETTER_MESSAGE, INITIAL_EXISTING_LETTER_MESSAGE, INITIAL_NOT_EXISTING_MESSAGE, existing_letters, not_existing_letters, posish)
    puts "have you found it ? (y/n)"
    answer = gets.chomp
    existing_letters = history[0]
    not_existing_letters = history[1]
    puts "existing letters"
    puts existing_letters.join(" - ")
    puts "not existing letters"
    puts not_existing_letters.join(" - ")
    return [existing_letters, not_existing_letters, posish]
  end


  def iterating_run(existing_letters, not_existing_letters, posish)
    answer = nil
    until answer == 'y'
      existing_letters, not_existing_letters, posish = ask_and_list_words(POSITIONED_LETTER_MESSAGE, EXISTING_LETTER_MESSAGE, NOT_EXISTING_MESSAGE, existing_letters, not_existing_letters, posish)
      puts "have you found it ? (y/n)"
      answer = gets.chomp
    end
    puts 'you found it!'
  end
end
