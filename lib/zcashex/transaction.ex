defmodule Zcashex.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:authdigest, :string)
    field(:blockhash, :string)
    field(:blocktime, :integer)
    field(:confirmations, :integer)
    field(:expiryheight, :integer)
    field(:height, :integer)
    field(:hex, :string)
    field(:locktime, :integer)
    field(:overwintered, :boolean)
    field(:size, :integer)
    field(:time, :integer)
    field(:txid, :string)
    field(:valueBalance, :float)
    field(:valueBalanceZat, :float)
    field(:version, :integer)
    field(:versiongroupid, :string)
    field(:bindingSig, :string)
    embeds_many(:vin, Zcashex.VInTX)
    embeds_many(:vout, Zcashex.VOutTX)
    embeds_many(:vjoinsplit, Zcashex.VJoinSplitTX)
    embeds_many(:vShieldedSpend, Zcashex.VShieldedSpend)
    embeds_many(:vShieldedOutput, Zcashex.VShieldedOutput)
    embeds_one(:orchard, Zcashex.Orchard)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :authdigest,
      :blockhash,
      :blocktime,
      :bindingSig,
      :confirmations,
      :expiryheight,
      :height,
      :hex,
      :locktime,
      :overwintered,
      :size,
      :time,
      :txid,
      :valueBalance,
      :valueBalanceZat,
      :version,
      :versiongroupid
    ])
    |> cast_embed(:vin)
    |> cast_embed(:vout)
    |> cast_embed(:vjoinsplit)
    |> cast_embed(:vShieldedSpend)
    |> cast_embed(:vShieldedOutput)
    |> cast_embed(:orchard)
  end

  def from_map(data) when is_map(data) do
    %__MODULE__{}
    |> cast(data, [
      :versiongroupid,
      :authdigest,
      :blockhash,
      :blocktime,
      :bindingSig,
      :confirmations,
      :expiryheight,
      :height,
      :hex,
      :locktime,
      :overwintered,
      :size,
      :time,
      :txid,
      :valueBalance,
      :valueBalanceZat,
      :version
    ])
    |> cast_embed(:vin)
    |> cast_embed(:vout)
    |> cast_embed(:vjoinsplit)
    |> cast_embed(:vShieldedSpend)
    |> cast_embed(:vShieldedOutput)
    |> cast_embed(:orchard)
    |> apply_changes
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

defmodule Zcashex.VShieldedSpend do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:anchor, :string)
    field(:cv, :string)
    field(:nullifier, :string)
    field(:proof, :string)
    field(:rk, :string)
    field(:spendAuthSig, :string)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :anchor,
      :cv,
      :nullifier,
      :proof,
      :rk,
      :spendAuthSig
    ])
  end
end

defmodule Zcashex.VShieldedOutput do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:cmu, :string)
    field(:cv, :string)
    field(:encCiphertext, :string)
    field(:ephemeralKey, :string)
    field(:outCiphertext, :string)
    field(:proof, :string)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :cmu,
      :cv,
      :encCiphertext,
      :ephemeralKey,
      :outCiphertext,
      :proof
    ])
  end
end

defmodule Zcashex.Orchard do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:valueBalance, :float)
    field(:valueBalanceZat, :integer)
    field(:proof, :string)
    field(:anchor, :string)
    field(:bindingSig, :string)
    embeds_many(:actions, Zcashex.OrchardAction)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :valueBalance,
      :valueBalanceZat,
      :proof,
      :anchor,
      :bindingSig
    ])
    |> cast_embed(:actions)
  end
end

defmodule Zcashex.OrchardAction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field(:cv, :string)
    field(:nullifier, :string)
    field(:rk, :string)
    field(:cmx, :string)
    field(:ephemeralKey, :string)
    field(:encCiphertext, :string)
    field(:outCiphertext, :string)
    field(:spendAuthSig, :string)
  end

  def changeset(struct, data) do
    struct
    |> cast(data, [
      :cv,
      :nullifier,
      :rk,
      :cmx,
      :ephemeralKey,
      :encCiphertext,
      :outCiphertext,
      :spendAuthSig
    ])
  end
end
