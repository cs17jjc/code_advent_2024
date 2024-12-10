defmodule CodeAdvent2024 do

  #day 1
  def distanceBetweenTwoLists(a,b) do
    aSorted = Enum.sort(a)
    bSorted = Enum.sort(b)
    Enum.sum(aSorted |> Enum.zip(bSorted) |> Enum.map(fn {x,y} -> abs(x-y) end))
  end

  def similarityBetweenTwoLists(a,b) do
    #between left and right lists, for each value in left multiply by occurances in right
    #distinct values in left, number of values in left, number of values in right
    distinctA = Enum.uniq(a)
    countA = distinctA |> Enum.map(fn x -> Enum.count(a, fn y -> x == y end) end)
    countB = distinctA |> Enum.map(fn x -> Enum.count(b, fn y -> x == y end) end)

    #multiply a for counts in b, then multiply by occurances in a and sum
    Enum.zip(distinctA,countB) |> Enum.map(fn {x,y} -> x*y end) |> Enum.zip(countA) |> Enum.map(fn {x,y} -> x*y end) |> Enum.sum()

  end

  #day 2
  def determineTotalSafety(list) do
    #list contains list of numbers
    #lists should only contain numbers in ascending or descending order
    #delta between adjacent numbers should never exceed 3
    list |> Enum.count(&CodeAdvent2024.isSafe/1)
  end

  def determineTotalSafetyWithDampening(list) do
    {safe, unsafe} = list |> Enum.split_with(&CodeAdvent2024.isSafe/1)
    #now we gotta determine if there are unsafe ones that would be safe with one value removed

    #if theres >=2 offending values, then cannot be saved
    #if 1 then remove it and check safety again?

    Enum.count(safe) + Enum.count(unsafe,&CodeAdvent2024.isSafeDampening/1)


  end

  def isSafeDampening(list) do
    #identify offending values and check corrections? nah fuck that we checking every n-1 list, cbaaa to do that other thing what does this look like a perfomance intensive application to u??
    List.duplicate(list,Enum.count(list))
    |> Enum.with_index()
    |> Enum.map(fn {list,idx} -> List.delete_at(list,idx) end)
    |> Enum.map(&CodeAdvent2024.isSafe/1)
    |> Enum.any?(&Function.identity/1)

  end


  def isSafe(list) do
    #return true or false depending on if list satisfies safety criteria (true if safe)
    deltas = list |> Enum.chunk_every(2, 1, :discard) |> Enum.map(fn x -> Enum.at(x,0) - Enum.at(x,1) end)
    allLessThanFourAndNotZero = deltas |> Enum.all?(fn x -> abs(x) <= 3 and x != 0 end)
    deltasSign = deltas |> Enum.map(fn x -> x > 0 end)

    listLength = Enum.count(list) -1

    case deltasSign |> Enum.count(&Function.identity/1) do
     x when x == listLength or x == 0 -> allLessThanFourAndNotZero
      _ -> false
    end
  end

  #day 3

  #find all of the form mul(x,y) , multiply x*y for each and sum all occurances
  def findAndMultiplySum(input) do
    CodeAdvent2024.getValidMuls(input) |> Enum.map(fn x -> Enum.at(x,0) * Enum.at(x,1) end) |> Enum.sum()
  end

  def getValidMuls(input) do

    Regex.scan(~r/mul\(\d+,\d+\)/, input)
    |> List.flatten
    |> Enum.map(fn x -> List.flatten(Regex.scan(~r/\d+/,x)) |> Enum.map(&String.to_integer/1) end)
  end

  def findAndMultiplySumWithToggle(input) do
    CodeAdvent2024.getValidMulsWithToggle(input) |> Enum.map(fn x -> Enum.at(x,0) * Enum.at(x,1) end) |> Enum.sum()
  end

  def getValidMulsWithToggle(input) do
    mulDoDontStr = Regex.scan(~r/mul\(\d+,\d+\)|do\(\)|don't\(\)/, input)
    |> List.flatten
    #oh this is funny - just make new string and remove everything inbetween don't()..do() (and account for don't()..EOF)
    |> Enum.join("")
    CodeAdvent2024.getValidMuls(Regex.replace(~r/don't\(\).*?do\(\)|don't\(\).*(?:(?!do\(\)))/,mulDoDontStr,""))
  end

  #day 4

  def countXmasOccurances(input) do
    split = String.split(input, "\n", trim: true)
    lineLen = String.length(Enum.at(split,0))
    combined = Enum.join(split,"")

    regexs = ["XMAS",
    "SAMX",
    #Downwards
    "X(?=.{#{lineLen-1}}M.{#{lineLen-1}}A.{#{lineLen-1}}S)",
    "S(?=.{#{lineLen-1}}A.{#{lineLen-1}}M.{#{lineLen-1}}X)",

    #Right
    "X(?=.{#{lineLen}}M.{#{lineLen}}A.{#{lineLen}}S)",
    "S(?=.{#{lineLen}}A.{#{lineLen}}M.{#{lineLen}}X)",

    #Left
    "X(?=.{#{lineLen-2}}M.{#{lineLen-2}}A.{#{lineLen-2}}S)",
    "S(?=.{#{lineLen-2}}A.{#{lineLen-2}}M.{#{lineLen-2}}X)",

  ] |> Enum.map(&Regex.compile!/1)

  regexs |> Enum.map(fn regex -> Enum.count(Regex.scan(regex,combined) ) end) |> Enum.sum

  end

  def countCrossMASOccurances(input) do
    split = String.split(input, "\n", trim: true)
    lineLen = String.length(Enum.at(split,0))
    combined = Enum.join(split," ")
    #okay so it just so happened that this worked
    #space needed to prevent false positives when a match is found but spans a line break
    # i.e
    #...M.
    #S....
    #Without something to indicate a line break,
    #the M.S would match (obvs only if the other following chars were in right position as well)

    regexs = [
    "M(?=.S.{#{lineLen-1}}A.{#{lineLen-1}}M.S)",
    "M(?=.M.{#{lineLen-1}}A.{#{lineLen-1}}S.S)",
    "S(?=.S.{#{lineLen-1}}A.{#{lineLen-1}}M.M)",
    "S(?=.M.{#{lineLen-1}}A.{#{lineLen-1}}S.M)",
    ] |> Enum.join("|") |> Regex.compile!

    Enum.count(Regex.scan(regexs,combined))
  end


  #day 5

  def parseDay5Input(input) do
    #get rules map number -> [numbers that aren't allowed to appear before]
    #and get list of updates [[a,b,c,...],...]
    splitInput = Regex.split(~r/\n\n/s, Regex.replace(~r/\r/,input,""), trim: true)
   {createRulesMapFromPairs(Enum.at(splitInput,0)),createUpdates(Enum.at(splitInput,1))}
  end

  def createUpdates(updates) do
    Regex.split(~r/\n/,updates, trim: true) |> Enum.map(fn x -> Regex.split(~r/\,/,x) |> Enum.map(&String.to_integer/1) end)
  end

  def createRulesMapFromPairs(rules) do
    abPairs = Regex.scan(~r/(\d+)\|(\d+)/,rules, capture: :all_but_first) |> Enum.map(fn x -> Enum.map(x,&String.to_integer/1) end)

    uniqueBs = abPairs |> Enum.map(fn x -> Enum.at(x,0) end) |> Enum.uniq

    cannotBeBeforeUniqueBs = uniqueBs |> Enum.map(fn b -> Enum.filter(abPairs, fn pair -> Enum.at(pair,0) == b end) |> Enum.map(fn x -> Enum.at(x,1) end) end)

    Map.new(Enum.zip(uniqueBs,cannotBeBeforeUniqueBs))
  end

  def recursiveCheck([head | tail], acc, rulesMap) do
    rulesForCurrent = rulesMap[head]

    if rulesForCurrent == nil do
      recursiveCheck(tail,[head | acc], rulesMap)
    else
      #if any of the values in the acc are a member of the currents not before rules
      if(Enum.any?(acc,fn prev -> Enum.member?(rulesForCurrent, prev) end)) do
        false #Then it ain't correct
      else
        recursiveCheck(tail,[head | acc], rulesMap) #i guess it doesnt matter if acc is in reverse order? prooobably shouldnt be a list then if order doesnt matter but fuck it
      end
    end
  end
  def recursiveCheck([], _acc, _rulesMap) do
    true #reached end of list without breaking a rule obviously
  end

  def sumOfCorrectUpdateMiddles(input) do
    {rulesMap,updates} = parseDay5Input(input)
    #filter updates for only correct
    updates
    |> Enum.filter(fn update -> recursiveCheck(update,[],rulesMap) end)
    |> Enum.map(fn correctUpdate -> Enum.at(correctUpdate,round(Enum.count(correctUpdate)/2)-1) end)
    |> Enum.sum
  end

  def findFirstViolatingIndexes([head | tail], acc, rulesForUpdate) do
    rulesForCurrent = rulesForUpdate[head]

    if rulesForCurrent == nil do
      findFirstViolatingIndexes(tail, [head | acc], rulesForUpdate)
    else
      #need to reverse bc of the way values appened into accumulator
      idxOfRuleBreaker = Enum.find_index(Enum.reverse(acc), fn prev -> Enum.member?(rulesForCurrent,prev) end)
      if idxOfRuleBreaker == nil do
        findFirstViolatingIndexes(tail, [head | acc], rulesForUpdate)
      else
        {:found,Enum.count(acc),idxOfRuleBreaker}
      end
    end

  end
  def findFirstViolatingIndexes([], _, _) do
    {:ok, nil, nil}
  end

  def fixOrder(rulesForUpdate, update) do
    {status,index1,index2} = findFirstViolatingIndexes(update,[],rulesForUpdate)
    if status == :found do
      a = Enum.at(update,index1)
      b = Enum.at(update,index2)
      newUpdate = List.replace_at(update,index1,b) |> List.replace_at(index2,a)
      fixOrder(rulesForUpdate,newUpdate)
    else
      update
    end
  end

  def sumOfFixedUpdatesMiddles(input) do
    {rulesMap,updates} = parseDay5Input(input)
    updates
    |> Enum.filter(fn update -> !recursiveCheck(update,[],rulesMap) end)
    |> Enum.map(fn update -> fixOrder(rulesMap,update) end)
    |> Enum.map(fn fixedUpdate -> Enum.at(fixedUpdate,round(Enum.count(fixedUpdate)/2)-1) end)
    |> Enum.sum
  end

  #day 6

  def countVisitedInPath(input) do
    solveGuardPath(parseDay6Input(input))[:map] |> Enum.count(fn {_,_,_,visited} -> visited end)
  end

  def countNewObsThatCauseLoop(input) do
    data = parseDay6Input(input)
    loopCausingObstaclePositions(solveGuardPathWithDirections(%{map: data[:map], guard: data[:guard]})[:path],[],[],data[:map]) |> Enum.count
  end


  def loopCausingObstaclePositions([head | tail], prevPath, obstacleCausing, map) do
    fullPrevPath = prevPath ++ [head]
    {currentX, currentY, direction} = head

    if isTileInFrontEmpty(map, currentX,currentY,direction) && !isTileInFrontPartofPath(currentX, currentY,direction,prevPath) do
      #empty and not part of previous path
      {newObsX,newObsY,_,_} = getTileInfrontOf(map,currentX,currentY,direction)
      mapWithObstacle = setTileToObstacle(map,newObsX,newObsY)

      solvedWithObstacle = solveGuardPathWithDirections(%{map: mapWithObstacle, guard: {currentX,currentY,getNextDirection(direction)}, path: fullPrevPath })
      if solvedWithObstacle[:loops] do
        loopCausingObstaclePositions(tail,fullPrevPath,obstacleCausing ++ [{newObsX,newObsY}],map)
      else
        loopCausingObstaclePositions(tail,fullPrevPath,obstacleCausing ,map)
      end
    else
      loopCausingObstaclePositions(tail,fullPrevPath,obstacleCausing,map)
    end
  end
  def loopCausingObstaclePositions([], _, obstacleCausing, _) do
    obstacleCausing
  end

  def setTileToObstacle(map,obsX,obsY) do
    Enum.map(map,fn {x,y,char,v} -> if x == obsX && y == obsY do {x,y,"#",v} else {x,y,char,v} end end)
  end

  def isTileInFrontPartofPath(posX,posY,direction,path) do
    case direction do
      :UP -> Enum.any?(path,fn {x,y,_} -> x == posX && y == posY-1 end)
      :RIGHT -> Enum.any?(path,fn {x,y,_} -> x == posX+1 && y == posY end)
      :DOWN -> Enum.any?(path,fn {x,y,_} -> x == posX && y == posY+1 end)
      :LEFT -> Enum.any?(path,fn {x,y,_} -> x == posX-1 && y == posY end)
    end
  end

  def isTileInFrontEmpty(map,posX,posY,direction) do
    tile = getTileInfrontOf(map,posX,posY,direction)
    case tile do
      nil -> false
      {_,_,"#",_} -> false
      {_,_,".",_} -> true
    end
  end

  def getTileInfrontOf(map,posX,posY,direction) do
    case direction do
      :UP -> Enum.find(map,fn {x,y,_,_} -> x == posX && y == posY-1 end)
      :RIGHT -> Enum.find(map,fn {x,y,_,_} -> x == posX+1 && y == posY end)
      :DOWN -> Enum.find(map,fn {x,y,_,_} -> x == posX && y == posY+1 end)
      :LEFT -> Enum.find(map,fn {x,y,_,_} -> x == posX-1 && y == posY end)
    end
  end


  def parseDay6Input(input) do
    lineSplit = Regex.split(~r/\n|\n\r/,input)
    width = String.length(Enum.at(lineSplit,0))

    map = Enum.with_index(lineSplit)
    |> Enum.map(fn {line,lineY} -> {lineY, Enum.with_index(String.codepoints(line)) }end)
    |> Enum.flat_map(fn {y,xList} -> Enum.map(xList, fn {char,x} -> {x,y,char,false} end) end)

    {guardX,guardY,_,_} = Enum.find(map, fn {_,_,char,_} -> char == "^" end)

    %{guard: {guardX,guardY,:UP}, map: List.replace_at(map, guardX+guardY*width,{guardX,guardY,".",false})}
  end

  def solveGuardPath(data) do
    tilesInDirection = getTilesInDirection(data[:guard], data[:map])
    tilesInPath = Enum.take_while(tilesInDirection, fn {_,_,char,_} -> char != "#" end)

    newMap = data[:map]
    |> Enum.map(fn {x,y,char,visited} -> if Enum.member?(tilesInPath,{x,y,char,visited}) do {x,y,char,true} else {x,y,char,visited} end end)

    createNewData(data, tilesInPath == tilesInDirection, tilesInPath, newMap)
  end

  def solveGuardPathWithDirections(data) do
    tilesInDirection = getTilesInDirection(data[:guard], data[:map])
    tilesInPath = Enum.take_while(tilesInDirection, fn {_,_,char,_} -> char != "#" end)

    newMap = data[:map]
    |> Enum.map(fn {x,y,char,visited} -> if Enum.member?(tilesInPath,{x,y,char,visited}) do {x,y,char,true} else {x,y,char,visited} end end)

    #path list contains {x, y, direction of travel, if hits wall}
    {_,_,guardDir} = data[:guard]
    path = tilesInPath |> Enum.map(fn {x,y,_,_} -> {x,y,guardDir} end)

    createNewDataWithDirections(data, tilesInPath == tilesInDirection, tilesInPath, newMap, path)
  end

  def createNewData(data,isOffEdge,tilesInPath, newMap) do
    newGuard = getNewGuard(data[:guard], tilesInPath)
    if isOffEdge do
      %{guard: newGuard, map: newMap}
    else
      solveGuardPath(%{guard: newGuard, map: newMap})
    end
  end

  def createNewDataWithDirections(data,isOffEdge,tilesInPath, newMap, path) do
      newGuard = getNewGuard(data[:guard], tilesInPath)
      newPath = case data[:path] do
        nil -> path
        _ -> data[:path] ++ path
      end
      loops = Enum.uniq(newPath) != newPath
      if isOffEdge || loops do
        %{guard: newGuard, map: newMap, path: newPath, loops: loops}
      else
        solveGuardPathWithDirections(%{guard: newGuard, map: newMap, path: newPath, loops: loops})
      end
  end

  def getNewGuard(currentGuard,tilesInPath) do
    newGuardDir = getNextDirection(elem(currentGuard,2))
    furthestReachable = List.last(tilesInPath) #if cant move, then just keep same position

    case furthestReachable do
      nil -> put_elem(currentGuard,2,newGuardDir)
      {newGuardX,newGuardY,_,_} -> {newGuardX,newGuardY,newGuardDir}
   end
  end

  def getNextDirection(direction) do
    case direction do
      :UP -> :RIGHT
      :RIGHT -> :DOWN
      :DOWN -> :LEFT
      :LEFT -> :UP
   end
  end

  def getTilesInDirection(guard,map) do
    case guard do
      {guardX,guardY,:UP}-> map |> Enum.filter(fn {x,y,_,_} -> y <= guardY && x == guardX end) |> Enum.sort_by(fn {_,y,_,_} -> y end,:desc)
      {guardX,guardY,:DOWN}-> map |> Enum.filter(fn {x,y,_,_} -> y >= guardY && x == guardX end) |> Enum.sort_by(fn {_,y,_,_} -> y end,:asc)
      {guardX,guardY,:LEFT}-> map |> Enum.filter(fn {x,y,_,_} -> x <= guardX && y == guardY end) |> Enum.sort_by(fn {x,_,_,_} -> x end,:desc)
      {guardX,guardY,:RIGHT}-> map |> Enum.filter(fn {x,y,_,_} -> x >= guardX && y == guardY end) |> Enum.sort_by(fn {x,_,_,_} -> x end,:asc)
    end
  end

  #day 7

  def getNewNodes(val, node) do
    [
      node + val,
      node * val
    ]
  end

  def getNewNodes2(val, node) do
    [
      node + val,
      node * val,
      String.to_integer("#{node}#{val}")
    ]
  end

  def addToOperationsTree(val, [], _, _) do
    [val]
  end
  def addToOperationsTree(val, acc = [_|_], target, newNodeFunc) do

    acc |> Enum.flat_map(fn node -> newNodeFunc.(val, node) end)
      |> Enum.filter(fn cumulative -> cumulative <= target end)

  end

  def isPossible(target, values) do
      List.foldl(values,[], fn val,acc -> addToOperationsTree(val,acc,target,&getNewNodes/2) end) |> Enum.any?(fn cumulative -> cumulative == target end)
  end

  def isPossible2(target, values) do
    List.foldl(values,[], fn val,acc -> addToOperationsTree(val,acc,target,&getNewNodes2/2) end) |> Enum.any?(fn cumulative -> cumulative == target end)
end

  def parseDay7Input(input) do
    Regex.split(~r/\n/,Regex.replace(~r/\r/,input,""), trim: true)
    |> Enum.map(fn line -> Regex.split(~r/:/,line, trim: true) end)
    |> Enum.map(fn [target,values] -> {String.to_integer(target), Regex.split(~r/ /,values, trim: true) |> Enum.map(&String.to_integer/1) } end)
  end

  def sumOfValidEquations(input) do
    #too low so must be filtering out ones that are actually possible
    parseDay7Input(input) |> Enum.filter(fn {target,values} -> isPossible(target,values) end) |> Enum.map(fn {target,_} -> target end) |> Enum.sum
  end

  def sumOfValidEquations2(input) do
    #too low so must be filtering out ones that are actually possible
    parseDay7Input(input) |> Enum.filter(fn {target,values} -> isPossible2(target,values) end) |> Enum.map(fn {target,_} -> target end) |> Enum.sum
  end


  #day 8

  def getAntinodePositions(x1,y1,x2,y2) do
    deltaX = x1-x2
    deltaY = y1-y2
    [{x1+deltaX,y1+deltaY},{x2-deltaX,y2-deltaY}]
  end

  def getAntinodePositionsHarmonics(x1,y1,x2,y2) do
    #absolute dogshit solution
    deltaX = x1-x2
    deltaY = y1-y2
    (Enum.to_list(1..100) |> Enum.flat_map(fn r -> [{x1+deltaX*r,y1+deltaY*r},{x1-deltaX*r,y1-deltaY*r}] end)) ++ [{x1,y1}]

  end

  def getAllAntinodesFor([{x1,y1} | tail], antinodes, getAntinode) do
    newAntinodes = Enum.flat_map(tail, fn {x2,y2} -> getAntinode.(x1,y1,x2,y2) end) |> Enum.filter(fn pos -> !Enum.member?(antinodes,pos) end)
    getAllAntinodesFor(tail,antinodes ++ newAntinodes,getAntinode)
  end
  def getAllAntinodesFor([], antinodes, _) do
    antinodes
  end

  def allUniqueAntinodes(antennaPositions) do
    Enum.flat_map(antennaPositions, fn positions -> getAllAntinodesFor(positions,[],&getAntinodePositions/4) end) |> Enum.uniq
  end

  def allUniqueAntinodesHarmonics(antennaPositions) do
    Enum.flat_map(antennaPositions, fn positions -> getAllAntinodesFor(positions,[],&getAntinodePositionsHarmonics/4) end) |> Enum.uniq
  end

  def countAntinodesOnMap(map,antennaPositions) do
    allUniqueAntinodes(antennaPositions) |> Enum.count(fn {antinodeX,antinodeY} -> Enum.any?(map, fn {x,y,_} -> x == antinodeX && y == antinodeY end) end)
  end

  def countAntinodesOnMapHarmonics(map,antennaPositions) do
    allUniqueAntinodesHarmonics(antennaPositions) |> Enum.count(fn {antinodeX,antinodeY} -> Enum.any?(map, fn {x,y,_} -> x == antinodeX && y == antinodeY end) end)
  end

  def parseday8Input(input) do
    lineSplit = Regex.split(~r/\n/,Regex.replace(~r/\r/,input,""), trim: true)

    map = Enum.with_index(lineSplit)
    |> Enum.map(fn {line,lineY} -> {lineY, Enum.with_index(String.codepoints(line)) }end)
    |> Enum.flat_map(fn {y,xList} -> Enum.map(xList, fn {char,x} -> {x,y,char} end) end)

    perFreqPositions = map |> Enum.filter(fn {_,_,char} -> char != "." end )
    |> Enum.group_by(fn {_,_,char} -> char end)
    |> Map.values
    |> Enum.map(fn positions -> Enum.map(positions,fn {x,y,_} -> {x,y} end) end)


    %{map: map, perFreqAntennaPositions: perFreqPositions}

  end

  def countAntinodesForInput(input) do
    data = parseday8Input(input)
    countAntinodesOnMap(data[:map],data[:perFreqAntennaPositions])
  end
  def countAntinodesHarmonicsForInput(input) do
    data = parseday8Input(input)
    countAntinodesOnMapHarmonics(data[:map],data[:perFreqAntennaPositions])
  end


#day 9

def performBlockMoveStep(list) do

  firstWithNilIndex = Enum.find_index(list, fn l -> Enum.any?(l, fn v -> v == nil end) end)
  lastWithValueIndex  = Enum.count(list) - 1 - Enum.find_index(Enum.reverse(list), fn l -> Enum.any?(l, fn v -> v != nil end) end)

  if firstWithNilIndex >= lastWithValueIndex do
    {true,list}
  else
    firstWithNil = Enum.at(list,firstWithNilIndex)
    {fistsNils,firstValues} = Enum.split_with(firstWithNil, fn v -> v == nil end)

    lastWithValue = Enum.at(list,lastWithValueIndex)


    valuesToTake = Enum.count(fistsNils)
    {takeValues,remainValues} = Enum.split(lastWithValue,valuesToTake)

    nilsToRemain = Enum.count(takeValues)

    {remainNils,_} = Enum.split(fistsNils,Enum.count(fistsNils) - nilsToRemain)

    newFirst = firstValues ++ takeValues ++ remainNils

    if remainValues == [] do
      {false,List.delete_at(list,lastWithValueIndex) |> List.replace_at(firstWithNilIndex,newFirst)}
    else
      {false, List.replace_at(list,lastWithValueIndex,remainValues) |> List.replace_at(firstWithNilIndex,newFirst)}
    end
  end

end

def solveBlockCompacting(list) do
  {solved,list2} = performBlockMoveStep(list)
  if solved do
    list
  else
    solveBlockCompacting(list2)
  end
end

def getChecksum(list) do
  list |> Enum.with_index() |> Enum.map(fn {id,idx} -> if id == nil do 0 else id*idx end end) |> Enum.sum()
end



def parseDay9Input(input) do

  blocks = Regex.scan(~r/\d/,input) |> Enum.map(fn [v] -> String.to_integer(v) end)

  {dataBlocks, emptyBlocks} = Enum.with_index(blocks) |> Enum.split_with(fn {_,idx} -> rem(idx,2) == 0 end)

  dataBlocksLists = Enum.with_index(dataBlocks) |> Enum.map(fn {{size,idx},id} -> {idx,List.duplicate(id,size)} end)
  emptyBlocksLists = emptyBlocks |> Enum.map(fn {size,idx} -> {idx,List.duplicate(nil,size)}  end)

  Enum.sort_by(dataBlocksLists++emptyBlocksLists,fn {idx,_} -> idx end, :asc) |> Enum.map(fn {_,b} -> b end) |> Enum.filter(fn v -> v != [] end)

end

def getCompactedChecksum(input) do
  getChecksum(List.flatten(solveBlockCompacting(parseDay9Input(input))))
end

def performFileMoveStep(list) do
  lastMoveableFileIndex = Enum.find_index(Enum.reverse(list), fn {values,tried} -> !tried && Enum.all?(values,fn v -> v != nil end) end)

  if lastMoveableFileIndex == nil do
    #tried moving them all
    {true, list}
  else
    lastMoveableFileIndex = Enum.count(list) - 1 - lastMoveableFileIndex
    {lastMoveableFile,_} = Enum.at(list,lastMoveableFileIndex)


    firstEmptyLargeEnoughIndex = Enum.find_index(list, fn {values,_} -> Enum.count(values,fn v -> v == nil end) >= Enum.count(lastMoveableFile)  end)

    if firstEmptyLargeEnoughIndex == nil || firstEmptyLargeEnoughIndex > lastMoveableFileIndex do
      {false, List.replace_at(list,lastMoveableFileIndex,{lastMoveableFile,true})}
    else
      {firstEmptyLargeEnough,_} = Enum.at(list,firstEmptyLargeEnoughIndex)

      {valuesNotNilInEmpty,nilInEmpty} = Enum.split_with(firstEmptyLargeEnough, fn v -> v != nil end)

      {_,remainingNils} = Enum.split(nilInEmpty,Enum.count(lastMoveableFile))

      filledEmpty = valuesNotNilInEmpty ++ lastMoveableFile ++ remainingNils

      {false, List.replace_at(list,firstEmptyLargeEnoughIndex,{filledEmpty,Enum.count(remainingNils) == 0}) |> List.replace_at(lastMoveableFileIndex,{List.duplicate(nil,Enum.count(lastMoveableFile)),false})}

    end
  end
end

def solveFileCompacting(list) do
  {solved,list2} = performFileMoveStep(list)
  if solved do
    list
  else
    solveFileCompacting(list2)
  end
end
def getFileCompactedChecksum(input) do
  blocks = parseDay9Input(input)
  getChecksum(solveFileCompacting(blocks |> Enum.zip(List.duplicate(false,Enum.count(blocks)))) |> Enum.flat_map(fn {v,_} -> v end) )
end

#Day 10

def isAdjacent(x1,y1,x2,y2) do
  (abs(x1-x2) + abs(y1-y2) == 1)
end

def getNextPointsInPath(map, path) do
  Enum.flat_map(path, fn {x1,y1,h1} -> Enum.filter(map, fn {x2,y2,h2} -> isAdjacent(x1,y1,x2,y2) && (h2 == h1+1)  end) end)
end

def solvePathFor(map,path,ends) do
  {newEnds,nextPath} = Enum.split_with(getNextPointsInPath(map,path),fn {_,_,h} -> h == 9 end)

  if nextPath == [] do
    Enum.uniq(newEnds ++ ends)
  else
    solvePathFor(map,nextPath,newEnds ++ ends)
  end
end

def getHeadScore(map,head) do
  solvePathFor(map,[head],[]) |> Enum.count()
end

def parseDay10Input(input) do
  lineSplit = Regex.split(~r/\n/,Regex.replace(~r/\r/,input,""), trim: true)

  map = Enum.with_index(lineSplit)
  |> Enum.map(fn {line,lineY} -> {lineY, Enum.with_index(String.codepoints(line)) }end)
  |> Enum.flat_map(fn {y,xList} -> Enum.map(xList, fn {char,x} -> {x,y,String.to_integer(char)} end) end)

  heads = map |> Enum.filter(fn {_,_,height} -> height == 0 end)

  %{map: map, heads: heads}
end

def sumOfAllTrailheadScores(input) do
  %{map: map, heads: heads} = parseDay10Input(input)
  Enum.map(heads, fn h -> getHeadScore(map,h) end) |> Enum.sum()
end

end
