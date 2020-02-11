use Mix.Config
config :annex,
       defaults: [
         learning_rate: 0.001,
         cost: Annex.Cost.MeanSquaredError
       ]
config :annex, Annex.Layer.Dense, data_type: Annex.Data.DMatrix #AnnexMatrex.Matrix
import_config("#{Mix.env()}.exs")
