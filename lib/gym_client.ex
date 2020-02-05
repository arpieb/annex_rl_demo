defmodule GymClient do
  @moduledoc ~S"""
  Lotsa code shamelessly copied from:
  https://medium.com/@a4word/oh-the-api-clients-youll-build-in-elixir-f9140e2acfb6
  """

  def create_env(env_id) do
    "/v1/envs/"
    |> Myclient.Api.post(%{env_id: env_id})
    |> (fn {200, %{instance_id: instance_id}} -> instance_id end).()
  end

  def get_envs() do
    "/v1/envs/"
    |> Myclient.Api.get()
    |> (fn {200, %{all_envs: envs}} -> envs end).()
  end

  def reset_env(instance_id) do
    "/v1/envs/" <> instance_id <> "/reset/"
    |> Myclient.Api.post()
    |> (fn {200, %{observation: observation}} -> observation end).()
  end

  def step(instance_id, action) do
    "/v1/envs/" <> instance_id <> "/step/"
    |> Myclient.Api.post(%{action: action})
    |> (fn {200, resp} -> resp end).()
  end

  def action_space(instance_id) do
    "/v1/envs/" <> instance_id <> "/action_space/"
    |> Myclient.Api.get()
    |> (fn {200, %{info: info}} -> info end).()
  end

  def observation_space(instance_id) do
    "/v1/envs/" <> instance_id <> "/observation_space/"
    |> Myclient.Api.get()
    |> (fn {200, %{info: info}} -> info end).()
  end

end
