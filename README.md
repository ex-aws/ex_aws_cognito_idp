# ExAws.CognitoIdp

Service module for https://github.com/ex-aws/ex_aws

## Installation

The package can be installed by adding `:ex_aws_cognito_idp` to your list of dependencies in
`mix.exs` along with `:ex_aws` and your preferred JSON codec / http client

```elixir
def deps do
  [
    {:ex_aws, "~> 2.0"},
    {:ex_aws_cognito_idp, "~> 2.0"},
    {:poison, "~> 3.0"},
    {:hackney, "~> 1.9"},
  ]
end
```

Documentation can be found at [https://hexdocs.pm/ex_aws_cognito_idp](https://hexdocs.pm/ex_aws_cognito_idp).

## Testing

To run integration tests 3 environment variables are required:
* AWS\_ACCESS\_KEY\_ID
* AWS\_SECRET\_KEY\_ACCESS
* AWS\_COGNITO\_INTEGRATION\_POOL

You can skip integration tests by running `mix test --exclude integration`
