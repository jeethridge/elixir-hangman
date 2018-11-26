defmodule DictionayTest do
  use ExUnit.Case
  doctest Dictionary

  test "can get a random word from the wordlist asset" do
    assert is_binary(Dictionary.random_word())
  end
end
