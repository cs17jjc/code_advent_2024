defmodule CodeAdvent2024Test do
  use ExUnit.Case

  setup do
    day1Part1Test = %{
      "a" => [3,4,2,1,3,3],
      "b" => [4,3,5,3,9,3]
    }
    day2Part1Test = [
      {[7,6,4,2,1],true},
      {[1,2,7,8,9],false},
      {[9,7,6,2,1],false},
      {[1,3,2,4,5],false},
      {[8,6,4,4,1],false},
      {[1,3,6,7,9],true},
    ]
    day2Part2Test = [
      {[7,6,4,2,1],true},
      {[1,2,7,8,9],false},
      {[9,7,6,2,1],false},
      {[1,3,2,4,5],true},
      {[8,6,4,4,1],true},
      {[1,3,6,7,9],true},
    ]

    day3Part1Test = %{
      "input" => "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))",
      "muls" => [[2,4],[5,5],[11,8],[8,5]],
      "final" => 161,
      "muls_2" => [[2,4],[8,5]],
      "final_2" => 48
    }
    day3Part2Test = %{
      "input" => "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))",
      "muls" => [[2,4],[8,5]],
      "final" => 48,
    }

    day4Test = %{
      "input" => "MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX",
      "final" => 18,
      "final2" => 9,
    }

    day5Test = %{
      "input" => "47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47",

      "correct" => [true, true, true, false, false, false],
      "final" => 143,
      "corrected" => [[97,75,47,61,53],[61,29,13],[97,75,47,29,13]],
      "final2" => 123

    }

    day6Test = %{
      "input" => "....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...",
      "final" => 41,
      "final2" => 6
    }

    day7Test = %{
      "input" => "190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20",

      "final" => 3749,
      "final2" => 11387,

    }

    day8Test = %{
      "input" => "............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............",

      "final" => 14,
      "final2" => 34
    }

    day9Test = %{
      "input" => "2333133121414131402",
      "final" => 1928,
      "final2" => 2858
    }

    day10Test =%{
      "input" => "89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732",

      "final" => 36,
      "final2" => 81
    }

    day11Test = %{
      "input" => "125 17",
      "final" => 55312
    }

    day12Test = %{
      "input" => "RRRRIICCFF
RRRRIICCCF
VVRRRCCFFF
VVRCCCJFFF
VVVVCJJCFE
VVIVCCJJEE
VVIIICJJEE
MIIIIIJJEE
MIIISIJEEE
MMMISSJEEE",
      "final" => 1930,
      "final2" => 1206
    }

    {:ok,
    day1Part1Test: day1Part1Test,
    day2Part1Test: day2Part1Test,
    day2Part2Test: day2Part2Test,
    day3Part1Test: day3Part1Test,
    day3Part2Test: day3Part2Test,
    day4Test: day4Test,
    day5Test: day5Test,
    day6Test: day6Test,
    day7Test: day7Test,
    day8Test: day8Test,
    day9Test: day9Test,
    day10Test: day10Test,
    day11Test: day11Test,
    day12Test: day12Test,
  }
  end

  test "test day 1 distance between lists", context do
    assert CodeAdvent2024.distanceBetweenTwoLists([1],[1]) == 0
    assert CodeAdvent2024.distanceBetweenTwoLists([1,2],[2,3]) == 2
    assert CodeAdvent2024.distanceBetweenTwoLists(context[:day1Part1Test]["a"],context[:day1Part1Test]["b"]) == 11
  end

  test "test day 1 similarity between lists", context do
    assert CodeAdvent2024.similarityBetweenTwoLists(context[:day1Part1Test]["a"],context[:day1Part1Test]["b"]) == 31
  end

  test "test day 2 isSafe", context do
    Enum.each(context[:day2Part1Test], fn {list,result} -> assert CodeAdvent2024.isSafe(list) == result end)
  end

  test "test day 2 total safe", context do
    testList = Enum.map(context[:day2Part1Test], fn {list,_} -> list end)
    assert CodeAdvent2024.determineTotalSafety(testList) == 2
  end

  test "test day 2 part 2 total safe", context do
    testList = Enum.map(context[:day2Part2Test], fn {list,_} -> list end)
    assert CodeAdvent2024.determineTotalSafetyWithDampening(testList) == 4
  end

  test "test day 3 part 1 get valids", context do
    assert CodeAdvent2024.getValidMuls(context[:day3Part1Test]["input"]) == context[:day3Part1Test]["muls"]
  end

  test "test day 3 part 1 total", context do
    assert CodeAdvent2024.findAndMultiplySum(context[:day3Part1Test]["input"]) == context[:day3Part1Test]["final"]
  end

  test "test day 3 part 2 get valids", context do
    assert CodeAdvent2024.getValidMulsWithToggle(context[:day3Part2Test]["input"]) == context[:day3Part2Test]["muls"]
  end

  test "test day 3 part 2 total", context do
    assert CodeAdvent2024.findAndMultiplySumWithToggle(context[:day3Part2Test]["input"]) == context[:day3Part2Test]["final"]
  end

  test "test day 4 part 1 total", context do
    assert CodeAdvent2024.countXmasOccurances(context[:day4Test]["input"]) == context[:day4Test]["final"]
  end

  test "test day 4 part 2 total", context do
    assert CodeAdvent2024.countCrossMASOccurances(context[:day4Test]["input"]) == context[:day4Test]["final2"]
  end

  test "test day 5 recursive check" do
    assert CodeAdvent2024.recursiveCheck([2,1,3],[],%{ 2 => [1]})
    assert !CodeAdvent2024.recursiveCheck([1,2,3],[],%{ 2 => [1]})

    assert CodeAdvent2024.recursiveCheck([1,2,3],[],%{ 1 => [2,3], 2 => [3]})
    assert !CodeAdvent2024.recursiveCheck([3,2,1],[],%{ 1 => [2,3], 2 => [3]})

    assert CodeAdvent2024.recursiveCheck([1,4,6,2,48,32,3],[],%{ 1 => [2,3], 2 => [3]})
    assert !CodeAdvent2024.recursiveCheck([2,35,43,3,38,13,1],[],%{ 1 => [2,3], 2 => [3]})


  end

  test "test day 5 correctness", context do
    {rulesMap,updates} = CodeAdvent2024.parseDay5Input(context[:day5Test]["input"])
    assert Enum.map(updates, fn update -> CodeAdvent2024.recursiveCheck(update,[],rulesMap) end) == context[:day5Test]["correct"]
  end

  test "test day 5 part 1", context do
    assert CodeAdvent2024.sumOfCorrectUpdateMiddles(context[:day5Test]["input"]) == context[:day5Test]["final"]
  end

  test "test day 5 find violating indexes" do
    assert CodeAdvent2024.findFirstViolatingIndexes([1,2,3],[],%{1=>[2,3],2=>[3]}) == {:ok,nil,nil}
    assert CodeAdvent2024.findFirstViolatingIndexes([2,1,3],[],%{1=>[2,3],2=>[3]}) == {:found,1,0}
    assert CodeAdvent2024.findFirstViolatingIndexes([1,3,4,2],[],%{1=>[2,3],2=>[3]}) == {:found,3,1}
  end

  test "test day 5 fix ordering", context do
    assert CodeAdvent2024.fixOrder(%{1=>[2,3],2=>[3]},[1,2,3]) == [1,2,3]
    assert CodeAdvent2024.fixOrder(%{1=>[2,3],2=>[3]},[2,1,3]) == [1,2,3]
    assert CodeAdvent2024.fixOrder(%{1=>[2,3],2=>[3]},[3,2,1]) == [1,2,3]
    assert CodeAdvent2024.fixOrder(%{1=>[2,3],2=>[3]},[3,4,5,2,7,9,1,10]) == [1,4,5,2,7,9,3,10]

    {rulesMap,updates} = CodeAdvent2024.parseDay5Input(context[:day5Test]["input"])
    assert updates
    |> Enum.filter(fn update -> !CodeAdvent2024.recursiveCheck(update,[],rulesMap) end)
    |> Enum.map(fn update -> CodeAdvent2024.fixOrder(rulesMap,update) end) == context[:day5Test]["corrected"]

  end

  test "test day 5 part 2", context do
    assert CodeAdvent2024.sumOfFixedUpdatesMiddles(context[:day5Test]["input"]) == context[:day5Test]["final2"]
  end

  test "test day 6 parse map" do
    map = ".#.\n#^#\n..."
    assert CodeAdvent2024.parseDay6Input(map) == %{
      guard: {1, 1, :UP},
      map: [
        {0, 0, ".", false},
        {1, 0, "#", false},
        {2, 0, ".", false},
        {0, 1, "#", false},
        {1, 1, ".", false},
        {2, 1, "#", false},
        {0, 2, ".", false},
        {1, 2, ".", false},
        {2, 2, ".", false}
      ]
    }
  end

  test "test day 6 tiles in direction" do
    guard = {1,3,:UP}
    map = [{1,0,"#",false},{1,1,".",false},{1,2,".",false},{1,3,".",false},{1,4,".",false},{1,5,".",false}]
    assert CodeAdvent2024.getTilesInDirection(guard,map) == [{1,3,".",false},{1, 2, ".", false}, {1, 1, ".", false}, {1, 0, "#", false}]
  end

  test "test day 6 solve path" do
    guard = {1,3,:UP}
    map = [{1,0,".",false},{1,1,".",false},{1,2,".",false},{1,3,".",false},{1,4,".",false},{1,5,".",false}]
    assert CodeAdvent2024.solveGuardPath(%{guard: guard, map: map})[:map] == [{1,0,".",true},{1,1,".",true},{1,2,".",true},{1,3,".",true},{1,4,".",false},{1,5,".",false}]

    map = [
    {1,0,"#",false},{1,1,".",false},{1,2,".",false},{1,3,".",false},{1,4,".",false},{1,5,".",false},
    {2,0,".",false},{2,1,".",false},{2,2,".",false},{2,3,".",false},{2,4,".",false},{2,5,".",false}]

    assert CodeAdvent2024.solveGuardPath(%{guard: guard, map: map})[:map] == [
      {1,0,"#",false},{1,1,".",true},{1,2,".",true},{1,3,".",true},{1,4,".",false},{1,5,".",false},
      {2,0,".",false},{2,1,".",true},{2,2,".",false},{2,3,".",false},{2,4,".",false},{2,5,".",false}]


    guard = {2,2,:UP}
    map = [
      {2,0,"#",false},{2,1,".",false},{2,2,".",false},{2,3,".",false},{2,4,".",false},{2,5,".",false},
      {3,0,".",false},{3,1,"#",false},{3,2,".",false},{3,3,".",false},{3,4,".",false},{3,5,".",false},]

    assert CodeAdvent2024.solveGuardPath(%{guard: guard, map: map})[:map] == [
      {2,0,"#",false},{2,1,".",true},{2,2,".",true},{2,3,".",true},{2,4,".",true},{2,5,".",true},
      {3,0,".",false},{3,1,"#",false},{3,2,".",false},{3,3,".",false},{3,4,".",false},{3,5,".",false},]
  end

  test "test day 6 total", context do
    assert CodeAdvent2024.countVisitedInPath(context[:day6Test]["input"]) == context[:day6Test]["final"]
  end

  test "test day 6 part 2 get path" do
    guard = {2,0,:LEFT}
    map = [{0,0,".",false},{1,0,".",false},{2,0,".",false},{3,0,".",false},{4,0,".",false},{5,0,".",false}]

    assert CodeAdvent2024.solveGuardPathWithDirections(%{guard: guard, map: map})[:path] == [
      {2,0,:LEFT},{1,0,:LEFT},{0,0,:LEFT}
    ]

    map = [{0,0,"#",false},{1,0,".",false},{2,0,".",false},{3,0,".",false},{4,0,".",false},{5,0,".",false}]

    assert CodeAdvent2024.solveGuardPathWithDirections(%{guard: guard, map: map})[:path] == [
      {2,0,:LEFT},{1,0,:LEFT},{1,0,:UP}
    ]

    guard = {4,2,:LEFT}
    map = [
      {0,0,".",false},{1,0,"#",false},{2,0,".",false},{3,0,".",false},{4,0,".",false},{5,0,".",false},
      {0,1,".",false},{1,1,".",false},{2,1,".",false},{3,1,".",false},{4,1,".",false},{5,1,"#",false},
      {0,2,"#",false},{1,2,".",false},{2,2,".",false},{3,2,".",false},{4,2,".",false},{5,2,".",false},
      {0,3,".",false},{1,3,".",false},{2,3,".",false},{3,3,".",false},{4,3,".",false},{5,3,".",false},
    ]

    assert CodeAdvent2024.solveGuardPathWithDirections(%{guard: guard, map: map})[:path] == [
      {4, 2, :LEFT,},{3, 2, :LEFT,},{2, 2, :LEFT,},{1, 2, :LEFT,},{1, 2, :UP,},{1, 1, :UP,},{1, 1, :RIGHT},
      {2, 1, :RIGHT},{3, 1, :RIGHT},{4, 1, :RIGHT},{4, 1, :DOWN},{4, 2, :DOWN},{4, 3, :DOWN}
    ]

  end

  test "test day 6 part 2 does path loop" do
    guard = {4,2,:LEFT}
    map = [
      {0,0,".",false},{1,0,"#",false},{2,0,".",false},{3,0,".",false},{4,0,".",false},{5,0,".",false},
      {0,1,".",false},{1,1,".",false},{2,1,".",false},{3,1,".",false},{4,1,".",false},{5,1,"#",false},
      {0,2,"#",false},{1,2,".",false},{2,2,".",false},{3,2,".",false},{4,2,".",false},{5,2,".",false},
      {0,3,".",false},{1,3,".",false},{2,3,".",false},{3,3,".",false},{4,3,"#",false},{5,3,".",false},
    ]

    assert CodeAdvent2024.solveGuardPathWithDirections(%{guard: guard, map: map})[:loops]
  end

  test "test day 6 part 2 total", context do
    assert CodeAdvent2024.countNewObsThatCauseLoop(context[:day6Test]["input"]) == context[:day6Test]["final2"]
  end

  test "test day 7 parse input" do
    input = "190: 10 19"
    assert CodeAdvent2024.parseDay7Input(input) == [{190,[10,19]}]
  end

  test "test day 7 part 1 final", context do
    assert CodeAdvent2024.sumOfValidEquations(context[:day7Test]["input"]) == context[:day7Test]["final"]
  end

  test "test day 7 part 2 final", context do
    assert CodeAdvent2024.sumOfValidEquations2(context[:day7Test]["input"]) == context[:day7Test]["final2"]
  end

  test "test day 8 parse input" do
    input = "...
