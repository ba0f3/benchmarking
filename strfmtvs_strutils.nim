import nimbench, strutils, strfmt

const
  year = 2016

bench(strutils, m):
  for _ in 1..m:
    var s = "$# $#" % ["Happy New Year", $year]
    doNotOptimizeAway(s)

bench(strfmt, m):
  for _ in 1..m:
    var s = "{0} {1}".fmt("Happy New Year", year)
    doNotOptimizeAway(s)

bench(strfmtwithFormat, m):
  for _ in 1..m:
    var s = "{0} {1:d}".fmt("Happy New Year", year)
    doNotOptimizeAway(s)


runBenchmarks()
