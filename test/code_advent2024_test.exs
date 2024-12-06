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
      "final" => 143

    }

    {:ok,
    day1Part1Test: day1Part1Test,
    day2Part1Test: day2Part1Test,
    day2Part2Test: day2Part2Test,
    day3Part1Test: day3Part1Test,
    day3Part2Test: day3Part2Test,
    day4Test: day4Test,
  day5Test: day5Test}
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

  test "test day 5 recursive check", context do
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

end
