defmodule Raoreq.Plug.Router do
  use Plug.Router
  #use Plug.ErrorHandler

  plug :match
  plug Plug.Static, at: "/static", from: "priv/static"
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["*/*"],
    json_decoder: Poison

  plug :dispatch

  get "/" do
    send_file(conn, 200, "priv/index.html")
  end

  post "/createjob" do
    jobid = conn.body_params["jobid"]
    case :riakc_pb_socket.start_link('127.0.0.1', 8087) do
      {:ok, pid} ->
        job = :riakc_obj.new("jobs", jobid, [name: "test data"])
        :riakc_pb_socket.put(pid, job)
        {:ok, obj} = :riakc_pb_socket.get(pid, "jobs", jobid)
        IO.puts inspect :riakc_obj.get_values(obj) |> hd |> :erlang.binary_to_term
    end
    send_resp(conn, 200, Poison.encode!(%{name: "aaa"}))
  end

  match(_, do: send_resp(conn, 404, "Opps!\n"))

  defp handle_errors(conn, %{kind: _kind, reason: reason, stack: _stack}) do
    IO.puts inspect reason
    send_resp(conn, conn.status, "Something went wrong")
  end

end
