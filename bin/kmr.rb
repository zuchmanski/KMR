$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'kmr'

string = nil
if ARGV[0] == "-f"
  string = File.read(ARGV[1])
elsif ARGV.size == 0
  string = STDIN.read
elsif ARGV[0] =~ /^-/ || ARGV.size > 1
  STDERR.puts "usage:"
  STDERR.puts "    #{$0} (note: input comes from standard input)"
  STDERR.puts "    #{$0} string"
  STDERR.puts "    #{$0} -f filename"
  exit
else
  string = ARGV[0]
end

result = Kmr.longest_repeated_substring(string)

if result.size > 0
  puts %Q{"#{result.join(", ")}" (#{result.first.length} characters)}
else
  puts "No repeating substring"
end
