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

  @tag :skip
  test "day 3 part 1" do
    day3Path = File.cwd!()<>"/test/resources/day3.txt"
    IO.puts "d3p1 answer: #{CodeAdvent2024.findAndMultiplySum(File.read!(day3Path))}"
  end

  @tag :skip
  test "day 3 part 2" do
    day3Path = File.cwd!()<>"/test/resources/day3.txt"
    IO.puts "d3p2 answer: #{CodeAdvent2024.findAndMultiplySumWithToggle(File.read!(day3Path))}"
  end

  @tag :skip
  test "day 4 part 1" do
    day4Path = File.cwd!()<>"/test/resources/day4.txt"
    IO.puts "d4p1 answer: #{CodeAdvent2024.countXmasOccurances(File.read!(day4Path))}"
  end

  @tag :skip
  test "day 4 part 2" do
    day4Path = File.cwd!()<>"/test/resources/day4.txt"
    IO.puts "d4p2 answer: #{CodeAdvent2024.countCrossMASOccurances(File.read!(day4Path))}"
  end

  @tag :skip
  test "day 5 part 1" do
    day5Path = File.cwd!()<>"/test/resources/day5.txt"
    IO.puts "d5p1 answer: #{CodeAdvent2024.sumOfCorrectUpdateMiddles(File.read!(day5Path))}"
  end

  @tag :skip
  test "day 5 part 2" do
    day5Path = File.cwd!()<>"/test/resources/day5.txt"
    IO.puts "d5p2 answer: #{CodeAdvent2024.sumOfFixedUpdatesMiddles(File.read!(day5Path))}"
  end

  @tag :skip
  test "day 6 part 1" do
    day6Path = File.cwd!()<>"/test/resources/day6.txt"
    IO.puts "d6p1 answer: #{CodeAdvent2024.countVisitedInPath(File.read!(day6Path))}"
  end

  @tag :skip
  test "day 6 part 2" do
    day6Path = File.cwd!()<>"/test/resources/day6.txt"
    IO.puts "d6p2 answer: #{CodeAdvent2024.countNewObsThatCauseLoop(File.read!(day6Path))}"
  end

  @tag :skip
  test "day 7 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day7.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.sumOfValidEquations(File.read!(path))}"
  end

  @tag :skip
  test "day 7 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day7.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.sumOfValidEquations2(File.read!(path))}"
  end

  @tag :skip
  test "day 8 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day8.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.countAntinodesForInput(File.read!(path))}"
  end

  @tag :skip
  test "day 8 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day8.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.countAntinodesHarmonicsForInput(File.read!(path))}"
  end

  @tag :skip
  test "day 9 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day9.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.getCompactedChecksum(File.read!(path))}"
  end

  @tag :skip
  test "day 9 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day9.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.getFileCompactedChecksum(File.read!(path))}"
  end

  @tag :skip
  test "day 10 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day10.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.sumOfAllTrailheadScores(File.read!(path))}"
  end

  @tag :skip
  test "day 10 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day10.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.sumOfAllTrailRatings(File.read!(path))}"
  end

  @tag :skip
  test "day 11 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day11.txt"
    IO.puts " #{name} answer: #{Enum.count(CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(File.read!(path)),25))}"
  end

  @tag :skip
  test "day 11 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day11.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.stonesAfterNBlinks2(CodeAdvent2024.parseDay11Input(File.read!(path)),75)}"
  end

  @tag :skip
  test "day 12 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day12.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.priceRegions(CodeAdvent2024.parseDay12Input(File.read!(path)))}"
  end

  @tag :skip
  test "day 13 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day13.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.minimumTokensAllMachines(CodeAdvent2024.parseDay13Input(File.read!(path)))}"
  end

  @tag :skip
  test "day 14 part 1",%{test: name} do
    path = File.cwd!()<>"/test/resources/day14.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.safteyFactorAfterNSeconds(File.read!(path),101,103,100)}"
  end

  #@tag :skip
  test "day 14 part 2",%{test: name} do
    path = File.cwd!()<>"/test/resources/day14.txt"
    IO.puts " #{name} answer: #{CodeAdvent2024.christmassTreeFrame(File.read!(path),101,103,1)}"
  end


end
