import nimbench, marshal, json, jsmn

type
  Status = enum
    done, wontfix, inprogress
  Task = object
    id: int
    title: string
    done: Status
    notes: string
    tags: array[0..1, string]
    categories: seq[string]


var t1: Task
t1.id = 1
#t1.title = "Blah blah"
t1.done = wontfix
t1.tags = ["test", "blah"]
#t1.categories = @["works", "urgent"]


var js = $$t1

proc unpack(value: var string, node: JsonNode) =
  if node.kind != JNull:
    value = node.str

proc unpack(value: var int, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.int

proc unpack(value: var int8, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.int8

proc unpack(value: var int16, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.int16

proc unpack(value: var int32, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.int32

proc unpack(value: var int64, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.int64

proc unpack(value: var uint, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.uint

proc unpack(value: var uint8, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.uint8

proc unpack(value: var uint16, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.uint16

proc unpack(value: var uint32, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.uint32

proc unpack(value: var uint64, node: JsonNode) =
  if node.kind != JNull:
    value = node.num.uint64

proc unpack(value: var float, node: JsonNode) =
  value = node.fnum

proc unpack(value: var float32, node: JsonNode) =
  value = node.fnum.float32

proc unpack(value: var bool, node: JsonNode) =
  value = node.bval

proc unpack(value: var char, node: JsonNode) =
  if node.str.len > 0:
    value = node.str[0]

proc unpack*(target: var auto, json: JsonNode) {.noSideEffect.} =
  when target is array:
    if json != nil and json.kind != JNull:
      for i in 0..<json.len:
        unpack(target[i], json[i])
  elif target is seq:
    discard
    #if json != nil and json.kind != JNull:
    #  target = @[]
    #  for i in 0..<json.len:
    #    unpack(target[i], json[i])
  elif target is enum:
    #target.type
    target = cast[type(target)](json.str)
  else:
    for name, value in target.fieldPairs:
      if json[name] != nil:
        unpack(value, json[name])

bench(marshal_deserialize, m):
  var
    t: Task
  for _ in 1..m:
    t = to[Task](js)
  doNotOptimizeAway(t)

bench(unpack_deserialize, m):
  var
    t: Task
  for _ in 1..m:
    unpack(t, parseJson(js))
  doNotOptimizeAway(t)

bench(jsmn_deserialize, m):
  var
    t: Task
    tokens: array[32, JsmnToken]
  for _ in 1..m:
    discard parseJson(addr js, tokens)
    loadObject(t, tokens, js)
  doNotOptimizeAway(t)

runBenchmarks()
