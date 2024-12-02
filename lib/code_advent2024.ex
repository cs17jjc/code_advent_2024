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

    case deltasSign |> Enum.count(fn x -> x end) do
     x when x == listLength or x == 0 -> allLessThanFourAndNotZero
      _ -> false
    end
  end


end
