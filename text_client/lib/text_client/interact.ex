defmodule TextClient.Interact do

  alias TextClient.{State, Player}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game_pid) do
    %State {
      game_service: game_pid,
      tally: Hangman.tally(game_pid)
    }
  end

end
