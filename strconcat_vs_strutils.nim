import nimbench, strutils

const
  host = "google.com"
  port = 443

bench(strutils, m):
  var s = ""
  for _ in 1..m:
    s = "$#:$#" % [host, $port]
  doNotOptimizeAway(s)

bench(strconcat, m):
  var s = ""
  for _ in 1..m:
    s = host & ":" & $port
  doNotOptimizeAway(s)

runBenchmarks()
