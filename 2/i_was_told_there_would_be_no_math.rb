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

def dimensions_to_int_array(dimensions)
  l, w, h = dimensions.split('x')
  return [l.to_i, w.to_i, h.to_i]
end

def get_paper_required(dimensions)
  l, w, h = dimensions_to_int_array(dimensions)

  side_one = l * w
  side_two = w * h
  side_three = h * l
  surface_area = (side_one + side_two + side_three) * 2
  required_paper = surface_area + [side_one, side_two, side_three].min

  return required_paper
end

TESTS_PART_ONE.each { |test| raise test[:assertion] unless (get_paper_required(test[:dimensions]) == test[:required_paper]) }

TESTS_PART_TWO = [
  {
    assertion: 'A present with dimensions 2x3x4 requires 2+2+3+3 = 10 feet of ribbon to wrap the present plus 2*3*4 = 24 feet of ribbon for the bow, for a total of 34 feet.',
    dimensions: '2x3x4',
    required_ribbon: 34
  },
  {
    assertion: 'A present with dimensions 1x1x10 requires 1+1+1+1 = 4 feet of ribbon to wrap the present plus 1*1*10 = 10 feet of ribbon for the bow, for a total of 14 feet.',
    dimensions: '1x1x10',
    required_ribbon: 14
  }
]

def get_ribbon_required(dimensions)
  dim = dimensions_to_int_array(dimensions)
  dim = dim.sort

  ribbon_wrap = dim[0] * 2 + dim[1] * 2
  volume = dim[0] * dim[1] * dim[2]
  return ribbon_wrap + volume
end

TESTS_PART_TWO.each { |test| raise test[:assertion] unless (get_ribbon_required(test[:dimensions]) == test[:required_ribbon]) }

paper_required = 0
ribbon_required = 0

File.open('input').each do |dimensions|
  paper_required += get_paper_required(dimensions)
  ribbon_required += get_ribbon_required(dimensions)
end

puts "Total paper required: #{paper_required}"
puts "Total ribbon required: #{ribbon_required}"
