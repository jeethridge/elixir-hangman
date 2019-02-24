defmodule SocketGallowsWeb.HangmanChannel do
  use Phoenix.Channel
  require Logger

  def join("hangman:game", _, socket) do
    game = Hangman.new_game()
    socket = assign(socket, :game, game)
    { :ok, socket }
  end

  def handle_in("tally", _, socket) do
    game = socket.assigns.game
    tally = Hangman.tally(game)
    push(socket, "tally", tally)
    {:noreply, socket}
  end

  # Default unknown event handler
  def handle_in(request, _, socket) do
    Logger.error("Unknown event: #{request} on #{socket.channel}")
    {:noreply, socket}
  end

end
