import nimbench, marshal, ../jsmn.nim/jsmn

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

bench(marshal_deserialize, m):
  var
    t: Data
  for _ in 1..m:
    for js in lines("world_bank.json"):
      t = to[Data](js)
      doNotOptimizeAway(t)

bench(jsmn_deserialize, m):
  var
    t: Data
    tokens: array[1024, JsmnToken]
  for _ in 1..m:
    for js in lines("world_bank.json"):
      discard parseJson(js, tokens)
      loadObject(t, tokens, js)
      doNotOptimizeAway(t)

bench(jsmn_deserialize_dymanic_pool_size, m):
  var
    t: Data
    tokens: seq[JsmnToken]
  for _ in 1..m:
    for js in lines("world_bank.json"):
      tokens = parseJson(js)
      loadObject(t, tokens, js)
      doNotOptimizeAway(t)

runBenchmarks()
