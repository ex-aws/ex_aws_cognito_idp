defmodule ExAws.Cognito.IdentityProvider do
  @moduledoc """
  AWS Cognito Identity Provider
  """

  import ExAws.Utils, only: [camelize_keys: 1, camelize_keys: 2]

  @namespace "AWSCognitoIdentityProviderService"

  @type user_pool_id :: String.t()
  @type username :: String.t()
  @type op :: ExAws.Operation.JSON.t()
  @type attribute :: %{name: String.t(), value: String.t()}

  @doc """
  Adds additional user attributes to the user pool schema.
  """
  @spec add_custom_attributes(user_pool_id, custom_attributes :: list) :: op
  def add_custom_attributes(user_pool_id, custom_attributes) do
    attributes = camelize_keys(custom_attributes, deep: true)
    data = %{"UserPoolId" => user_pool_id, "CustomAttributes" => attributes}

    request("AddCustomAttributes", data)
  end

  @doc """
  Adds the specified user to the specified group.

  Requires developer credentials.
  """
  @spec admin_add_user_to_group(user_pool_id, username, group_name :: String.t()) :: op
  def admin_add_user_to_group(user_pool_id, username, group_name) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username, "GroupName" => group_name}

    request("AdminAddUserToGroup", data)
  end

  @doc """
  Confirms user registration as an admin without using a confirmation code. Works on any user.

  Requires developer credentials.
  """
  @spec admin_confirm_sign_up(user_pool_id, username) :: op
  def admin_confirm_sign_up(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminConfirmSignUp", data)
  end

  @type admin_create_user_opts :: [
          desired_delivery_mediums: [String.t()],
          force_alias_creation: boolean,
          message_action: String.t(),
          tempory_password: String.t(),
          user_attributes: [attribute],
          validation_data: [attribute]
        ]

  @doc """
  Creates a new user in the specified user pool and sends a welcome
  message via email or phone (SMS). This message is based on a
  template that you configured in your call to `create_user_pool`
  or `update_user_pool`. This template includes your custom sign-up
  instructions and placeholders for user name and temporary password.

  Requires developer credentials.
  """
  @spec admin_create_user(user_pool_id, username, admin_create_user_opts) :: op
  def admin_create_user(user_pool_id, username, opts \\ []) do
    data =
      opts
      |> Enum.into(%{user_pool_id: user_pool_id, username: username})
      |> camelize_keys(deep: true)

    request("AdminCreateUser", data)
  end

  @doc """
  Deletes a user as an administrator. Works on any user.

  Requires developer credentials.
  """
  @spec admin_delete_user(user_pool_id, username) :: op
  def admin_delete_user(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminDeleteUser", data)
  end

  @doc """
  Deletes the user attributes in a user pool as an administrator. Works on any user.

  Requires developer credentials.
  """
  @spec admin_delete_user_attributes(user_pool_id, username, attributes :: [String.t()]) :: op
  def admin_delete_user_attributes(user_pool_id, username, attributes) do
    data = %{
      "UserPoolId" => user_pool_id,
      "Username" => username,
      "UserAttributeNames" => attributes
    }

    request("AdminDeleteUserAttributes", data)
  end

  @doc """
  Disables the user from signing in with the specified external (SAML or social) identity provider.

  This action is enabled only for admin access and requires developer credentials.
  """
  @spec admin_disable_provider_for_user(
          user_pool_id,
          provider_name :: String.t(),
          provider_attribute_name :: String.t(),
          provider_attribute_value :: String.t()
        ) :: op
  def admin_disable_provider_for_user(
        user_pool_id,
        provider_name,
        provider_attribute_name,
        provider_attribute_value
      ) do
    data = %{
      "UserPoolId" => user_pool_id,
      "User" => %{
        "ProviderAttributeNmae" => provider_attribute_name,
        "ProviderAttributeValue" => provider_attribute_value,
        "ProviderName" => provider_name
      }
    }

    request("AdminDisableProviderForUser", data)
  end

  @doc """
  Disables the specified user as an administrator. Works on any user.

  Requires developer credentials.
  """
  @spec admin_disable_user(user_pool_id, username) :: op
  def admin_disable_user(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminDisableUser", data)
  end

  @doc """
  Enables the specified user as an administrator. Works on any user.

  Requires developer credentials.
  """

  @spec admin_enable_user(user_pool_id, username) :: op
  def admin_enable_user(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminEnableUser", data)
  end

  @doc """
  Forgets the device, as an administrator.

  Requires developer credentials.
  """
  @spec admin_forget_device(user_pool_id, username, device_key :: String.t()) :: op
  def admin_forget_device(user_pool_id, username, device_key) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username, "DeviceKey" => device_key}

    request("AdminForgetDevice", data)
  end

  @doc """
  Forgets the device, as an administrator.

  Requires developer credentials.
  """
  @spec admin_get_device(user_pool_id, username, device_key :: String.t()) :: op
  def admin_get_device(user_pool_id, username, device_key) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username, "DeviceKey" => device_key}

    request("AdminGetDevice", data)
  end

  @doc """
  Gets the specified user by user name in a user pool as an administrator. Works on any user.

  Requires developer credentials.
  """
  @spec admin_get_user(user_pool_id, username) :: op
  def admin_get_user(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminGetUser", data)
  end

  @type admin_initiate_auth_opts :: [
          analytics_metadata: %{analytics_endpoint_id: String.t()},
          auth_parameters: %{String.t() => String.t()},
          client_metadata: %{String.t() => String.t()}
        ]

  @doc """
  Initiates the authentication flow, as an administrator.

  Requires developer credentials.
  """

  @spec admin_initiate_auth(
          user_pool_id,
          client_id :: String.t(),
          auth_flow :: String.t(),
          admin_initiate_auth_opts
        ) :: op
  def admin_initiate_auth(user_pool_id, client_id, auth_flow, opts \\ []) do
    data =
      opts
      |> Enum.into(%{user_pool_id: user_pool_id, client_id: client_id, auth_flow: auth_flow})
      |> camelize_keys(deep: true)

    request("AdminInitiateAuth", data)
  end

  # TODO: admin_link_provider_for_user

  @doc """
  Lists devices, as an administrator.

  Requires developer credentials.

  Can be used with `ExAws.stream!/2` to get all results.
  """
  @spec admin_list_devices(user_pool_id, username, limit: 0..60) :: op
  def admin_list_devices(user_pool_id, username, opts \\ []) do
    data =
      opts
      |> Enum.into(%{user_pool_id: user_pool_id, username: username})
      |> camelize_keys()

    stream("AdminListDevices", "Devices", data)
  end

  # TODO: admin_list_groups_for_user

  @doc """
  Removes the specified user from the specified group.

  Requires developer credentials.
  """
  @spec admin_remove_user_from_group(user_pool_id, username, group_name :: String.t()) :: op
  def admin_remove_user_from_group(user_pool_id, username, group_name) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username, "GroupName" => group_name}

    request("AdminRemoveUserFromGroup", data)
  end

  @doc """
  Resets the specified user's password in a user pool as an administrator. Works on any user.

  Requires developer credentials.
  """
  @spec admin_reset_user_password(user_pool_id, username) :: op
  def admin_reset_user_password(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminResetUserPassword", data)
  end

  # TODO: admin_respond_to_auth_challenge
  # TODO: admin_set_user_settings
  # TODO: admin_update_device_status

  @doc """
  Updates the specified user's attributes, including developer attributes,
  as an administrator. Works on any user.

  For custom attributes, you must prepend the `custom:` prefix to the
  attribute name. In addition to updating user attributes, this API
  can also be used to mark phone and email as verified.

  Requires developer credentials.
  """
  @spec admin_update_user_attributes(user_pool_id, username, attributes :: [attribute]) :: op
  def admin_update_user_attributes(user_pool_id, username, attributes) do
    attributes = camelize_keys(attributes)
    data = %{"UserPoolId" => user_pool_id, "Username" => username, "UserAttributes" => attributes}

    request("AdminUpdateUserAttributes", data)
  end

  @doc """
  Signs out users from all devices, as an administrator.

  Requires developer credentials.
  """
  @spec admin_user_global_signout(user_pool_id, username) :: op
  def admin_user_global_signout(user_pool_id, username) do
    data = %{"UserPoolId" => user_pool_id, "Username" => username}

    request("AdminUserGlobalSignOut", data)
  end

  # TODO: change_password
  # TODO: confirm_device
  # TODO: confirm_forgot_password
  # TODO: confirm_sign_up
  # TODO: create_group
  # TODO: create_identity_provider
  # TODO: create_resource_server
  # TODO: create_user_import_job
  # TODO: create_user_pool
  # TODO: create_user_pool_client
  # TODO: create_user_pool_domain
  # TODO: delete_group
  # TODO: delete_identity_provider
  # TODO: delete_resource_server
  # TODO: delete_user
  # TODO: delete_user_attributes
  # TODO: delete_user_pool
  # TODO: delete_user_pool_client
  # TODO: delete_user_pool_domain
  # TODO: describe_identity_provider
  # TODO: describe_resource_server
  # TODO: describe_user_import_job
  # TODO: describe_user_pool

  @spec describe_user_pool(user_pool_id) :: op
  def describe_user_pool(user_pool_id) do
    data = %{"UserPoolId" => user_pool_id}

    request("DescribeUserPool", data)
  end

  # TODO: describe_user_pool_client
  # TODO: describe_user_pool_domain
  # TODO: forget_device
  # TODO: forgot_password
  # TODO: get_csv_header
  # TODO: get_device
  # TODO: get_group
  # TODO: get_identity_provider_by_identifier
  # TODO: get_ui_customization
  # TODO: get_user
  # TODO: get_user_attribute_verification_code
  # TODO: global_sign_out
  # TODO: initiate_auth
  # TODO: list_devices
  # TODO: list_groups
  # TODO: list_identity_providers
  # TODO: list_user_import_jobs
  # TODO: list_user_pool_clients

  @type list_users_opts :: [
          attributes_to_get: [String.t()],
          filter: String.t(),
          limit: 0..60
        ]

  @doc """
  Lists the users in the Amazon Cognito user pool.

  Can be used with `ExAws.stream!/2` to get all results.
  """
  @spec list_users(user_pool_id, list_users_opts) :: op
  def list_users(user_pool_id, opts \\ []) do
    data =
      opts
      |> Enum.into(%{user_pool_id: user_pool_id})
      |> camelize_keys()

    stream("ListUsers", "Users", data)
  end

  # TODO: list_users_in_group
  # TODO: resend_confirmation_code
  # TODO: respond_to_auth_challenge
  # TODO: set_ui_customization
  # TODO: set_user_settings
  # TODO: sign_up
  # TODO: start_user_import_job
  # TODO: stop_user_import_job
  # TODO: update_device_status
  # TODO: update_group
  # TODO: update_identity_provider
  # TODO: update_resource_server
  # TODO: update_user_attributes
  # TODO: update_user_pool
  # TODO: update_user_pool_client
  # TODO: verify_user_attribute

  defp request(action, data) do
    headers = [
      {"x-amz-target", "#{@namespace}.#{action}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]

    ExAws.Operation.JSON.new(:"cognito-idp", data: data, headers: headers)
  end

  defp stream(action, result_key, data) do
    headers = [
      {"x-amz-target", "#{@namespace}.#{action}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]

    ExAws.Operation.JSON.new(
      :"cognito-idp",
      data: data,
      headers: headers,
      stream_builder: &stream_builder(result_key, data, headers, &1)
    )
  end

  defp stream_builder(result_key, data, headers, config) do
    Stream.unfold(%{}, fn
      :done ->
        nil

      acc ->
        data = Map.merge(data, acc)
        operation = ExAws.Operation.JSON.new(:"cognito-idp", data: data, headers: headers)

        case ExAws.request!(operation, config) do
          %{"PaginationToken" => token, ^result_key => results} ->
            {results, %{"PaginationToken" => token}}

          %{^result_key => results} ->
            {results, :done}
        end
    end)
    |> Stream.flat_map(& &1)
  end
end
