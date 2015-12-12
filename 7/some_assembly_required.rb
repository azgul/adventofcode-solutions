#!/usr/bin/env ruby

TESTS_PART_ONE = [
  {
    assertion:
    "After it is run, these are the signals on the wires:
      d: 72
      e: 507
      f: 492
      g: 114
      h: 65412
      i: 65079
      x: 123
      y: 456",
      circuit: [
        '123 -> x',
        '456 -> y',
        'x AND y -> d',
        'x OR y -> e',
        'x LSHIFT 2 -> f',
        'y RSHIFT 2 -> g',
        'NOT x -> h',
        'NOT y -> i'
      ],
      signals: {
        "d" => 72,
        "e" => 507,
        "f" => 492,
        "g" => 114,
        "h" => 65412,
        "i" => 65079,
        "x" => 123,
        "y" => 456
      }
  }
]

MAGIC_NUMBER = 42*42

def GET(signals, v)
  return v.to_i if  v=~/^[0-9]*$/
  return signals[v]
end

def AND(v1, v2)
  v1 & v2
end

def OR(v1, v2)
  v1 | v2
end

def LSHIFT(v1, v2)
  v1 << v2
end

def RSHIFT(v1, v2)
  v1 >> v2
end

def NOT(v)
  0xFFFF - v
end

def evaluate_circuit(circuit)
  signals = {}

  operators = ['AND', 'OR', 'LSHIFT', 'RSHIFT', 'NOT']

  while circuit.length > 0
    circuit.each do |gate|
      signal, wire = gate.split(' -> ')
      stack = signal.split(' ')

      operator = 'GET'

      operators.each { |op| operator = op if stack.include? op }

      # remove operator from the stack
      stack -= [operator]

      v1, v2 = stack.map { |e| GET(signals, e) }
      next unless v1 && (!stack[1] || v2)

      case operator
      when 'GET'
        signals[wire] = v1
      when 'AND'
        signals[wire] = AND(v1, v2)
      when 'OR'
        signals[wire] = OR(v1, v2)
      when 'LSHIFT'
        signals[wire] = LSHIFT(v1, v2)
      when 'RSHIFT'
        signals[wire] = RSHIFT(v1, v2)
      when 'NOT'
        signals[wire] = NOT(v1)
      end

      circuit -= [gate]
    end
  end

  return signals
end

TESTS_PART_ONE.each { |test| fail test[:assertion] unless evaluate_circuit(test[:circuit]) == test[:signals] }

circuit = File.readlines('input').each { |line| line.chomp! }
signals = evaluate_circuit(circuit)

puts "The signal on wire a: #{signals["a"]}"


circuit = File.readlines('input.two').each { |line| line.chomp! }
signals = evaluate_circuit(circuit)

puts "The new signal on wire a: #{signals["a"]}"
