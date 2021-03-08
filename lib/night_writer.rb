require './lib/dictionary'
class NightWriter
  include Dictionary
  attr_reader :cipher, :message, :print_output, :rendered, :transposed, :braille_result
  
  def initialize
    @cipher = dictionary
    @print_output = ""
    @braille_result = ["", "", ""]
    @message = File.open("#{ARGV[0]}").read.delete("\n")
  end

  def perform
    translate
    write_message
    confirmation
  end

  def translate
    @message = message.gsub("\n", " ")
    message.each_char do |letter|
       if letter =~ /[A-Z]/
         make_capital(letter)
       else
         make_minuscule(letter)
       end
    end
    create_limited_output
  end

  def create_limited_output
    while @braille_result[0] != "" do
      @braille_result.each do |braille_letter|
        @print_output << braille_letter.slice!(0..79) + "\n"
      end
    end
    @print_output
  end

  def make_capital(letter)
    cap = @cipher["capitalize"]
    braille_letter = @cipher[letter.downcase]
    @braille_result[0] = @braille_result[0] + cap[0] + braille_letter[0]
    @braille_result[1] = @braille_result[1] + cap[1] + braille_letter[1]
    @braille_result[2] = @braille_result[2] + cap[2] + braille_letter[2]
    @braille_result
  end

  def make_minuscule(letter)
    braille_letter = @cipher[letter]
    @braille_result[0] = @braille_result[0] + braille_letter[0]
    @braille_result[1] = @braille_result[1] + braille_letter[1]
    @braille_result[2] = @braille_result[2] + braille_letter[2]
    @braille_result
  end

  def write_message
    braille = File.open("#{ARGV[1]}", "w")
    braille.write @print_output
  end
  
  def confirmation
    puts "Created '#{ARGV[1]}' containing #{@message.length} characters"
  end
end

runner = NightWriter.new
runner.perform