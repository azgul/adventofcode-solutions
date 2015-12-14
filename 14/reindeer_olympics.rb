#!/usr/bin/env ruby

def evaluate_reindeer(speed, travel_time, resting, seconds)
  traveled_distance = 0

  while seconds > 0 do
    actual_travel_time = seconds > travel_time ? travel_time : travel_time - seconds
    traveled_distance += speed * actual_travel_time

    seconds -= actual_travel_time
    seconds -= resting
  end

  return traveled_distance
end

input = File.readlines('input')

seconds = 2503

distances_travelled = []

input.each do |line|
  strings = line.split(' ')

  name, speed, travel_time, resting = strings[0], strings[3].to_i, strings[6].to_i, strings[13].to_i
  distances_travelled << evaluate_reindeer(speed, travel_time, resting, seconds)
end

puts distances_travelled.max
