#!/usr/bin/env ruby

require 'uri'
require 'cgi'

TESTS_PART_ONE = [
  {
    assertion: '"" is 2 characters of code (the two double quotes), but the string contains zero characters.',
    string: '""',
    characters: 0
  },
  {
    assertion: '"abc" is 5 characters of code, but 3 characters in the string data.',
    string: '"abc"',
    characters: 3
  },
  {
    assertion: '"aaa\"aaa" is 10 characters of code, but the string itself contains six "a" characters and a single, escaped quote character, for a total of 7 characters in the string data.',
    string: '"aaa\"aaa"',
    characters: 7
  },
  {
    assertion: '"\x27" is 6 characters of code, but the string itself contains just one - an apostrophe (\'), escaped using hexadecimal notation.',
    string: '"\x27"',
    characters: 1
  }
]

UNESCAPES = {
    'a' => "\x07", 'b' => "\x08", 't' => "\x09",
    'n' => "\x0a", 'v' => "\x0b", 'f' => "\x0c",
    'r' => "\x0d", 'e' => "\x1b", "\\\\" => "\x5c",
    "\"" => "\x22", "'" => "\x27"
}

# http://stackoverflow.com/a/22090177/1435058
# A bit more bothersome than PHP's stripcslashes :-(
def unescape(str)
  # Escape all the things
  str.gsub(/\\(?:([#{UNESCAPES.keys.join}])|u([\da-fA-F]{4}))|\\0?x([\da-fA-F]{2})/) {
    if $1
      if $1 == '\\' then '\\' else UNESCAPES[$1] end
    elsif $2 # escape \u0000 unicode
      ["#$2".hex].pack('U*')
    elsif $3 # escape \0xff or \xff
      [$3].pack('H2')
    end
  }
end

TESTS_PART_ONE.each { |test| fail test[:assertion] unless (unescape(test[:string]).length - 2) == test[:characters] }

input = File.readlines('input').each { |line| line.chomp! }

chars_code = 0
chars_memory = 0

input.each do |line|
  chars_code += line.length
  chars_memory += unescape(line).length - 2
end

puts "Chars in code minus chars in memory: #{chars_code-chars_memory}"

chars_code = 0
chars_memory = 0

input.each do |line|
  chars_code += line.inspect.length
  chars_memory += line.length
end
puts "Double encoded; chars in code minus chars in memory: #{chars_code-chars_memory}"
