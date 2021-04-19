defmodule Zcashex.MixProject do
  use Mix.Project

  def project do
    [
      app: :zcashex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 3.1"}
    ]
  end
end
