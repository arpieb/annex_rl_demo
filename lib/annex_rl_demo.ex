defmodule AnnexRlDemo do
  @moduledoc """
  Documentation for AnnexRlDemo.
  """

  import GymClient

  @max_episodes 500
  @max_iterations 200

  def run() do
    env = create_env("CartPole-v1")
    num_actions = action_space(env) |> Map.get(:n)
    num_states = GymClient.observation_space(env) |> Map.fetch!(:shape) |> hd()
    agent = GymAgent.new(num_states: num_states, num_actions: num_actions)
    run_experiment(agent, env, @max_episodes, @max_iterations)
  end

  def run_experiment(agent, _env, 0 = _max_episodes, _max_iterations), do: agent

  def run_experiment(agent, env, max_episodes, max_iterations) do
    run_episode(agent, env, max_iterations)
    |> run_experiment(env, max_episodes - 1, max_iterations)
  end

  def run_episode(agent, env, max_iterations) do
    s = reset_env(env)
    agent = GymAgent.querysetstate(agent, s)
    r = 0.0
    %{agent: agent, done: done, r: r, iterations_left: iterations_left} = exec_step(agent, env, false, r, max_iterations)
    IO.puts("Episode finished after " <> Integer.to_string(max_iterations - iterations_left) <> " timesteps; r = " <> Float.to_string(r) <> "; done = " <> Atom.to_string(done))
    agent
  end

  defp exec_step(agent, _env, done, r, 0 = iterations_left) do
    %{agent: agent, done: done, r: r, iterations_left: iterations_left}
  end

  defp exec_step(agent, _env, true = done, r, iterations_left) do
    %{agent: agent, done: done, r: r, iterations_left: iterations_left}
  end

  defp exec_step(agent, env, _done, _r, iterations_left) do
    %{observation: s_prime, reward: r, done: done, info: _info} = step(env, agent.a)
    GymAgent.query(agent, r, s_prime, done)
    |> exec_step(env, done, r, iterations_left - 1)
  end

end
