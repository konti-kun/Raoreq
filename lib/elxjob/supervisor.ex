defmodule Elxjob.Supervisor do
  use Supervisor
  require Logger

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    import Supervisor.Spec
    Logger.info "init supervisor"
    children = [
      worker(Elxjob.Executor, [], name: Executor)
    ]
    opts = [strategy: :one_for_one, restart: :permanent]
    Supervisor.start_link(children, opts)
  end
end 

