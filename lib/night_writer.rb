require './lib/dictionary'
class NightWriter
  include Dictionary 

  attr_reader :cipher, :message, :output, :rendered, :transposed

  def initialize
    @cipher = dictionary
    @output = []
  end
  
  def perform
    read_message
    translate_message
    create_limited_output
    write_message
    confirmation
  end

  def read_message
    @message = File.open("#{ARGV[0]}").read
  end
  
  
  def translate_message
    @message = @message.gsub("\n", " ")
    @message.each_char do |letter|
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

  

  def confirmation
    p "Created '#{ARGV[1]}' containing #{@message.length} characters"
  end
end

runner = NightWriter.new
runner.perform

