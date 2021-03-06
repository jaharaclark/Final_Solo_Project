class NightWriter
  attr_reader :cipher, :message, :output

  def initialize(cipher)
    @cipher = {      
      "a" => ["0.", "..", ".."],
      "b" => ["0.", "0.", ".."],
      "c" => ["00", "..", ".."],
      "d" => ["00", ".0", ".."],
      "e" => ["0.", ".0", ".."],
      "f" => ["00", "0.", ".."],
      "g" => ["00", "00", ".."],
      "h" => ["0.", "00", ".."],
      "i" => [".0", "0.", ".."],
      "j" => [".0", "00", ".."],
      "k" => ["0.", "..", "0."],
      "l" => ["0.", "0.", "0."],
      "m" => ["00", "..", "0."],
      "n" => ["00", ".0", "0."],
      "o" => ["0.", ".0", "0."],
      "p" => ["00", "0.", "0."],
      "q" => ["00", "00", "0."],
      "r" => ["0.", "00", "0."],
      "s" => [".0", "0.", "0."],
      "t" => [".0", "00", "0."],
      "u" => ["0.", "..", "00"],
      "v" => ["0.", "0.", "00"],
      "w" => [".0", "00", ".0"],
      "x" => ["00", "..", "00"],
      "y" => ["00", ".0", "00"],
      "z" => ["0.", ".0", "00"],
      " " => ["..", "..", ".."]
    }
    @message = File.open("#{ARGV[0]}")
    @output = []
  end
  # braille = File.open("#{ARGV[1]}", 'w')
  
  # while line = message.gets do
  #     braille.write line
  # end
  characters = File.read("#{ARGV[0]}")
  count = characters.delete("\n")
  
  puts characters[0...4]
  puts "Created #{ARGV[1]} containing #{count.length} characters"
  message.close

  def read_message
    split_message = @message.split("")

    split_message.each do |letter|
      @output << @cipher[letter]
    end
    translate_message
  end


  def translate_message
    # transposed = @output.transpose

    if @output.length > 39
    write_message
  end

  def write_message
    braille = File.open("#{ARGV[1]}", "w")
    NAME_HERE .each do |element|
      element.join("")
      braille.write element
      braille.write "\n"
  end
end
