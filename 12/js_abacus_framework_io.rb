#!/usr/bin/env ruby

require 'json'

TESTS_PART_ONE = [
  {
    assertion: '[1,2,3] and {"a":2,"b":4} both have a sum of 6.',
    input: ['[1,2,3]', '{"a":2,"b":4}'],
    sum: 6
  },
  {
    assertion: '[[[3]]] and {"a":{"b":4},"c":-1} both have a sum of 3.',
    input: ['[[[3]]]', '{"a":{"b":4},"c":-1}'],
    sum: 3
  },
  {
    assertion: '{"a":[-1,1]} and [-1,{"a":1}] both have a sum of 0.',
    input: ['{"a":[-1,1]}', '[-1,{"a":1}]'],
    sum: 0
  },
  {
    assertion: '[] and {} both have a sum of 0.',
    input: ['[]', '{}'],
    sum: 0
  }
]

def sum_numbers(input, sum = 0)
  input.each { |item| sum += sum_numbers(item) } if input.is_a?(Array)
  input.each { |key, val| sum += sum_numbers(val) } if input.is_a?(Hash)
  sum += input if input.is_a?(Integer)

  return sum
end

TESTS_PART_ONE.each { |test| test[:input].each { |input| fail test[:assertion] unless sum_numbers(JSON.parse(input)) == test[:sum] } }

input = File.read('input')
sum = sum_numbers(JSON.parse(input))

puts "The sum of all the numbers in the document is: #{sum}"


TESTS_PART_TWO = [
  {
    assertion: '[1,2,3] still has a sum of 6.',
    input: '[1,2,3]',
    sum: 6
  },
  {
    assertion: '[1,{"c":"red","b":2},3] now has a sum of 4, because the middle object is ignored.',
    input: '[1,{"c":"red","b":2},3]',
    sum: 4
  },
  {
    assertion: '{"d":"red","e":[1,2,3,4],"f":5} now has a sum of 0, because the entire structure is ignored.',
    input: '{"d":"red","e":[1,2,3,4],"f":5}',
    sum: 0
  },
  {
    assertion: '[1,"red",5] has a sum of 6, because "red" in an array has no effect.',
    input: '[1,"red",5]',
    sum: 6
  }
]

def sum_numbers_except_red(input, sum = 0)
  input.each { |item| sum += sum_numbers_except_red(item) } if input.is_a?(Array)

  if input.is_a?(Hash) && !input.has_value?("red")
    input.each do |key, val|
      next if val == "red"
      sum += sum_numbers_except_red(val)
    end
  end

  sum += input if input.is_a?(Integer)

  return sum
end

TESTS_PART_TWO.each { |test| puts test[:assertion] unless sum_numbers_except_red(JSON.parse(test[:input])) == test[:sum] }

sum = sum_numbers_except_red(JSON.parse(input))

puts "Ignoring red properties, the sum of all the numbers in the document is: #{sum}"
