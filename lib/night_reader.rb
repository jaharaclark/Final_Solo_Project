require './lib/dictionary'
class NightReader
  include Dictionary
  attr_reader :cipher, :symbol_arr, :letters_to_be, :new_letters, :finished
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
    write_message
    confirmation
  end
  def read_message
    @message = File.open("#{ARGV[0]}").read
  end
  def create_symbol_array
    @message = @message.split("\n")
    # @divided_message = @message.each_slice(@message.size/(@message.size/3)).to_a
    divided_message = @message.each_slice(@message.size/(@message.size/3)).to_a
    transposed_message = divided_message.transpose
    @symbol_arr[0] << transposed_message[0]
    @symbol_arr[1] << transposed_message[1]
    @symbol_arr[2] << transposed_message[2]
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
    
    first_set[0].join.chars.each_slice(2).to_a.each {|chars| first_result << chars}
    second_set[0].join.chars.each_slice(2).to_a.each {|chars| second_result << chars}
    third_set[0].join.chars.each_slice(2).to_a.each {|chars| third_result << chars}
    
    first_result.each_with_index do |chars, index|
      native_braille = chars + second_result[index] + third_result[index]
      @letters_to_be[index] = native_braille
    end
    @letters_to_be
  end
  
  def generate_output
    @letters_to_be.map do |letter|
      final_letters = letter.join
      @new_letters << @cipher[final_letters] 
    end
    @finished = @new_letters.join
    puts @finished
  end
  def write_message
    message = File.open("#{ARGV[1]}", "w")
    message.write @finished
  end
  def confirmation
    puts "Created '#{ARGV[1]}' containing #{@finished.length} characters"
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