# frozen_string_literal: true

require "csv"
require "fileutils"

FILE_PATH = File.join(File.dirname(__FILE__), "5_words.csv")

LETTER_WORDS = []

CSV.foreach(FILE_PATH) do |row|
  LETTER_WORDS << row[0]
end

# The Class WordlSolver is a class that contains the methods to solve the wordl puzzle.
class WordlSolver
  class << self
    def find_possible_words(greys, greens, yellows)
      @greys = greys
      @greens = greens 
      @yellows = yellows
      @possible_words = @possible_words.nil? || @possible_words.empty? ? LETTER_WORDS : @possible_words
      filter_greens
      filter_yellows
      filter_greys
      @possible_words
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
        @greys.each do |letter|
          if @greens.values.include?(letter)
            word.count(letter) > 1
          else
            word.include?(letter)
          end
        end
      end
    end
  end
end
