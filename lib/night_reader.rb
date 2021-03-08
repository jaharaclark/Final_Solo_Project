require './lib/dictionary'
class NightReader
  include Dictionary
  attr_reader :cipher, :symbol_arr, :letters_to_be, :new_letters, :finished
  def initialize
    @cipher = dictionary.invert.transform_keys(&:join)
    @letters_to_be = []
    @new_letters = []
    @symbol_arr = [[],[],[]]
    @message = File.open("#{ARGV[0]}").read
  end

  def perform
    create_symbol_array
    create_letter_array
    generate_output
    write_message
    confirmation
  end
 
  def create_symbol_array
    @message = @message.split("\n")
    divided_message = @message.each_slice(@message.size/(@message.size/3)).to_a
    transposed_message = divided_message.transpose
    @symbol_arr[0] << transposed_message[0]
    @symbol_arr[1] << transposed_message[1]
    @symbol_arr[2] << transposed_message[2]
    @symbol_arr
  end

  def create_letter_array
    @symbol_arr
    first_result = []
    second_result = []
    third_result = []
    @symbol_arr[0].join.chars.each_slice(2).to_a.each {|chars| first_result << chars}
    @symbol_arr[1].join.chars.each_slice(2).to_a.each {|chars| second_result << chars}
    @symbol_arr[2].join.chars.each_slice(2).to_a.each {|chars| third_result << chars}
    first_result.each_with_index do |chars, index|
      native_braille = chars + second_result[index] + third_result[index]
      @letters_to_be[index] = native_braille
    end
    @letters_to_be
    @letters_to_be
  end
  
  def generate_output
    @letters_to_be.map do |letter|
      final_letters = letter.join
      @new_letters << @cipher[final_letters] 
    end
    @finished = @new_letters.join
    @finished
  end

  # def generate_output
  #   @letters_to_be.map do |letter|
  #     @new_letters << @cipher[letter]
  #     letter.delete("capitalize") if letter == "capitalize"
  #   end
  #   correct_format = []
  #   @new_letters.each_with_index do |letter, index|
  #     if letter == "capitalize"
  #       next
  #       require 'pry'; binding.pry
  #       letter.upcase!
  #       letter.delete("capitalize")
  #     else
  #       correct_format << letter
  #     end
  #   end
  #   correct_format
  # end



  def write_message
    message = File.open("#{ARGV[1]}", "w")
    message.write @finished
  end

  def confirmation
    puts "Created '#{ARGV[1]}' containing #{@finished.length} characters"
  end
 
end

runner = NightReader.new
runner.perform