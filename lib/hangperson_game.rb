class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word 
  attr_accessor :guesses 
  attr_accessor :wrong_guesses
  attr_accessor :word_with_guesses
  def initialize(word)
    @word = word
    @guesses =""
    @wrong_guesses=""
    @word_with_guesses="-"*word.length
    
  end
  def guess(letter)
    if letter == nil
      raise ArgumentError
    end
      
    letter = letter.downcase
    if letter.match(/[A-Za-z]/) == nil 
      @valid = false
      raise ArgumentError
    end
    if @guesses.match(letter) != nil || @wrong_guesses.match(letter) != nil
      @valid = false
      return false
    end
    if @word.match(letter)!= nil
      indices = (0 ... @word.length).find_all { |i| @word[i,1] == letter }
      indices.each do |i|
        @word_with_guesses[i] = letter
      end
      @guesses = @guesses+letter 
    else
      @wrong_guesses = @wrong_guesses+letter
    end
    @valid = true
  end
  def check_win_or_lose
    if @wrong_guesses.length>=7
      return :lose
    end
    if @word == @word_with_guesses
      return :win
    end
    return :play
  end
    
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
