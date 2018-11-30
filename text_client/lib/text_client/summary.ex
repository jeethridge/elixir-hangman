defmodule TextClient.Summary do

  def display(game = %{ tally: tally }) do
    IO.puts([
      "\n",
      "Word so far: #{ Enum.join(tally.letters, " ") }\n",
      "Gusses left: #{ tally.turns_left }\n",
      "Letters guessed so far: #{ tally.letters_guessed }",
      ])
      game
  end

end
