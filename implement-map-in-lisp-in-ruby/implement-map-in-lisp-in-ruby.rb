# === booleans ===
t         = ->(first, second) { first }   # true
f         = ->(first, second) { second }  # false
n         = ->() { n }                    # nil
_if       = ->(bool, consequent, alternative) { bool[consequent, alternative][] }
do_if     = ->(bool, consequent) { _if[bool, consequent, n] }
do_unless = ->(bool, consequent) { _if[bool, n, consequent] }
are_equal = ->(lhs, rhs) { lhs == rhs ? t : f } # <-- cheating here


define_singleton_method :assert do |bool|
  do_unless[bool, -> { raise }]
end

define_singleton_method :refute do |bool|
  do_if[bool, -> { raise }]
end

define_singleton_method :assert_equal do |lhs, rhs|
  assert are_equal[lhs, rhs]
end

  # tests
  assert t
  refute f

  assert _if[t, ->{t}, ->{f}]
  refute _if[f, ->{t}, ->{f}]

  assert are_equal[f, f]
  assert are_equal[t, t]
  assert are_equal[1, 1]
  refute are_equal[0, 1]
  refute are_equal[t, f]
  refute are_equal[n, f]
  refute are_equal[f, n]

  assert_equal t, do_if[t, ->{t}]
  assert_equal n, do_if[f, ->{t}]
  assert_equal n, do_unless[t, ->{t}]
  assert_equal t, do_unless[f, ->{t}]


# === numeric ===
is_zero = ->(num)  { are_equal[num, 0] }
subtract = ->(minuend, subtrahend) { minuend - subtrahend }

  # tests
  assert is_zero[0]
  assert is_zero[0.0]
  refute is_zero[1]

  assert_equal 3, subtract[4, 1]


# === lists ===
cons = ->(first, second=n) {
  # returns a lambda that will return first element if given t, rest if given f
  ->(bool) {
    _if[  bool, 
          -> { first },
          -> { second }]}}

car = ->(list) { list[t] }

cdr = ->(list) { list[f] }

is_empty = ->(list) { are_equal[list, n] }

map = ->(list, function ) {
  _if[ is_empty[list],
       -> { n },
       -> { cons[ function[car[list]],
                  map[cdr[list],
                      function]]}]}

  # tests
  assert_equal 1, car[cons[1, 2]]
  assert_equal 2, cdr[cons[1, 2]]
  assert_equal 1, car[cons[1]]
  assert_equal n, cdr[cons[1]]

  assert is_empty[n]
  refute is_empty[cons[1, n]]

  double = ->(num) { num + num }
  identity = ->(element) { element }
  one_to_five = cons[1, cons[2, cons[3, cons[4, cons[5]]]]]

  assert_equal n, map[n, identity]
  assert_equal 2, car[map[cons[1], double]]

  assert_equal  2,                 car[  map[one_to_five, double]  ]
  assert_equal  4,             car[cdr[  map[one_to_five, double]  ]]
  assert_equal  6,         car[cdr[cdr[  map[one_to_five, double]  ]]]
  assert_equal  8,     car[cdr[cdr[cdr[  map[one_to_five, double]  ]]]]
  assert_equal 10, car[cdr[cdr[cdr[cdr[  map[one_to_five, double]  ]]]]]
  assert_equal  n, cdr[cdr[cdr[cdr[cdr[  map[one_to_five, double]  ]]]]]

