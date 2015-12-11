#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion: 'turn on 0,0 through 999,999 would turn on (or leave on) every light.',
    commands: ['turn on 0,0 through 999,999'],
    lit_lights: 1000*1000
  },
  {
    assertion: 'toggle 0,0 through 999,0 would toggle the first line of 1000 lights, turning off the ones that were on, and turning on the ones that were off.',
    commands: ['toggle 0,0 through 999,0'],
    lit_lights: 1000
  }
]

require 'matrix'

class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

def execute_command(grid, command, brightness = false)
  cmd = /[a-z]* ?[a-z]*/.match(command).to_s.strip
  from, to = command.scan(/\d+,\d+/).map { |coord| coord.split(',').map(&:to_i) }

  x1, x2 = from[0], to[0]
  y1, y2 = from[1], to[1]
  (x1..x2).each do |i|
    (y1..y2).each do |j|
      case cmd
      when 'turn on'
        grid[i, j] = 1 unless brightness
        grid[i, j] += 1 if brightness
      when 'turn off'
        grid[i, j] = 0 unless brightness
        grid[i, j] -= 1 if brightness && grid[i, j] > 0
      when 'toggle'
        is_on = grid[i, j] > 0
        grid[i, j] = 1 if !is_on && !brightness
        grid[i, j] = 0 if is_on && !brightness

        grid[i, j] += 2 if brightness
      end
    end
  end
end

def execute_commands(grid, commands, brightness = false)
  commands.each { |cmd| execute_command(grid, cmd, brightness) }

  return grid
end

$size = 1000

def count_lights(grid)
  lit_lights = 0
  for i in 0..($size - 1) do
    for j in 0..($size - 1) do
      lit_lights += grid[i, j]
    end
  end

  return lit_lights
end

TESTS_PART_ONE.each do |test|
  grid = Matrix.zero($size)
  grid_after_commands = execute_commands(grid, test[:commands])
  lit_lights = count_lights(grid_after_commands)
  fail test[:assertion] unless (lit_lights == test[:lit_lights])
end

commands = File.read('input').lines
grid = Matrix.zero($size)
lit_lights = count_lights(execute_commands(grid, commands))

puts "Lights lit: #{lit_lights}"

TESTS_PART_TWO = [
  {
    assertion: 'turn on 0,0 through 0,0 would increase the total brightness by 1.',
    commands: ['turn on 0,0 through 0,0'],
    brightness: 1
  },
  {
    assertion: 'toggle 0,0 through 999,999 would increase the total brightness by 2000000',
    commands: ['toggle 0,0 through 999,999'],
    brightness: 2000000
  }
]

TESTS_PART_TWO.each do |test|
  grid = Matrix.zero($size)
  grid_after_commands = execute_commands(grid, test[:commands], true)
  brightness = count_lights(grid_after_commands)
  fail test[:assertion] unless (brightness == test[:brightness])
end


grid = Matrix.zero($size)
brightness = count_lights(execute_commands(grid, commands, true))

puts "Brightness: #{brightness}"
