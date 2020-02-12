# AnnexRlDemo

Annex RL demo for Elixir |> Atlanta Meetup 2020-02-12.  Originally published at [arpieb/annex_rl_demo](https://github.com/arpieb/annex_rl_demo/).

Attempt to port an OpenAI Gym Reinforcement Agent from Scikit-learn to Annex

https://www.meetup.com/atlantaelixir/events/hctprqybcdbqb/

## Installation

### OpenAI Gym server

This requires an OpenAI Gym server to be running, using the Python package from the [gym-http-server](https://github.com/saravanabalagi/gym-http-server) repo.  The file `requirements.py3` in this repo's root contains the pip dependencies to create and run the server.  Using virtualenv:

```bash
virtualenv ENV -p `which python3`
. ENV/bin/activate
pip install -r requirements.py3
gym-http-server
```

Note that some systems don't have Python3 installed as `python3` so use whichever command you need to create a Python3 environment...

Once the server is up and running on your local (so you can see the agent playing CartPole-v1), run the Annex RL Demo agent!

### Annex RL Demo

The usual suspects: clone, get deps, run:

```bash
mix deps.get
mix run -e "AnnexRlDemo.run()"
```
