#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion: 'For example, 211 is read as "one two, two ones", which becomes 1221 (1 2, 2 1s).',
    input: '211',
    expected_output: '1221',
    iterations: 1
  },
  {
    assertion: '1 becomes 11 (1 copy of digit 1).',
    input: '1',
    expected_output: '11',
    iterations: 1
  },
  {
    assertion: '11 becomes 21 (2 copies of digit 1).',
    input: '11',
    expected_output: '21',
    iterations: 1
  },
  {
    assertion: '21 becomes 1211 (one 2 followed by one 1).',
    input: '21',
    expected_output: '1211',
    iterations: 1
  },
  {
    assertion: '1211 becomes 111221 (one 1, one 2, and two 1s).',
    input: '1211',
    expected_output: '111221',
    iterations: 1
  },
  {
    assertion: '111221 becomes 312211 (three 1s, two 2s, and one 1).',
    input: '111221',
    expected_output: '312211',
    iterations: 1
  },
  {
    assertion: '1 becomes 312211 after 5 iterations.',
    input: '1',
    expected_output: '312211',
    iterations: 5
  }
]

def elves_look_and_say_naive(input, iterations)
   return input if iterations == 0

   output = ''
   chr = input[0]
   count = 1

   for i in 1..input.length
     if chr == input[i]
       count += 1
     else
       output += "#{count}#{chr}"
       count = 1
     end
     chr = input[i] unless i == input.length
   end

   puts "#{iterations}: #{input.length} -> #{output.length}"

   elves_look_and_say(output, iterations - 1)
end

def elves_look_and_say_smart(input, iterations)
  return input if iterations == 0

  grouped_by = input.scan(/((.)\2*)/)
  grouped_by_counted = grouped_by.map{ |chars,char| "#{chars.length}#{char}" }
  output = grouped_by_counted.join('')

  elves_look_and_say_smart(output, iterations - 1)
end

TESTS_PART_ONE.each { |test| fail test[:assertion] unless elves_look_and_say_smart(test[:input], test[:iterations]) == test[:expected_output] }

input = File.readlines('input')[0].chomp!

puts "Applied 40 times: #{elves_look_and_say_smart(input, 40).length}"
puts "Applied 50 times: #{elves_look_and_say_smart(input, 50).length}"
