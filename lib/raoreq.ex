defmodule Raoreq do
  @moduledoc """
  Documentation for Raoreq.
  """

  use Application
  require Logger
  import Supervisor.Spec
  
  def start(_type, _args) do
    port = Application.get_env(:raoreq, :cowboy_port, 8001)
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Raoreq.Plug.Router, [], port: port),
      worker(Raoreq.Executor, [], name: Executor)
    ]
    Logger.info "Started application"

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
