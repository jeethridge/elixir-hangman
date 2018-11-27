defmodule Dictionary do
  @moduledoc """
  Dictionary for the Hangman Game.
  """
  def random_word() do
    word_list()
    |> Enum.random()
  end

  def word_list do
    "../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end