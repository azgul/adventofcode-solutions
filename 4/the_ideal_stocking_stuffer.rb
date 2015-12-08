#!/usr/bin/env ruby

require 'digest'

TESTS_PART_ONE = [
  {
    assertion: 'If your secret key is abcdef, the answer is 609043, because the MD5 hash of abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest such number to do so.',
    secret: 'abcdef',
    zeroes: 5,
    answer: 609043
  },
  {
    assertion: 'If your secret key is pqrstuv, the lowest number it combines with to make an MD5 hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970 looks like 000006136ef....',
    secret: 'pqrstuv',
    zeroes: 5,
    answer: 1048970
  }
]

def find_advent_coin_hash(secret, zeroes)
  number = 1
  padding = "".rjust(zeroes, '0')
  hash = ""

  loop do
    hash = Digest::MD5.hexdigest("#{secret}#{number}")

    break if hash.start_with?(padding)
    number += 1
  end

  return {hash: hash, number: number}
end

TESTS_PART_ONE.each { |test| raise test[:assertion] unless (find_advent_coin_hash(test[:secret], test[:zeroes])[:number] == test[:answer]) }

secret = File.read('input').gsub("\n", '')

result = find_advent_coin_hash(secret, 5)
puts "#{result[:number]}: #{result[:hash]}"

result = find_advent_coin_hash(secret, 6)
puts "#{result[:number]}: #{result[:hash]}"
