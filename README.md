# Wordl-Solver

A Ruby gem to help solve Wordle puzzles by suggesting the best possible words based on your previous guesses.

## Installation

```bash
gem install wordl-solver
```

Or add to your Gemfile:

```ruby
gem 'wordl-solver'
```

## Usage

You can use wordl-solver directly from the command line:

```bash
wordl-solver
```

The tool will interactively guide you through the process:

1. Enter your guess results for each position using the following format:
   - `s` + letter = Silver/Gray (letter not in word)
   - `y` + letter = Yellow (letter in word but wrong position)
   - `g` + letter = Green (letter in correct position)

2. The tool will filter the possible words based on your input and display them sorted by letter frequency to help you make your next guess.

3. Continue until you solve the Wordle!

## Example

If you guessed "arose" and got:
- 'a' was gray (not in the word)
- 'r' was yellow (in the word but wrong position)
- 'o' was gray (not in the word)
- 's' was gray (not in the word)
- 'e' was yellow (in the word but wrong position)

When prompted for each position, you would enter:
1. `sa` (silver/gray a)
2. `yr` (yellow r)
3. `so` (silver/gray o)
4. `ss` (silver/gray s)
5. `ye` (yellow e)

The tool will then suggest possible words to try next.

## Features

- Filters words based on letter positions (green, yellow, gray)
- Ranks possible words by letter frequency
- Interactive command-line interface
- Uses a comprehensive list of 5-letter English words

## Development

```bash
git clone https://github.com/gkosmo/wordl-solver.git
cd wordl-solver
bundle install
```

### Running Tests

```bash
rake test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

Please make sure to add tests for your contributions.

## License

Copyright (c) 2022 George Kosmopoulos. See LICENSE.txt for details.