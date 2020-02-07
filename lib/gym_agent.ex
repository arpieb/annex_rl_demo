defmodule GymAgent do
  @moduledoc false

  @batch_size 10
  @history_size_min 1_000
  @history_size_max 1_000_000

  defstruct [:num_actions, :num_states, :gamma, :eps, :eps_decay, :q, :fit, :trained, :history, :s, :a]

  def new(opts \\ []) do
    %GymAgent{}
    # Default overridable options
    |> struct(gamma: 0.99)
    |> struct(eps: 0.25)
    |> struct(eps_decay: 0.99)
    |> struct(opts)

    # Default internal items
    |> struct(fit: false)
    |> struct(trained: false)
    |> struct(history: Deque.new(@history_size_min))
  end

  def querysetstate(agent, s) do
    agent = agent
    |> struct(s: s)
    |> update_action(s)
    |> decay_eps()
  end

  defp update_action(agent = %GymAgent{fit: false}, s) do
    struct(agent, a: get_random_action(agent))
  end

  defp update_action(agent, s) do
    a = cond do
      :rand.uniform_real() <= agent.eps -> get_random_action(agent)
      true -> get_learned_action(agent, s)
    end
    struct(agent, a: a)
  end

  defp get_learned_action(agent, s) do
    0 # TODO
  end

  defp get_random_action(agent) do
    :rand.uniform(agent.num_actions) - 1
  end

  defp decay_eps(agent = %GymAgent{fit: true}) do
    eps = agent.eps * agent.eps_decay
    struct(agent, eps: eps)
  end

  defp decay_eps(agent), do: agent

end
