defmodule Elxjob.Executor do
  use Task

  def start_link() do
    Task.start_link(__MODULE__, excute, [])
  end

  def excute() do
    IO.puts Timex.local
    Process.sleep(30_000)
    excute()
  end
end
