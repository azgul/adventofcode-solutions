#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion: 'ugknbfddgicrmopn is nice because it has at least three vowels (u...i...o...), a double letter (...dd...), and none of the disallowed substrings.',
    string: 'ugknbfddgicrmopn',
    nice: true
  },
  {
    assertion: 'aaa is nice because it has at least three vowels and a double letter, even though the letters used by different rules overlap.',
    string: 'aaa',
    nice: true
  },
  {
    assertion: 'jchzalrnumimnmhp is naughty because it has no double letter.',
    string: 'jchzalrnumimnmhp',
    nice: false
  },
  {
    assertion: 'haegwjzuvuyypxyu is naughty because it contains the string xy.',
    string: 'haegwjzuvuyypxyu',
    nice: false
  },
  {
    assertion: 'dvszwmarrgswjxmb is naughty because it contains only one vowel.',
    string: 'dvszwmarrgswjxmb',
    nice: false
  }
]

def is_string_nice(str)
  chars = str.chars

  vowels = 0
  ['a', 'e', 'i', 'o', 'u'].each { |chr| vowels += chars.count(chr) }

  has_repeating_letter = false
  for i in 0..(str.length - 1) do
    has_repeating_letter = true if str[i] == str[i + 1]
  end

  has_bad_substring = false
  ['ab', 'cd', 'pq', 'xy'].each { |bad_str| has_bad_substring = true if str.include?(bad_str) }

  return vowels >= 3 && has_repeating_letter && !has_bad_substring
end

TESTS_PART_ONE.each { |test| fail test[:assertion] unless is_string_nice(test[:string]) == test[:nice] }

input = File.read('input').lines
nice_strings = 0
input.each { |str| nice_strings += 1 if is_string_nice(str) }

puts "Nice strings #{nice_strings}"

TESTS_PART_TWO = [
  {
    assertion: 'qjhvhtzxzqqjkmpb is nice because is has a pair that appears twice (qj) and a letter that repeats with exactly one letter between them (zxz).',
    string: 'qjhvhtzxzqqjkmpb',
    nice: true
  },
  {
    assertion: 'xxyxx is nice because it has a pair that appears twice and a letter that repeats with one between, even though the letters used by each rule overlap.',
    string: 'xxyxx',
    nice: true
  },
  {
    assertion: 'uurcxstgmygtbstg is naughty because it has a pair (tg) but no repeat with a single letter between them.',
    string: 'uurcxstgmygtbstg',
    nice: false
  },
  {
    assertion: 'ieodomkazucvgmuy is naughty because it has a repeating letter with one between (odo), but no pair that appears twice.',
    string: 'ieodomkazucvgmuy',
    nice: false
  }
]

def is_string_really_nice(str)
  chars = str.chars

  contains_repeat_letter = false
  substring_in_remainder = false
  for i in 0..(str.length - 2) do
    pair = str.slice(i, 2)
    rest = str.slice(i + 2, str.length - i)

    contains_repeat_letter = true if str[i] == str[i + 2] && str[i] != str[i + 1]

    if (!rest.nil? && rest.include?(pair))
      substring_in_remainder = true
    end
  end

  return substring_in_remainder && contains_repeat_letter
end

TESTS_PART_TWO.each { |test| fail test[:assertion] unless is_string_really_nice(test[:string]) == test[:nice] }

input = File.read('input').lines
really_nice_strings = 0
input.each { |str| really_nice_strings += 1 if is_string_really_nice(str) }

puts "Really nice strings #{really_nice_strings}"
