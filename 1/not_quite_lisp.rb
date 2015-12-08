#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {assertion: '(()) and ()() both result in floor 0.', steps: ['(())', '()()'], expected_floor: 0},
  {assertion: '((( and (()(()( both result in floor 3.', steps: ['(((', '(()(()('], expected_floor: 3},
  {assertion: '))((((( also results in floor 3.', steps: ['))((((('], expected_floor: 3},
  {assertion: '()) and ))( both result in floor -1 (the first basement level).', steps: ['())', '))('], expected_floor: -1},
  {assertion: '))) and )())()) both result in floor -3.', steps: [')))', ')())())'], expected_floor: -3}
]

STEP_DEFINITION = {'(' => 1, ')' => -1}

def take_the_elevator(steps, floor_goal = nil)
  floor = 0
  moves = 0
  steps.each_char do |chr|
    floor += STEP_DEFINITION[chr]
    moves += 1
    return moves if floor == floor_goal
  end
  floor
end

TESTS_PART_ONE.each { |test| test[:steps].each { |steps| raise test[:assertion] unless take_the_elevator(steps) == test[:expected_floor] } }

floor = take_the_elevator(File.read('input'))
puts "Santa ends up at floor #{floor}"

TESTS_PART_TWO = [
  {assertion: ') causes him to enter the basement at character position 1.', steps: [')'], expected_moves: 1},
  {assertion: '()()) causes him to enter the basement at character position 5.', steps: ['()())'], expected_moves: 5},
]

TESTS_PART_TWO.each { |test| test[:steps].each { |steps| raise test[:assertion] unless (take_the_elevator(steps, -1) == test[:expected_moves]) } }

moves = take_the_elevator(File.read('input'), -1)
puts "Santa hit -1st floor after #{moves} moves"
