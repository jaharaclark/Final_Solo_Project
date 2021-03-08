class NightWriter
  attr_reader :cipher, :message, :output, :rendered, :transposed

  def initialize
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
      " " => ["..", "..", ".."],
      "capitalize" => ["..", "..", ".0"],
      "!" => [".0", "0.", "00"],
      "." => [".0","..",".0"],
      "," => ["..","..",".0"],
      ";" => ["..",".0",".0"],
      "?" => ["00",".0",".0"],
      "(" => ["0.","00","00"],
      ")" => ["0.","00","00"],
      "[" => [".0","0.",".0"],
      "]" => ["00","00",".0"],
      '"' => ["..",".0",".."],
      "_" => [".0",".0",".0"],
      ":" => ["0.",".0",".0"],
      "-" => ["..","..","00"],
      "\'" => ["0.","00",".0"],
      "/" => [".0","..","0."],
      "<" => ["0.","0",".0"],
      ">" => [".0",".0","0."],
      "@" => [".0","..",".."],
      "^" => [".0",".0",".."],
      "&" => ["00","0.","00"],
      "$" => ["00","0.",".0"],
      "=" => ["00","00","00"],
      "*" => ["0.","..",".0"],
      "%" => ["00","..",".0"],
      "#" => [".0",".0","00"],
      "+" => [".0","..","00"],
      "1" => ["..","0.",".."],
      "2" => ["..","0.","0."],
      "3" => ["..","00",".."],
      "4" => ["..","00",".0"],
      "5" => ["..","0.",".0"],
      "6" => ["..","00","0."],
      "7" => ["..","00","00"],
      "8" => ["..","0.","00"],
      "9" => ["..",".0","0."],
      "0" => ["..",".0","00"]
    }
    @output = []
  end
  
  def perform
    read_message
    translate_message
    insert_line_breaks
    write_message
    # require 'pry'; binding.pry
    confirmation
  end
  def read_message
    @message = File.open("#{ARGV[0]}").read
  end
  
  
  def translate_message
    split_message = @message.downcase.split("")
    require 'pry'; binding.pry
    split_message.delete("\n")

    break_indicies = []
     split_message.first.each_with_index do |char, index|
         break_indicies << index if index % 39 == 0 && index != 0
     end
  
     split_message.each do |letter|
      @output << @cipher[letter]
    end
    @output
    # require 'pry'; binding.pry
    @transposed = @output.transpose

    # if @output.length > 40
    #   insert_line_breaks
    # end
  end

  def write_message
    braille = File.open("#{ARGV[1]}", "w")
    # braille.write @transposed.join("")
    @transposed.each do |element|
      joined = element.join("")
      braille.write joined
      braille.write "\n"
    end
  end

  def insert_line_breaks
    # take transposed, chop off first three arrays after 40
    # take that result to set up next three arrays, keep chopping until under 40

    # [0..39] 40 char slices when unjoined
    # [0..79] 80 char slices when joined


    # braille_message = @transposed.flatten.join("")
    # braille_for_print = braille_message.scan(/.{1,80}/)

    # x = []
    # @transposed.each {|element| x << element.join("").scan(/.{1,80}/)}
    # @transposed = x.flatten
    # require 'pry'; binding.pry

    

    @transposed.map do |row|
        break_indicies.reverse.map do |index|
        row.insert(index+1, "!!!!!!!!!!!!!!!")
      end
    end

    @transposed 
  end

  def confirmation
    p "Created '#{ARGV[1]}' containing #{@message.length} characters"
  end
end

runner = NightWriter.new
runner.perform

# "A" => ["..0.", "....", ".0.."],
#       "B" => ["..0.", "..0.", ".0.."],
#       "C" => ["..00", "....", ".0.."],
#       "D" => ["..00", "...0", ".0.."],
#       "E" => ["..0.", "...0", ".0.."],
#       "F" => ["..00", "..0.", ".0.."],
#       "G" => ["..00", "..00", ".0.."],
#       "H" => ["..0.", "..00", ".0.."],
#       "I" => ["...0", "..0.", ".0.."],
#       "J" => ["...0", "..00", ".0.."],
#       "K" => ["..0.", "....", ".00."],
#       "L" => ["..0.", "..0.", ".00."],
#       "M" => ["..00", "....", ".00."],
#       "N" => ["..00", "...0", ".00."],
#       "O" => ["..0.", "...0", ".00."],
#       "P" => ["..00", "..0.", ".00."],
#       "Q" => ["..00", "..00", ".00."],
#       "R" => ["..0.", "..00", ".00."],
#       "S" => ["...0", "..0.", ".00."],
#       "T" => ["...0", "..00", ".00."],
#       "U" => ["..0.", "....", ".000"],
#       "V" => ["..0.", "..0.", ".000"],
#       "W" => ["...0", "..00", ".0.0"],
#       "X" => ["..00", "....", ".000"],
#       "Y" => ["..00", "...0", ".000"],
#       "Z" => ["..0.", "...0", ".000"],