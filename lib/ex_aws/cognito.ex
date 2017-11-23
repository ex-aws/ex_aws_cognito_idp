defmodule ExAws.Cognito do
  @moduledoc """
  AWS Cognito-idp
  """

  import ExAws.Utils, only: [camelize_keys: 1]
  require Logger

  @namespace "AWSCognitoIdentityProviderService"

  ## Streams
  ######################

  @type stream_name :: binary
  # ExAws.Cognito.list_users |> ExAws.request
  # ExAws.Cognito.list_users(%{:user_pool_id => "us-west-2_e3v0YLSV2"}) |> ExAws.request

  @doc "ListUsers"

  @type user_pool_id :: binary
  @type username :: binary

  @type list_users_opts :: [
    {:attributes_to_get, list} |
    {:filter, binary} |
    {:pagination_token, binary} |
    {:limit, pos_integer}
  ]
  @spec list_users(user_pool_id :: binary) :: ExAws.Operation.JSON.t
  @spec list_users(user_pool_id :: binary, opts :: list_users_opts) :: ExAws.Operation.JSON.t
  def list_users(user_pool_id, opts \\ %{}) do
    data = opts
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("ListUsers", data)
  end


  @doc "AdminListDevices"

  @type admin_validation_data :: {
    :name, binary |
    :value, binary
  }

  @type user_attribute :: {
    :name, binary |
    :value, binary
  }

  @type list_users_opts :: [
    {:pagination_token, binary} |
    {:limit, pos_integer}
  ]

  @spec admin_list_devices(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  @spec admin_list_devices(user_pool_id :: binary, username :: binary, opts :: list_devices_opts) :: ExAws.Operation.JSON.t
  def admin_list_devices(user_pool_id, username, opts \\ %{}) do
    data = opts
    |> Map.put(:user_pool_id, user_pool_id)
    |> Map.put(:username, username)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminListDevices", data)
  end


  @doc "AdminCreateUser"

  @type admin_create_user_opts :: [
    {:limit, pos_integer} |
    {:desired_delivery_mediums, binary} |
    {:force_alias_creation, boolean} |
    {:message_action, binary} |
    {:tempory_password, binary} |
    {:user_attributes, user_attribute} |
    {:validation_data, admin_validation_data}
  ]

  @spec admin_create_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  @spec admin_create_user(user_pool_id :: binary, username :: binary,  opts :: admin_create_user_opts) :: ExAws.Operation.JSON.t
  def admin_create_user(user_pool_id, username, opts \\ %{}) do
    data = opts
    |> Map.put(:user_pool_id, user_pool_id)
    |> Map.put(:username, username)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminCreateUser", data)
  end


  @doc "AdminAddUserToGroup"

  @spec admin_create_user(user_pool_id :: binary, username :: binary,  group_name :: binary) :: ExAws.Operation.JSON.t
  def admin_add_user_to_group(user_pool_id, username, group_name) do
    data = %{:user_pool_id => user_pool_id}
    |> Map.put(:username, username)
    |> Map.put(:group_name, group_name)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminAddUserToGroup", data)
  end


  @doc "AdminDeleteUserAttributes"

  @spec admin_delete_user_attributes(user_pool_id :: binary, username :: binary,  user_attribute_names :: list) :: ExAws.Operation.JSON.t
  def admin_delete_user_attributes(user_pool_id, username, user_attribute_names) do
    data = %{:user_pool_id => user_pool_id}
    |> Map.put(:username, username)
    |> Map.put(:user_attribute_names, user_attribute_names)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminDeleteUserAttributes", data)
  end


  @doc "AdminDisableProviderForUser"

  @spec admin_disable_provider_for_user(user_pool_id :: binary, provider_name :: binary,  provider_attribute_name :: binary, provider_attribute_value :: binary) :: ExAws.Operation.JSON.t
  def admin_disable_provider_for_user(user_pool_id, provider_name, provider_attribute_name, provider_attribute_value) do
    data =  %{:user_pool_id => user_pool_id}
    |> Map.put(:user, %{:provider_attribute_name => provider_attribute_name,
                       :provider_attribute_value => provider_attribute_value,
                       :provider_name => provider_name
                       })
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminDisableProviderForUser", data)
  end


  @doc "AdminUpdateUserAttributes"

  @type admin_update_user_attributes :: [
    {:user_attributes, user_attribute}
  ]

  @spec admin_update_user_attributes(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  @spec admin_update_user_attributes(user_pool_id :: binary, username :: binary, opts :: admin_update_user_attributes) :: ExAws.Operation.JSON.t
  def admin_update_user_attributes(user_pool_id, username, opts \\ %{}) do
    data = opts
    |> Map.put(:user_pool_id, user_pool_id)
    |> Map.put(:username, username)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminUpdateUserAttributes", data)
  end


  @doc "AdminDeleteUser"

  @spec admin_delete_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_delete_user(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminDeleteUser", data)
  end


  @doc "AdminEnableUser"

  @spec admin_enable_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_enable_user(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminEnableUser", data)
  end


  @doc "AdminDisableUser"

  @spec admin_disable_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_disable_user(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminDisableUser", data)
  end


  @doc "AdminGetUser"

  @spec admin_get_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_get_user(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminGetUser", data)
  end


  @doc "AdminGetDevice"

  @spec admin_get_device(user_pool_id :: binary , username :: binary, device :: binary) :: ExAws.Operation.JSON.t
  def admin_get_device(user_pool_id, username, device) do
    data = %{:username => username}
    |> Map.put(:device_key, device)
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminGetDevice", data)
  end


  @doc "AdminForgetDevice"

  @spec admin_forget_device(user_pool_id :: binary , username :: binary, device :: binary) :: ExAws.Operation.JSON.t
  def admin_get_device(user_pool_id, username, device) do
    data = %{:username => username}
    |> Map.put(:device_key, device)
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminForgetDevice", data)
  end


  @doc "AdminConfirmUser"

  @spec admin_confirm_user(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_confirm_user(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request(:admin_confirm_sign_up, data)
  end


  @doc "AdminResetUserPassword"

  @spec admin_reset_user_password(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_reset_user_password(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminResetUserPassword", data)
  end


  @doc "AdminUserGlobalSignOut"

  @spec admin_user_global_signout(user_pool_id :: binary, username :: binary) :: ExAws.Operation.JSON.t
  def admin_user_global_signout(user_pool_id, username) do
    data = %{:username => username}
    |> Map.put(:user_pool_id, user_pool_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminUserGlobalSignOut", data)
  end


  @doc "AddCustomAttributes"

  @spec add_custom_attributes(user_pool_id :: binary, custom_attributes :: list) :: ExAws.Operation.JSON.t
  def add_custom_attributes(user_pool_id, custom_attributes) do
    data = %{:user_pool_id => user_pool_id}
    |> Map.put(:custom_attributres, custom_attributes)
    |> camelize_keys
    |> Map.merge(%{})

    request("AddCustomAttributes", data)
  end


  @doc "AdminInitiateAuth"

  @spec admin_initiate_auth(user_pool_id :: binary, client_id :: binary) :: ExAws.Operation.JSON.t
  def admin_initiate_auth(user_pool_id, client_id, analytics_metadata, auth_flow, auth_parameters, client_metadata) do
    data = %{:user_pool_id => user_pool_id}
    |> Map.put(:client_id, client_id)
    |> camelize_keys
    |> Map.merge(%{})

    request("AdminInitiateAuth", data)
  end


  defp request(action, data) do
    headers = [
      {"x-amz-target", "#{@namespace}.#{action}"},
      {"content-type", "application/x-amz-json-1.1"}
    ]
    ExAws.Operation.JSON.new(:"cognito-idp", data: data, headers: headers)
  end
end
