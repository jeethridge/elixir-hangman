defmodule Dictionary.WordList do

  @this __MODULE__

  def start_link() do
    Agent.start_link(&word_list/0, name: @this)
  end

  def random_word() do
    Agent.get(@this, &Enum.random/1)
  end

  def word_list() do
    "../../assets/words.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end
