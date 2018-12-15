defmodule Dictionary.Application do

  use Application
  alias Dictionary.WordList

  def start(_type, _args) do 
    import Supervisor
    children = [
      %{
        id: WordList, 
        start: {WordList, :start_link, []}
      }
    ]
    options = [
      name: Dictionary.Supervisor,
      strategy: :one_for_one,
    ]
    Supervisor.start_link(children, options)
  end

end
