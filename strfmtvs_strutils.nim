import nimbench, strutils, strfmt

const
  year = 2016

bench(strutils, m):
  var s = ""
  for _ in 1..m:
    s = "$# $#" % ["Happy New Year", $year]
  doNotOptimizeAway(s)

bench(strfmt, m):
  var s = ""
  for _ in 1..m:
    s = "{0} {1}".fmt("Happy New Year", year)
  doNotOptimizeAway(s)

bench(strfmtwithFormat, m):
  var s = ""
  for _ in 1..m:
    s = "{0} {1:d}".fmt("Happy New Year", year)
  doNotOptimizeAway(s)


runBenchmarks()
