import nimbench, marshal, ../sam.nim/sam, json

type
  Percent = object
    Name: string
    Percent: int
  Namecode = object
    name: string
    code: string
  Doc = object
    DocTypeDesc: string
    DocType: string
    EntityID: string
    DocURL: string
    DocDate: string
  Sector = object
    name: string
  project = object
    cdata: string
  oid = object
    oid: string

  Data = object
    iid: oid
    approvalfy: string
    board_approval_month: string
    boardapprovaldate: string
    borrower: string
    closingdate: string
    country_namecode: string
    countrycode: string
    countryname: string
    countryshortname: string
    docty: string
    envassesmentcategorycode: char
    grantamt: int
    ibrdcommamt: int
    id: string
    idacommamt: int
    impagency: string
    lendinginstr: string
    lendinginstrtype: string
    lendprojectcost: int
    majorsector_percent: seq[Percent]
    mjsector_namecode: seq[Namecode]
    mjtheme: seq[string]
    mjtheme_namecode: seq[Namecode]
    mjthemecode: string
    prodline: string
    prodlinetext: string
    productlinetype: char
    project_abstract: project
    project_name: string
    projectdocs: seq[Doc]
    projectfinancialtype: string
    projectstatusdisplay: string
    regionname: string
    sector: seq[Sector]
    sector1: Percent
    sector2: Percent
    sector3: Percent
    sector4: Percent
    sector_namecode: seq[Namecode]
    sectorcode: string
    source: string
    status: string
    supplementprojectflg: char
    theme1: Percent
    theme_namecode: seq[Namecode]
    themecode: string
    totalamt: int
    totalcommamt: int
    url: string

bench(json_parse, m):
  var
    name: string
    percent: int
  for _ in 1..m:
    for js in lines("world_bank.json"):
      var n = parseJson(js)
      name = n["majorsector_percent"][0]["Name"].str
      percent = n["majorsector_percent"][0]["Percent"].num.int
      doNotOptimizeAway(name)
      doNotOptimizeAway(percent)

bench(json_parse2, m):
  var
    name: string
    percent: int
  for _ in 1..m:
    for js in lines("world_bank.json"):
      var n = parseJson(js)["majorsector_percent"][0]
      name = n["Name"].str
      percent = n["Percent"].num.int
      doNotOptimizeAway(name)
      doNotOptimizeAway(percent)

bench(json_parse3, m):
  var
    name: string
    percent: int
  for _ in 1..m:
    for js in lines("world_bank.json"):
      var n = parseJson(js){"majorsector_percent"}[0]
      name = n["Name"].str
      percent = n["Percent"].num.int
      doNotOptimizeAway(name)
      doNotOptimizeAway(percent)


bench(sam_parse, m):
  var
    name: string
    percent: int
  for _ in 1..m:
    for js in lines("world_bank.json"):
      var n = parse(js)
      name = n["majorsector_percent"][0]["Name"].toStr()
      percent = n{1}["Percent"].toInt()
      doNotOptimizeAway(name)
      doNotOptimizeAway(percent)

bench(marshal_deserialize, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t = to[Data](js)
      doNotOptimizeAway(t)

bench(sam_deserialize_small_buffer_size_64, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t.loads(js, 64)
      doNotOptimizeAway(t)

bench(sam_deserialize_small_buffer_size_128, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t.loads(js, 128)
      doNotOptimizeAway(t)

bench(sam_deserialize_default_buffer_size_256, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t.loads(js)
      doNotOptimizeAway(t)


bench(sam_deserialize_adjustified_buffer_size_320, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t.loads(js, 320)
      doNotOptimizeAway(t)

runBenchmarks()
