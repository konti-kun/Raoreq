defmodule Elxjob.Executor do
  use Task

  def start_link() do
    IO.puts "sss"
    excute()
  end

  defp excute() do
    IO.puts Timex.local
    excute()
  end
end
