defmodule AnnexRlDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :annex_rl_demo,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.6"},
      {:poison, "~> 4.0"},
      {:deque, "~> 1.2"},

      {:annex, git: "https://github.com/arpieb/annex.git", branch: "add-linear-activation", override: true},
#      {:annex, "~> 0.2.0"},
      {:annex_matrex, git: "https://github.com/elbow-jason/annex_matrex.git", tag: "360fc3e499592ca4caf6c5cded4b42bc554e86b6"},
    ]
  end
end
