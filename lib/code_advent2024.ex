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


end
