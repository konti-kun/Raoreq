defmodule Raoreq.MixProject do
  use Mix.Project

  def project do
    [
      app: :elxjob,
      version: "0.1.0",
      elixir: "~> 1.7-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :timex],
      mod: {Elxjob, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
      {:cowboy, "~> 1.1.2"},
      {:plug, "~> 1.6.1"},
      {:timex, "~> 3.1"},
      {:riakc, github: "basho/riak-erlang-client"},
      {:poison, "~> 3.1"}
    ]
  end
end
