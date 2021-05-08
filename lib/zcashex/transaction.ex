defmodule Zcashex.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:expiryheight, :integer)
    field(:hex, :string)
    field(:locktime, :integer)
    field(:overwintered, :boolean)
    field(:size, :integer)
    field(:txid, :string)
    field(:valueBalance, :float)
    field(:valueBalanceZat, :float)
    field(:version, :integer)
    field(:versiongroupid, :string)
    embeds_many(:vin, Zcashex.VInTX)
    embeds_many(:vout, Zcashex.VOutTX)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :expiryheight,
      :hex,
      :locktime,
      :overwintered,
      :size,
      :txid,
      :valueBalance,
      :valueBalanceZat,
      :version,
      :versiongroupid
    ])
    |> cast_embed(:vin)
    |> cast_embed(:vout)
  end
end

defmodule Zcashex.VInTX do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:address, :string)
    field(:sequence, :integer)
    field(:txid, :string)
    field(:value, :float)
    field(:valueSat, :integer)
    field(:vout, :integer)
    field(:scriptSig, :map)
    field(:coinbase, :string)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :address,
      :sequence,
      :txid,
      :value,
      :valueSat,
      :vout,
      :scriptSig,
      :coinbase
    ])
  end
end

defmodule Zcashex.VOutTX do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:n, :integer)
    field(:value, :float)
    field(:valueSat, :integer)
    field(:valueZat, :integer)
    field(:spentHeight, :integer)
    field(:spentIndex, :integer)
    field(:spentTxId, :string)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :n,
      :value,
      :valueSat,
      :valueZat,
      :spentHeight,
      :spentIndex,
      :spentTxId
    ])
  end
end

defmodule Zcashex.VJoinSplitTX do
end
