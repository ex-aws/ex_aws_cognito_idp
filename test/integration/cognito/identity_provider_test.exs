defmodule ExAws.Integration.Cognito.IdentityProviderTest do
  use ExUnit.Case, async: true

  alias ExAws.Cognito.IdentityProvider

  @moduletag :integration

  @pool System.get_env("AWS_COGNITO_INTEGRATION_POOL") ||
          raise("AWS_COGNITO_INTEGRATION_POOL system env required")

  describe "list_users" do
    test "request" do
      assert {:ok, %{"Users" => [_|_]}} = IdentityProvider.list_users(@pool) |> ExAws.request()
    end

    test "stream" do
      assert [%{"Attributes" => _}] = IdentityProvider.list_users(@pool) |> ExAws.stream!() |> Enum.take(1)
    end
  end
end
