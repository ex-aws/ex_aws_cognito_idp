defmodule ExAws.CognitoTest do
  use ExUnit.Case
  doctest ExAws.Cognito

  test "greets the world" do
    assert ExAws.Cognito.hello() == :world
  end
end
