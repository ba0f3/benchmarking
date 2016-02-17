import nimbench, strutils

const
  host = "google.com"
  port = 443

bench(strutils, m):
  for _ in 1..m:
    var s = "$#:$#" % [host, $port]
    doNotOptimizeAway(s)

bench(strconcat, m):
  for _ in 1..m:
    var s = host & ":" & $port
    doNotOptimizeAway(s)

runBenchmarks()
