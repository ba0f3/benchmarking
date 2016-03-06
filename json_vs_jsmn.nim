import nimbench, marshal, ../jsmn.nim/jsmn

type
  Grade = enum
    A, B, C, D
  Student = object
    name: string
    age: int
    height: float
    weight: float
    active: bool
    class: char
    grade: Grade
    note: string

var s: Student
s.name = "John Doe"
s.age = 22
s.height = 1.76
s.weight =80.5
s.active = true
s.class = 'F'
s.grade = A


bench(jsmn_stringify, m):
  var x: string
  for _ in 1..m:
    var x = newStringOfCap(sizeof(s))
    stringify(s, x)
    doNotOptimizeAway(x)

bench(marshal_load, m):
  for _ in 1..m:
    var x = $$s
    doNotOptimizeAway(x)
