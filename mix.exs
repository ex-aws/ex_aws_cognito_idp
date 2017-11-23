defmodule ExAws.Cognito.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aws_cognito,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ex_aws, "~> 2.0"},
      {:hackney, "~> 1.9", only: [:dev, :test]},
      {:poison, ">= 1.2.0", only: [:dev, :test]},
    ]
  end
end
