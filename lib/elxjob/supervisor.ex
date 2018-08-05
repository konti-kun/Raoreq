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
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end 

