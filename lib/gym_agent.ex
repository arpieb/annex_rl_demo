defmodule GymAgent do
  @moduledoc false

  alias GymAgent.Experience

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
    agent
    |> update_state(s)
    |> update_action(get_action(agent, s))
    |> update_fit()
    |> decay_eps()
  end

  def query(agent, r, s_prime, done) do
    agent
    |> update_q(r, s_prime, done)
    |> train()
  end

  def update_q(agent, r, s_prime, done) do
    a_prime = get_action(agent, s_prime)
    xp = %Experience{s: agent.s, a: agent.a, r: r, s_prime: s_prime, done: done}

    agent
    |> update_history(xp)
    |> update_action(a_prime)
    |> update_state(s_prime)
  end

  def update_state(agent, s) do
    struct(agent, s: s)
  end

  def update_action(agent, a) do
    struct(agent, a: a)
  end

  def update_history(agent, xp) do
    struct(agent, history: Deque.append(agent.history, xp))
  end

  def train(agent) do
    agent # TODO
  end

  def get_action(agent = %GymAgent{fit: false}, s) do
    get_random_action(agent)
  end

  def get_action(agent, s) do
    a = cond do
      :rand.uniform_real() <= agent.eps -> get_random_action(agent)
      true -> get_learned_action(agent, s)
    end
  end

  def get_learned_action(agent, s) do
    get_random_action(agent) # TODO
  end

  def get_random_action(agent) do
    :rand.uniform(agent.num_actions) - 1
  end

  def decay_eps(agent = %GymAgent{fit: true}) do
    eps = agent.eps * agent.eps_decay
    struct(agent, eps: eps)
  end

  def decay_eps(agent), do: agent

  def update_fit(agent = %GymAgent{fit: false}) do
    fit = Enum.count(agent.history) >= @history_size_min
    struct(agent, fit: fit)
  end

  def update_fit(agent), do: agent

  def get_values(agent = %GymAgent{fit: false}, s) do
    actions = for _ <- 1..agent.num_actions, do: :rand.uniform()
  end

  def get_values(agent, s) do
    # TODO add query of learner instead
    actions = for _ <- 1..agent.num_actions, do: :rand.uniform()
  end

end
