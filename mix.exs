defmodule Zcashex.MixProject do
  use Mix.Project

  def project do
    [
      app: :zcashex,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 3.1"},
      {:ecto, "~> 3.6"},
      {:benchee, "~> 1.0", only: :dev}
    ]
  end
end
