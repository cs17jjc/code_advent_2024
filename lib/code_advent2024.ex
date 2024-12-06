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

  def sumOfFixedUpdatesMiddles(input) do
    {rulesMap,updates} = parseDay5Input(input)
    updates
    |> Enum.filter(fn update -> !recursiveCheck(update,[],rulesMap) end)
    |> Enum.map(fn update -> fixOrder(rulesMap,update) end)
    |> Enum.map(fn fixedUpdate -> Enum.at(fixedUpdate,round(Enum.count(fixedUpdate)/2)-1) end)
    |> Enum.sum
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


end
