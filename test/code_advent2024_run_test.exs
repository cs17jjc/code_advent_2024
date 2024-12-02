defmodule CodeAdvent2024Run do
  use ExUnit.Case

  @tag :skip
  test "day 1 part 1" do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
      {a,b} = File.read!(day1Path)
      |> String.split("\n",trim: true)
      |> Enum.map(fn line ->
        [a,b] = String.split(line," ",trim: true)
        {String.to_integer(a),String.to_integer(b)}
      end)
      |> Enum.unzip()
    IO.puts "d1p1 answer: #{CodeAdvent2024.distanceBetweenTwoLists(a,b)}"
  end

  @tag :skip
  test "day 1 part 2" do
    day1Path = File.cwd!()<>"/test/resources/day1.txt"
      {a,b} = File.read!(day1Path)
      |> String.split("\n",trim: true)
      |> Enum.map(fn line ->
        [a,b] = String.split(line," ",trim: true)
        {String.to_integer(a),String.to_integer(b)}
      end)
      |> Enum.unzip()
    IO.puts "d1p2 answer: #{CodeAdvent2024.similarityBetweenTwoLists(a,b)}"
  end

end
