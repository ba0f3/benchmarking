import benchy
from strutils import toLowerAscii

proc predefined(s: string): string =
  result = newStringOfCap(s.len)
  for c in s:
    case c
    of 'A': result.add("_a")
    of 'B': result.add("_b")
    of 'C': result.add("_c")
    of 'D': result.add("_d")
    of 'E': result.add("_e")
    of 'F': result.add("_f")
    of 'G': result.add("_g")
    of 'H': result.add("_h")
    of 'I': result.add("_i")
    of 'J': result.add("_j")
    of 'K': result.add("_k")
    of 'L': result.add("_l")
    of 'M': result.add("_m")
    of 'N': result.add("_n")
    of 'O': result.add("_o")
    of 'P': result.add("_p")
    of 'Q': result.add("_q")
    of 'R': result.add("_r")
    of 'S': result.add("_s")
    of 'T': result.add("_t")
    of 'U': result.add("_u")
    of 'V': result.add("_v")
    of 'W': result.add("_w")
    of 'X': result.add("_x")
    of 'Y': result.add("_y")
    of 'Z': result.add("_z")
    else: result.add(c)


proc tolower(s: string): string =
  result = newStringOfCap(s.len)
  for c in s:
    case c
    of 'A'..'Z': 
      result.add('_')
      result.add(toLowerAscii c)
    else: result.add(c)


const input = "Simple benchmarking to time your code. Just put your code in a timeIt block"

timeIt "predefined":
  var s = predefined(input)
  keep(s)

timeIt "tolower":
  var s = tolower(input)
  keep(s)
