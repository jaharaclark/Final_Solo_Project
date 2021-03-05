class NightWriter
  
  message = File.open("#{ARGV[0]}")
  braille = File.open("#{ARGV[1]}", 'w')
  
  # while line = message.gets do
  #     braille.write line
  # end
  characters = File.read("#{ARGV[0]}")
  count = characters.delete("\n")
  
  puts characters[0...4]
  puts "Created #{ARGV[1]} containing #{count.length} characters"
  message.close
end
