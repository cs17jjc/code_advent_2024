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

  @tag :skip
  test "day 2 part 1" do
    day2Path = File.cwd!()<>"/test/resources/day2.txt"
    input = File.read!(day2Path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.map(fn line -> Enum.map(line,fn x -> String.to_integer(x) end) end)
    |> IO.inspect(charlists: :as_lists)
    IO.puts "d2p1 answer: #{CodeAdvent2024.determineTotalSafety(input)}"
  end

  @tag :skip
  test "day 2 part 2" do
    day2Path = File.cwd!()<>"/test/resources/day2.txt"
    input = File.read!(day2Path)
    |> String.split("\n", trim: true)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.map(fn line -> Enum.map(line,fn x -> String.to_integer(x) end) end)
    |> IO.inspect(charlists: :as_lists)
    IO.puts "d2p2 answer: #{CodeAdvent2024.determineTotalSafetyWithDampening(input)}"
  end

  #@tag :skip
  test "day 3 part 1" do
    day3Path = File.cwd!()<>"/test/resources/day3.txt"
    IO.puts "d3p1 answer: #{CodeAdvent2024.findAndMultiplySum(File.read!(day3Path))}"
  end

end
