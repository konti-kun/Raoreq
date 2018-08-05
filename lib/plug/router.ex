defmodule Elxjob.Plug.Router do
  use Plug.Router
  use Plug.ErrorHandler

  plug Plug.Static, at: "/static", from: "priv/static"
  plug Plug.Parsers,
    parsers: [:json, :urlencoded, :multipart],
    pass: ["*/*"],
    json_decoder: Poison
  plug :match
  plug :dispatch

  get "/" do
    send_file(conn, 200, "priv/index.html")
  end

  match(_, do: send_resp(conn, 404, "Opps!\n"))

  def call(conn, opts) do
    conn = Plug.Conn.assign(conn, :opts, opts)
    super(conn, opts)
  end

end
