defmodule AnnexRlDemo do
  @moduledoc """
  Documentation for AnnexRlDemo.
  """

  import GymClient

  def run(max_iterations) do
    env = create_env("CartPole-v1")
    obs = reset_env(env)
    action_space = action_space(env) |> Map.get(:n)
    obs_space = GymClient.observation_space(env) |> Map.fetch!(:shape) |> hd()
    %{learner: learner, done: done, iterations_left: iters_left} = exec_action(env, nil, action_space, obs, false, max_iterations)
    IO.puts("done: " <> Atom.to_string(done) <> ", iterations: " <> Integer.to_string(max_iterations - iters_left))
  end

  @doc ~S"""
  Execute an action based on the learner and stop when done == true or iteration limit is hit
  """
  defp exec_action(_env, learner, _action_space, _obs, done, 0) do
    %{learner: learner, done: done, iterations_left: 0}
  end

  defp exec_action(_env, learner, _action_space, _obs, true, iteration) do
    %{learner: learner, done: true, iterations_left: iteration}
  end

  defp exec_action(env, learner, action_space, obs, done, iteration) do
    action = :rand.uniform(action_space) - 1
    %{observation: obs, reward: r, done: done, info: info} = step(env, action)
#    IO.inspect(action)
#    IO.inspect(r)
#    IO.inspect(done)
    exec_action(env, learner, action_space, obs, done, iteration - 1)
  end

end
