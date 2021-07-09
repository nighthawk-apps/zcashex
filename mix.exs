defmodule Zcashex.MixProject do
  use Mix.Project

  def project do
    [
      app: :zcashex,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env()),
      description: description(),
      package: package()
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
      {:benchee, "~> 1.0", only: :dev},
      {:ex_doc, "~> 0.14", only: :dev, runtime: false}
    ]
  end

  defp description() do
    "Zcashex - An elixir client library to interact with the JSON-RPC endpoint provided by a Zcash full node."
  end

  defp package() do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/nighthawk-apps/zcashex"}
    ]
  end
end
