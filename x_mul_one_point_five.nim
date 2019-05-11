import nimbench

bench(x_plus_half_float, m):
  for _ in 1..m:
    var x = 265.0
    x = x + x/2
    doNotOptimizeAway(x)

bench(x_mul_one_point_five_float, m):
  for _ in 1..m:
    var x = 265.0
    x = x * 1.5
    doNotOptimizeAway(x)

bench(x_plus_half_int, m):
  for _ in 1..m:
    var x = 265
    x = x + int(x/2)
    doNotOptimizeAway(x)

bench(x_mul_one_point_five_int, m):
  for _ in 1..m:
    var x = 265
    x = int(x.float * 1.5)
    doNotOptimizeAway(x)

runBenchmarks()