require './lib/dictionary'

class NightReader
  include Dictionary
  attr_reader :cipher, :symbol_arr, :letters_to_be, :new_letters
  
  def initialize
    @cipher = dictionary.invert.transform_keys(&:join)
    @letters_to_be = []
    @new_letters = []
    @symbol_arr = [[],[],[]]
  end

  def perform
    read_message
    create_symbol_array
    create_letter_array
    generate_output
    # write_message
    # confirmation
  end
  def read_message
    @message = File.open("#{ARGV[0]}").read
  end
  
  def create_symbol_array
    @message = @message.split("\n")
    @symbol_arr[0] << @message[0]
    @symbol_arr[1] << @message[1]
    @symbol_arr[2] << @message[2]
    # @message.each_with_index do |string, index|
    #   if @symbol_arr[index] == index
    #     #if it's position zero, 1 or two, @symbol_arr[
    #       @symbol_arr[0] << string
    #       # elsif THE OTHER THING
    #       #     @symbol_arr[1] << string
    #       # elsif THIS
    #       #    @symbol_arr[2] << string
    #     end
    #   end
    #   @symbol_arr
  end

  def create_letter_array
    
    @symbol_arr
    #the symbol array should be an array of arrays
    #the should look like 3 arrays inside of one array
    first_set = @symbol_arr[0]
    second_set = @symbol_arr[1]
    third_set = @symbol_arr[2]
    first_result = []
    second_result = []
    third_result = []
    
    first_set[0].chars.each_slice(2).to_a.each {|chars| first_result << chars}
    second_set[0].chars.each_slice(2).to_a.each {|chars| second_result << chars}
    third_set[0].chars.each_slice(2).to_a.each {|chars| third_result << chars}
    
    first_result.each_with_index do |chars, index|
      native_braille = chars.join + second_result[index].join + third_result[index].join
      @letters_to_be[index] = native_braille
    end
    @letters_to_be
  end

  def generate_output
    @letters_to_be.map do |letter|
      @new_letters << @cipher[letter]
      letter.delete("capitalize") if letter == "capitalize"
    end
    correct_format = []
    @new_letters.each_with_index do |letter, index|
      if letter == "capitalize"
        next
        require 'pry'; binding.pry
        letter.upcase!
        letter.delete("capitalize")
      else
        correct_format << letter
      end
    end
    correct_format  
  end
  #   @letters_to_be.each_with_index do |letters_to_be, index|
  #     if letters_to_be == ".....0"
  #       #will need to unshift or remove capital braille character
  #       add_uppercase(letters_to_be)
  #       #grab the character one index after this one
  #       # dictionary.invert[whatever letters to be was] shovel that into some kind results array


  #     else
  #       add_lowercase(letters_to_be)
  #     end
end

runner = NightReader.new
runner.perform


#read the file
#
