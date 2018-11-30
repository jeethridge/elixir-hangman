defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new game returns structure" do
    game = Game.new_game()
    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "game letters are lower-case ascii" do
    game = Game.new_game()
    assert game.letters
    |> Enum.map(fn(letter) -> letter =~ ~r/[a-z]/ end)
    |> Enum.reduce(fn(valid?, acc?) -> valid? && acc? end)
  end

  test "state is unchanged by make_move when :won or :lost game" do
    for state <- [ :won, :lost ] do
      game = Game.new_game() |> Map.put(:game_state, state)
      assert ^game = Game.make_move(game, nil)
    end
  end

  test "first occurence of letter is not already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
  end

  test "second occurence of letter is already used" do
    game = Game.new_game()
    game = Game.make_move(game, "x")
    assert game.game_state != :already_used
    game = Game.make_move(game, "x")
    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "w")
    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end


  test "a guessed word is a won game" do
    moves = String.codepoints("wible")
    game = Game.new_game("wibble")
    final_game = Enum.reduce(moves, game, fn (move, game) ->
      Game.make_move(game, move) end)
    assert final_game.game_state == :won
    assert final_game.turns_left == 7
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wibble")
    game = Game.make_move(game, "x")
    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "7 bad guesses loses the game" do
    moves = String.codepoints("abcdefg")
    game = Game.new_game("w")
    final_game = Enum.reduce(moves, game, fn (move, game) ->
      Game.make_move(game, move) end)
    assert final_game.game_state == :lost
    assert final_game.turns_left == 1
  end

  test "tally contains letter used" do
    moves = String.codepoints("helo")
    game = Game.new_game("helloz")
    final_game = Enum.reduce(moves, game, fn (move, game) ->
      Game.make_move(game, move) end)
    tally = Game.tally(final_game)
    assert tally.letters_guessed == "e,h,l,o"
  end
end
