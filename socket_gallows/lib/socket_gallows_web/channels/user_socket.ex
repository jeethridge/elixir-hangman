defmodule SocketGallowsWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "hangman:*", SocketGallowsWeb.HangmanChannel

  def connect(_params, socket, _connect_info) do
    IO.puts("User socket connection opened.")
    {:ok, socket}
  end

  def id(_socket), do: nil
end
