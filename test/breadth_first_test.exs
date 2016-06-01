defmodule BreadthFirstTest do
  use ExUnit.Case, async: true
  doctest DictionaryDash

  test "when there is no possible path, returns an error" do
    dict = ~w(cat bat mat hat foo bar cap bet)
    path = DictionaryDash.find_transformation("cat", "foo", dict)
    assert path == {:no_path, nil}
  end

  test "when the target is not in the dictionary, returns an error" do
    dict = ~w(cat)
    path = DictionaryDash.find_transformation("cat", "xxx", dict)
    assert path == {:not_in_dict, nil}
  end

  test "when the start is not in the dictionary, return an error" do
    dict = ~w(foo)
    path = DictionaryDash.find_transformation("bar", "foo", dict)
    assert path == {:not_in_dict, nil}
  end

  test "correctly finds shortest path" do
    dict = ~w(cat bat mat hat foo bar cap bet get)
    path = DictionaryDash.find_transformation("cat", "get", dict)
    assert path == {:ok, 4}
  end
end
