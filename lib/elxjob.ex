defmodule Elxjob do
  @moduledoc """
  Documentation for Elxjob.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Elxjob.hello
      :world

  """
  use Application
  require Logger
  import Supervisor.Spec
  
  def start(_type, _args) do
    port = Application.get_env(:elxjob, :cowboy_port, 8001)
    children = [
      supervisor(Elxjob.Supervisor, [[]]),
      Plug.Adapters.Cowboy.child_spec(:http, Elxjob.Plug.Router, [], port: port)
    ]
    Logger.info "Started application"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
