#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion: '> delivers presents to 2 houses: one at the starting location, and one to the east.',
    steps: '>',
    gifted_houses: 2
  },
  {
    assertion: '^>v< delivers presents to 4 houses in a square, including twice to the house at his starting/ending location.',
    steps: '^>v<',
    gifted_houses: 4
  },
  {
    assertion: '^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.',
    steps: '^v^v^v^v^v',
    gifted_houses: 2
  }
]

def deliver_gifts(steps)
  x = 0
  y = 0
  gifted_houses = []
  gifted_houses << "#{x},#{y}"

  steps.each_char do |step|
    case step
    when '>'
      x += 1
    when '<'
      x -= 1
    when '^'
      y += 1
    when 'v'
      y -= 1
    end

    gifted_houses << "#{x},#{y}" unless gifted_houses.include? "#{x},#{y}"
  end

  return gifted_houses
end

TESTS_PART_ONE.each { |test| raise test[:assertion] unless (deliver_gifts(test[:steps]).size == test[:gifted_houses]) }

gifted_houses = deliver_gifts(File.read('input')).size

puts "Gifted houses: #{gifted_houses}"
