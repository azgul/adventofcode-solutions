#!/usr/bin/env ruby

require 'awesome_print'

TESTS_PART_ONE = [
  {
    assertion: 'The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.',
    distances: [
      'London to Dublin = 464',
      'London to Belfast = 518',
      'Dublin to Belfast = 141'
    ],
    shortest: 605
  }
]

def travelling_santa(distances)
  distance_map = {}

  distances.each do |d|
    cities, distance = d.split(' = ')
    from, to = cities.split(' to ')
    distance = distance.to_i

    distance_map[from] = {"#{to}" => distance} unless distance_map.key? from
    distance_map[to] = {"#{from}" => distance} unless distance_map.key? to

    distance_map[from][to] = distance if distance_map.key? from
    distance_map[to][from] = distance if distance_map.key? to
  end

  paths = distance_map.keys.permutation.to_a

  best_route = ''
  best_distance = 999999

  paths.each do |path|
    distance = 0
    for i in 0..(path.length-2) do
      distance += distance_map[path[i]][path[i+1]]
    end

    if distance < best_distance
      best_route = "#{path.join(' -> ')} = #{distance}"
      best_distance = distance
    end
  end

  return {distance: best_distance, route: best_route}
end

TESTS_PART_ONE.each { |test| fail test[:assertion] unless travelling_santa(test[:distances])[:distance] == test[:shortest] }

input = File.readlines('input')

best_candidate = travelling_santa(input)
puts "Shortest route: #{best_candidate[:route]}"
