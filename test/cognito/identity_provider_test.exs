defmodule ExAws.Cognito.IdentityProviderTest do
  use ExUnit.Case, async: true

  alias ExAws.Cognito.IdentityProvider

  test "admin_create_user" do
    opts = [
      desired_delivery_mediums: ["foo", "bar"],
      force_alias_creation: true,
      message_action: "email",
      user_attributes: [%{name: "name", value: "value"}]
    ]

    operation = IdentityProvider.admin_create_user("pool", "name", opts)

    assert {"x-amz-target", "AWSCognitoIdentityProviderService.AdminCreateUser"} in operation.headers

    assert operation.data == %{
             "DesiredDeliveryMediums" => ["foo", "bar"],
             "ForceAliasCreation" => true,
             "MessageAction" => "email",
             "UserAttributes" => [%{"Name" => "name", "Value" => "value"}],
             "UserPoolId" => "pool",
             "Username" => "name"
           }
  end
end
