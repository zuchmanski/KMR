# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/test_helper")

class TestFindingRepeatingSubstring < Test::Unit::TestCase

  def setup
    @dbf_examples = {
      "banana"          => [ [98, 97, 110, 97, 110, 97], [3, 1, 4, 1, 4, 2], [4, 1, 5, 2, 6, 3], [4, 1, 5, 2, 6, 3]],
      "baba"            => [ [98, 97, 98, 97], [3, 1, 3, 2], [3, 1, 4, 2] ],
      "abaabcbacabac"   => [ [97, 98, 97, 97, 98, 99, 98, 97, 99, 97, 98, 97, 99], [2, 4, 1, 2, 5, 7, 4, 3, 6, 2, 4, 3, 8], [2, 7, 1, 4, 10, 12, 8, 5, 11, 3, 9, 6, 13],
        [2, 7, 1, 4, 10, 12, 8, 5, 11, 3, 9, 6, 13], [2, 7, 1, 4, 10, 12, 8, 5, 11, 3, 9, 6, 13] ]
    }

    @longest_repeated_substring_examples = {
      "banana" => ["an", "na"],
      "sebastian" => [],
      "ala ma kota" => ["a "],
      "aaaaaaaaaaa" => ["aaaaa"],
      "aaaa" => ["aa"],
      "ababab" => ["ab", "ba"],
      "abababa" => ["aba"],
      "zsdqwebnqwertybnqzsd" => ["zsd", "qwe", "bnq"]
    }
  end

  def test_calculating_dbf
    @dbf_examples.each do |key, value|
      assert_equal Kmr.calculate_dbf(key), value
    end
  end

  def test_finding_longest_repeated_substring
    @longest_repeated_substring_examples.each do |key, value|
      assert_equal Kmr.longest_repeated_substring(key), value
    end
  end

end