o.a
..."
    assert CodeAdvent2024.parseday8Input(input) == %{
      perFreqAntennaPositions: [[{2, 1}], [{0, 1}]],
      map: [{0, 0, "."}, {1, 0, "."}, {2, 0, "."}, {0, 1, "o"}, {1, 1, "."}, {2, 1, "a"}, {0, 2, "."}, {1, 2, "."}, {2, 2, "."}]
    }
  end

  test "test day 8 get antinode positions" do
    assert CodeAdvent2024.getAntinodePositions(2,1,2,2) == [{2, 0}, {2, 3}]
    assert CodeAdvent2024.getAntinodePositions(1,1,2,2) == [{0, 0}, {3, 3}]

    assert CodeAdvent2024.getAntinodePositions(5,2,7,3) == [{3, 1}, {9, 4}]


    antennaPositions = [{4,3},{8,4},{5,5}]
    assert CodeAdvent2024.getAllAntinodesFor(antennaPositions,[],&CodeAdvent2024.getAntinodePositions/4) == [{0, 2}, {12, 5}, {3, 1}, {6, 7}, {11, 3}, {2, 6}]
  end

  test "test day 8 part 1 final", context do
    assert CodeAdvent2024.countAntinodesForInput(context[:day8Test]["input"]) == context[:day8Test]["final"]
  end

  test "test day 8 part 2 final", context do
    assert CodeAdvent2024.countAntinodesHarmonicsForInput(context[:day8Test]["input"]) == context[:day8Test]["final2"]
  end

  test "test day 9 parse input" do
    assert CodeAdvent2024.parseDay9Input("12345") == [[0], [nil, nil], [1, 1, 1], [nil, nil, nil, nil], [2, 2, 2, 2, 2]]
  end

  test "test day 9 solver" do
    assert CodeAdvent2024.performBlockMoveStep([[0], [nil, nil], [1, 1, 1], [nil, nil, nil, nil], [2, 2, 2, 2]]) == {false, [[0], [2, 2], [1, 1, 1], [nil, nil, nil, nil], [2, 2]]}
    assert CodeAdvent2024.performBlockMoveStep([[0], [2, nil], [1, 1, 1], [nil, nil, nil, nil], [3, 3, 3, 3]]) == {false, [[0], [2, 3], [1, 1, 1], [nil, nil, nil, nil], [3, 3, 3]]}
    assert CodeAdvent2024.performBlockMoveStep([[0], [2, 3], [1, 1, 1], [nil, nil, nil, nil], [3, 3, 3]]) == {false, [[0], [2, 3], [1, 1, 1], [3, 3, 3, nil]]}


    assert CodeAdvent2024.performBlockMoveStep([[0], [2, 3], [1, 1, 1], [3, 3, 3, nil]]) == {true, [[0], [2, 3], [1, 1, 1], [3, 3, 3, nil]]}

    assert CodeAdvent2024.solveBlockCompacting([[0], [nil, nil], [1, 1, 1], [nil, nil, nil, nil], [2, 2, 2, 2]]) == [[0], [2, 2], [1, 1, 1], [2, 2, nil, nil]]
    assert CodeAdvent2024.solveBlockCompacting([[0], [2, nil], [1, 1, 1], [nil, nil, nil, nil], [3, 3, 3, 3]]) == [[0], [2, 3], [1, 1, 1], [3, 3, 3, nil]]

  end

  test "test day 9 checksum" do
    assert CodeAdvent2024.getChecksum([0,2, 2,1, 1, 1 ,2, 2, nil, nil]) == 44
  end

  test "test day 9 part 1 final", context do
    assert CodeAdvent2024.getCompactedChecksum(context[:day9Test]["input"]) == context[:day9Test]["final"]
  end

  test "test day 9 part 2 solver" do
    assert CodeAdvent2024.performFileMoveStep([{[0],false}, {[2, nil, nil,nil],false}, {[1, 1, 1],false}, {[nil, nil, nil, nil],false}, {[3],false}]) == {false, [{[0], false}, {[2, 3, nil, nil], false}, {[1, 1, 1], false}, {[nil, nil, nil, nil], false}, {[nil], false}]}

    assert CodeAdvent2024.performFileMoveStep([{[0],false}, {[nil, nil, nil,nil],false}, {[1, 1],false}, {[2],false}, {[3],false}]) == {false, [{[0], false}, {[3, nil, nil, nil], false}, {[1, 1], false}, {[2], false}, {[nil], false}]}

    assert CodeAdvent2024.performFileMoveStep([{[0],false}, {[1, 1, 2,3],true}, {[nil],false}, {[nil],false}, {[nil],false}]) == {false, [{[0], true}, {[1, 1, 2, 3], true}, {[nil], false}, {[nil], false}, {[nil], false}]}
    assert CodeAdvent2024.performFileMoveStep([{[0],true}, {[1, 1, 2,3],true}, {[nil],false}, {[nil],false}, {[nil],false}]) == {true, [{[0], true}, {[1, 1, 2, 3], true}, {[nil], false}, {[nil], false}, {[nil], false}]}

    assert CodeAdvent2024.performFileMoveStep([{[0],false},{[nil,nil],false},{[2,2],false}]) == {false, [{[0], false}, {[2, 2], true}, {[nil, nil], false}]}
    assert CodeAdvent2024.performFileMoveStep([{[0], false}, {[2, 2], true}, {[nil, nil], false}]) == {false, [{[0], true}, {[2, 2], true}, {[nil, nil], false}]}
    assert CodeAdvent2024.performFileMoveStep([{[0], true}, {[2, 2], true}, {[nil, nil], false}]) == {true, [{[0], true}, {[2, 2], true}, {[nil, nil], false}]}

    assert CodeAdvent2024.solveFileCompacting([{[0],false},{[nil,nil],false},{[2,2],false}]) == [{[0], true}, {[2, 2], true}, {[nil, nil], false}]

    assert CodeAdvent2024.solveFileCompacting([{[0],false},{[nil,nil],false},{[2],false},{[3],false}]) == [{[0], true}, {[3, 2], true}, {[nil], false}, {[nil], false}]

  end

  test "test day 9 part 2 final", context do
    assert CodeAdvent2024.getFileCompactedChecksum(context[:day9Test]["input"]) == context[:day9Test]["final2"]
  end

  test "test day 10 parse input" do
    assert CodeAdvent2024.parseDay10Input("012\n543\n678") == %{
      map: [{0, 0, 0},{1, 0, 1},{2, 0, 2},{0, 1, 5},{1, 1, 4},{2, 1, 3},{0, 2, 6},{1, 2, 7},{2, 2, 8}],
      heads: [{0, 0, 0}]
    }
  end

  test "test day 10 part 1 whatever" do
    map = [
      {0,0,0},{1,0,0},{2,0,0},
      {0,1,0},{1,1,0},{2,1,1},
      {0,2,0},{1,2,1},{2,2,0},
    ]
    assert CodeAdvent2024.getNextPointsInPath(map,[{1,1,0}]) == [{2, 1, 1}, {1, 2, 1}]

    map = [
      {0,0,0},{1,0,0},{2,0,0},
      {0,1,0},{1,1,8},{2,1,9},
      {0,2,0},{1,2,0},{2,2,0},
    ]
    assert CodeAdvent2024.getNextPointsInPath(map,[{1,1,8}]) == [{2,1,9}]

    map = [
      {0,0,1},{1,0,2},{2,0,3},
      {0,1,6},{1,1,5},{2,1,4},
      {0,2,7},{1,2,8},{2,2,9},
      {0,3,8},{1,3,9},{2,3,7},
    ]
    assert CodeAdvent2024.isAdjacent(0,3,2,2) == false
    assert CodeAdvent2024.getNextPointsInPath(map,[{1, 2, 8}, {0, 3, 8}]) == [{2, 2, 9}, {1, 3, 9}]
    assert CodeAdvent2024.solvePathFor(map,[{0,0,1}],[]) == [{2, 2, 9}, {1, 3, 9}]
  end

  test "test day 10 part 1 final", context do
    assert CodeAdvent2024.sumOfAllTrailheadScores(context[:day10Test]["input"]) == context[:day10Test]["final"]
  end

  test "test day 10 part 2 next points" do
    map = [
      {0,0,1},{1,0,2},{2,0,3},
      {0,1,6},{1,1,5},{2,1,4},
      {0,2,7},{1,2,8},{2,2,9},
      {0,3,8},{1,3,9},{2,3,7},
    ]
    assert CodeAdvent2024.getNextPointsInPathBacktracking(map,[{0,0,1,nil}]) == [{1, 0, 2, 0}]
    assert CodeAdvent2024.getNextPointsInPathBacktracking(map,[{1,2,8,nil},{0,3,8,nil}]) == [{2, 2, 9, 0}, {1, 3, 9, 0}, {1, 3, 9, 1}]

  end

  test "test day 10 part 2 solve", context do
    assert CodeAdvent2024.solveRatingFor(CodeAdvent2024.parseDay10Input(context[:day10Test]["input"])[:map],[[{2,0,0,nil}]]) == 20
    assert CodeAdvent2024.solveRatingFor(CodeAdvent2024.parseDay10Input(context[:day10Test]["input"])[:map],[[{4,0,0,nil}]]) == 24

  end

  test "test day 10 part 2 final", context do
    assert CodeAdvent2024.sumOfAllTrailRatings(context[:day10Test]["input"]) == context[:day10Test]["final2"]
  end

  test "day 11 part 1 next number" do
    assert CodeAdvent2024.nextNumber(0) == [1]
    assert CodeAdvent2024.nextNumber(1) == [2024]
    assert CodeAdvent2024.nextNumber(10) == [1,0]

  end

  test "day 11 part 1 stones after n blinks", context do
    assert CodeAdvent2024.stonesAfterNBlinks([0,1,10,99,999],1) == [1,2024,1,0,9,9,2021976]

    assert CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),1) == [253000,1,7]
    assert CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),2) == [253, 0, 2024, 14168]
    assert CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),6) == [2097446912, 14168, 4048, 2, 0, 2, 4, 40, 48, 2024, 40, 48, 80, 96, 2, 8, 6, 7, 6, 0, 3, 2]

  end

  test "day 11 part 1 final", context do
    assert Enum.count(CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),6)) == 22
    assert Enum.count(CodeAdvent2024.stonesAfterNBlinks(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),25)) == 55312
  end

  test "day 11 part 2 final", context do
    assert CodeAdvent2024.stonesAfterNBlinks2(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),6) == 22
    assert CodeAdvent2024.stonesAfterNBlinks2(CodeAdvent2024.parseDay11Input(context[:day11Test]["input"]),25) == 55312
  end


  test "test day 12 part 1 group stats" do
    assert CodeAdvent2024.groupsStats([{2, 3, "A"}, {1, 3, "A"}, {0, 3, "A"}]) == {3, 8}
    assert CodeAdvent2024.groupsStats([{3, 0, "A"}, {2, 0, "A"}, {1, 0, "A"}, {0, 0, "A"}]) == {4, 10}
    assert CodeAdvent2024.groupsStats([{1, 2, "B"}, {0, 2, "B"}, {1, 1, "B"}, {0, 1, "B"}]) == {4, 8}
    assert CodeAdvent2024.groupsStats([{3, 3, "C"}, {3, 2, "C"}, {2, 2, "C"}, {2, 1, "C"}]) == {4, 10}
    assert CodeAdvent2024.groupsStats([{3, 1, "D"}]) == {1, 4}
  end

  test "test day 12 part 1 pricing" do
    map = "AAAA
BBCD
BBCC
EEEC"
    assert CodeAdvent2024.priceRegions(CodeAdvent2024.parseDay12Input(map)) == 140
    map = "OOOOO
OXOXO
OOOOO
OXOXO
OOOOO"
    assert CodeAdvent2024.priceRegions(CodeAdvent2024.parseDay12Input(map)) == 772
  end


  test "test day 12 part 1 final", context do
    assert CodeAdvent2024.priceRegions(CodeAdvent2024.parseDay12Input(context[:day12Test]["input"])) == context[:day12Test]["final"]
  end

  @tag :skip
  test "test day 12 part 2 final", context do
    assert CodeAdvent2024.priceRegionsSides(CodeAdvent2024.parseDay12Input(context[:day12Test]["input"])) == context[:day12Test]["final2"]
  end

end
