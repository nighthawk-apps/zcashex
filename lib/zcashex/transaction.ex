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
    embeds_many(:vjoinsplit, Zcashex.VJoinSplitTX)
    field(:VShieldedSpend, {:array, :string})
    field(:VShieldedOutput, {:array, :string})
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
      :versiongroupid,
      :VShieldedSpend,
      :VShieldedOutput
    ])
    |> cast_embed(:vin)
    |> cast_embed(:vout)
    |> cast_embed(:vjoinsplit)
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
    embeds_one(:scriptPubKey, Zcashex.ScriptPubKey)
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
    |> cast_embed(:scriptPubKey)
  end
end

defmodule Zcashex.ScriptPubKey do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:asm, :string)
    field(:hex, :string)
    field(:reqSigs, :integer)
    field(:type, :string)
    field(:addresses, {:array, :string})
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :asm,
      :hex,
      :reqSigs,
      :type,
      :addresses
    ])
  end
end

defmodule Zcashex.VJoinSplitTX do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:anchor, :string)
    field(:ciphertexts, {:array, :string})
    field(:commitments, {:array, :string})
    field(:macs, {:array, :string})
    field(:nullifiers, {:array, :string})
    field(:onetimePubKey, :string)
    field(:proof, :string)
    field(:randomSeed, :string)
    field(:vpub_new, :float)
    field(:vpub_newZat, :integer)
    field(:vpub_old, :float)
    field(:vpub_oldZat, :integer)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :anchor,
      :ciphertexts,
      :commitments,
      :macs,
      :nullifiers,
      :onetimePubKey,
      :proof,
      :randomSeed,
      :vpub_new,
      :vpub_newZat,
      :vpub_old,
      :vpub_oldZat
    ])
  end
end
