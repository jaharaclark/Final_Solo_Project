# File.open(ARGV[0]).each do |line|
#     puts line
# end

message = File.open("#{ARGV[0]}")
braille = File.open("#{ARGV[1]}")

while line = message.gets do
    braille.write line
end
  
  puts "Created #{braille}.txt containing 256 characters"
message.close

# ruby foo.rb test_list.txt

# File.open("#{ARGV[1]}", 'w') do |braille|

#     braille.puts "Ruby"
#     braille.write "Java\n"
#     braille << "Python\n"

# end