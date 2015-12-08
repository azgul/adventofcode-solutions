#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion: 'A present with dimensions 2x3x4 requires 2*6 + 2*12 + 2*8 = 52 square feet of wrapping paper plus 6 square feet of slack, for a total of 58 square feet.',
    dimensions: '2x3x4',
    required_paper: 58
  },
  {
    assertion: 'A present with dimensions 1x1x10 requires 2*1 + 2*10 + 2*10 = 42 square feet of wrapping paper plus 1 square foot of slack, for a total of 43 square feet.',
    dimensions: '1x1x10',
    required_paper: 43
  }
]

def get_paper_required(dimensions)
  l, w, h = dimensions.split('x')
  l = l.to_i
  w = w.to_i
  h = h.to_i

  side_one = l * w
  side_two = w * h
  side_three = h * l
  surface_area = (side_one + side_two + side_three) * 2
  required_paper = surface_area + [side_one, side_two, side_three].min

  return required_paper
end

TESTS_PART_ONE.each { |test| raise test[:assertion] unless (get_paper_required(test[:dimensions]) == test[:required_paper]) }

paper_required = 0

File.open('input').each do |dimensions|
  paper_required += get_paper_required(dimensions)
end

puts "Total paper required: #{paper_required}"
