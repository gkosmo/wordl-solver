# frozen_string_literal: true

require 'csv'
require 'fileutils'

FILE_PATH = File.join(File.dirname(__FILE__), '5_words.csv')

LETTER_WORDS = []

CSV.foreach(FILE_PATH) do |row|
  LETTER_WORDS << row[0]
end

class WordlSolver
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
    @possible_words = []
  end

  def self.run
    WordlSolver.new.run
  end

  def run
    answer = ''
    while answer != 'y'
      ask_for_letters_and_colours
      find_possible_words
      present_possible_words
      puts 'have you found it ? (y/n)'
      answer = gets.chomp
    end
  end

  private

  def ask_for_letters_and_colours
    puts 'Type in order color initial then the letter'
    puts '(s for silver, y for yellow and g for green)'
    5.times do |t|
      puts @greens[t]
      if @greens[t].nil?
        puts "for position #{t + 1}"
        letters = gets.chomp
        while check_word_correct(letters)
          puts "sorry, didn't catch that, try again:"
          letters = gets.chomp
        end
        sort_letter_upon_color(letters, t)
      else
        puts "for position #{t + 1} this #{@greens[t]}"
      end
    end
  end

  def sort_letter_upon_color(letters, t)
    case letters[0]
    when 's'
      @greys << letters[1]
    when 'y'
      @yellows[t] << letters[1]
    else
      @greens[t] = letters[1]
    end
  end

  def find_possible_words
    @possible_words = @possible_words.empty? ? LETTER_WORDS : @possible_words
    filter_greens
    filter_yellows
    filter_greys
  end

  def present_possible_words
    puts 'here are the existing words'
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
    hash_word_frequency.last(30).each do |word, count|
      p "#{word} : #{count}"
    end
  end

  def filter_greens
    @possible_words.select! do |word|
      put_in = true
      @greens.each do |key, value|
        next if value.nil?

        put_in = false unless word[key] == value
      end
      put_in
    end
  end

  def filter_yellows
    yellow_letters = @yellows.values.flatten.uniq
    @possible_words.select! do |word|
      possible = true
      word.chars.each_with_index do |letter, index|
        possible = false if @yellows[index].include?(letter)
      end
      possible = false unless yellow_letters.all? { |letter| word.include?(letter) }
      possible
    end
  end

  def filter_greys
    @possible_words.reject! do |word|
      @greys.any? { |letter| word.include?(letter) }
    end
  end

  def check_word_correct(letters)
    letters.length != 2 || !%w[s y g].include?(letters[0])
  end

  def set_letters_frequencies
    @frenquencies = {}
    @possible_words.each do |word|
      word.chars.each do |letter|
        @frenquencies[letter] = 0 if @frenquencies[letter].nil?
        @frenquencies[letter] += 1
      end
    end
  end
end
