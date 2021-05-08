defmodule Zcashex.Block do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:hash, :string)
    field(:confirmations, :integer)
    field(:size, :integer)
    field(:height, :integer)
    field(:merkleroot, :string)
    field(:finalsaplingroot, :string)
    field(:time, :integer)
    field(:nonce, :string)
    field(:difficulty, :float)
    field(:previousblockhash, :string)
    field(:nextblockhash, :string)
    field(:solution, :string)
    field(:anchor, :string)
    field(:bits, :string)
    field(:chainwork, :string)
    field(:chainhistoryroot, :string)
    field(:version, :integer)
    embeds_many(:tx, Zcashex.Transaction)
  end

  def from_map(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :hash,
      :confirmations,
      :size,
      :height,
      :merkleroot,
      :finalsaplingroot,
      :time,
      :nonce,
      :difficulty,
      :previousblockhash,
      :nextblockhash,
      :solution,
      :anchor,
      :bits,
      :chainwork,
      :chainhistoryroot,
      :version
    ])
    |> cast_embed(:tx)
    |> apply_changes
  end
end
