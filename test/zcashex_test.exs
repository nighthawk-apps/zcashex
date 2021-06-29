defmodule ZcashexTest do
  use ZcashexCase, async: true
  doctest Zcashex
  alias Zcashex

  test "getblockcount" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, count} = Zcashex.getblockcount()
    assert count > 0
  end

  test "getblockchaininfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getblockchaininfo()
    assert Map.has_key?(info, "bestblockhash")
  end

  test "getmempoolinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmempoolinfo()
    assert Map.has_key?(info, "fullyNotified")
  end

  test "gettxoutsetinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.gettxoutsetinfo()
    assert Map.has_key?(info, "hash_serialized")
  end

  test "getinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getinfo()
    assert Map.has_key?(info, "subversion")
  end

  test "getmemoryinfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmemoryinfo()
    assert Map.has_key?(info, "locked")
  end

  test "getmininginfo" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, info} = Zcashex.getmininginfo()
    assert Map.has_key?(info, "networkhashps")
  end

  test "getnetworkinfo" do
    {:ok, info} = Zcashex.getnetworkinfo()
    assert Map.has_key?(info, "connections")
  end

  test "getpeerinfo" do
    {:ok, info} = Zcashex.getpeerinfo()
    assert is_list(info)
  end

  test "getbestblockhash" do
    {:ok, hash} = Zcashex.getbestblockhash()
    assert is_binary(hash)
  end

  test "getdifficulty" do
    {:ok, difficulty} = Zcashex.getdifficulty()
    assert is_number(difficulty)
  end

  test "getblock specifying height" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, block} = Zcashex.getblock(1, 2)
    assert Map.has_key?(block, "merkleroot")
  end

  test "getblock specifying hash" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, block_hash} = Zcashex.getbestblockhash()
    {:ok, block} = Zcashex.getblock(block_hash, 2)
    assert Map.has_key?(block, "merkleroot")
  end

  test "getblocksubsidy specifying height" do
    {:ok, subsidy} = Zcashex.getblocksubsidy(2)
    assert Map.has_key?(subsidy, "miner")
  end

  test "getblocksubsidy" do
    {:ok, subsidy} = Zcashex.getblocksubsidy()
    assert Map.has_key?(subsidy, "miner")
  end

  test "getnetworksolps" do
    {:ok, networksolps} = Zcashex.getnetworksolps()
    assert is_number(networksolps)
  end

  test "getblockhashes" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, block_hashes} = Zcashex.getblockhashes(3, 1)
    assert is_list(block_hashes)
  end

  test "getrawtransaction" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, block} = Zcashex.getblock(2, 2)
    txid = block |> Map.get("tx") |> List.first() |> Map.get("txid")
    {:ok, tx} = Zcashex.getrawtransaction(txid)
    assert Map.has_key?(tx, "confirmations")
  end

  test "sendrawtransaction with missing inputs" do
    {:ok, _} = Zcashex.generate(11)

    {:error, message} =
      Zcashex.sendrawtransaction(
        "0100000001ffb125b516b06904a212f9a0d8252926bbbc15136706cbc7d50928f9420e7689000000006a473044022026aa067b8c18309863f514f67fd5c0329362db4da80ddaad811a705abf4d5ef50220370df8275bce5cc0d1d4ead2f662a1311a4f676e76e7a569b706192e59d2df48012102e34745b07f4fc3e9d1189a49558df17863baea7dcc4bfe7ec6e483e6e18c1232ffffffff01902f5009000000001976a914813d999318812adbeabe285c9827cff69c3b34d388ac00000000"
      )

    assert message == "Missing inputs"
  end

  test "getblock and test Structs" do
    {:ok, _} = Zcashex.generate(11)
    {:ok, block_hash} = Zcashex.getbestblockhash()
    {:ok, block} = Zcashex.getblock(block_hash, 2)
    block_struct = block |> Zcashex.Block.from_map()
    assert %Zcashex.Block{} = block_struct
  end

  test "new shielded tx related structs" do
    hexstring =
      "0400008085202f89000110837db2000000001976a914b573d251f4f663e7c5c6d47622227bc4a975fe4788ac0000000044de1300f8867db20000000001cf60b77037a6a801932f3e5fc908fc716330c953f1460192bfcb7e4cf0c80f7159d6582bd93c13bd8b4e9db61a960139ddf849db9f8756ec3faa546e2f4d1a46317ee7d819852350f9c6974046ec82a1170789d42770b94645f1c4d351c0506e6ec5782b7b9efd0d9b2f1ef7c85ba7e46e15bb70f827f85fe21612d2f4c9bb9498e1ece54972357e6c170f969c7afab989437aa01827e8483e7b12b45afe1eeaade4494ba5b4108a841a4b001b1468c7a21127bacb285601dc3210c67096f26187f0c81cf5a64b0f5099e9e83441de5937f1a3bc9045db12d1dadf86a6c1ecc013b56d18ac5ff0259b8b51859abe88ebe2c5ec6c931fd481451bf669b77a3c498fcc5534dcefa40a4234a741cc45979cb255236e5df01b74eaed4d9b4fd02374dbcb5e11d93688ce0b5f4919cd30a4eb35cf9b77c925fe69060920271713db337ab0ee6afe17fbcb9a5f424701d4c2baca0622fd5d7287c21c8ac680e3379de8beb42b3944b9e7ea61be1b1d7814422812d24b3eaccf5563a09ac8488b6d0e04015cfbdc172707a9248f78471a7c384b4eaeef7c032cf023ea2aa00bf8f353ec2a0422951ad04e86ea25d31ef920f79d890ba34eccbf745ba69e1db37b9bc43d3ed930a94c04d18cd307ebde72e6d020eb30a0c8853db78114df6f1ecb791623c6536e4c575dcfc9de2176e5cad7e72a463b9dae0af1b17cc1ca38c9cd7c3150f6fc7affd6c0077b17c1f5342796607f088371f2cb2576500616d4cf1c4209c2f8b482da863f61fd5008b96fd880dc489501af9deed0de06e4f84b416c161e004da7538fd2d87f0bc655f35829a854994a8769d59841e78dcfba5f1e59cceb3d8aa1fa2972a26480f35f16a0b23b2796f99197b842c5749111afc43541c26d1f7364468769c8b47a590ae27f1ddff24b59be90e8d73a1e5ceb9d833dae2ee0ab739c69db4d622303d562e8e1177d470d905fa5c75a9f939f278638add12f5820355dc2f2b1b4befff8b01d191b7be7229365da3ce02bee518707ef986a61a07c903a3df76f22bacdec12ba5fb92cbf429a4bc359387a5f54001e6672f5c62ed69e70bb948af967dab01e7f5287e21d8e1d470ad55cd3240abcff214d623e448b0ba012af8cd52ba6acf0f9ca96739d6320a57411514e1646d4c6651860ece5e0f9a9595d89a3933721b8d2b349af5f9d9b7fbe2d79047793a91e455b157a88ce5058bdc520d1b1eb659dd2f25a3b0706569ce177d701b7bfdf89315c3d00a7e20ab2c0977031d2beca5b2990b9b29a010e9b7285701e8d10e86adaf431c3360dd329b5d77d09d323674fc0fbbf12f63cbf205d4b1fad0a7d7dbdaaa4359a51f001a1d689f0d38554f0e540cbadc67ece26b1f7dcffa64deb34149a0092c0ead8999c334a5cef81ab78b79876cb7d16db417f9906b2d60b1f6a7bbba4304b9e0d251429a199d502c294e296300e0fd5e8cb35a1458abdd1a88c6ab9da7c57b203fe11ac35cd127c179aa21ff051e864f2296a5b4bdc96c4e5f19f120a21e329e00d3cff9cb85153869822b21bd8ad37fc9f7986ffce9641af6c48294b28e3f70aab3a064797b6f57c0b2379a316a166ea4d9f64929aae33392853b31b56c808e16d25a099a3ddadcbafc4b56200da345f2b839b52e859e4a3e6c7d98c2de4bc39631bafd32b8f01ba6826dd94341d8670c15c9f16eb251ce841e8d6b6672eb5b7adc6f8620e09fa989298e179ad7a2541b4d4bf5bd30148c95c7473c3ab0a2dc73cdafca721c732112dd2d4f87919ebfdf1fad5b852a03ed644a69e3d3ac94d473bd0bd5e81a6809cccec1f4636afc93a1cb76b7b23e21c73e42d627e5a57f9c4dfebaad62b26c13818a4c5ccb311471202592066d8001a405575d51decad2ab170796c2fe28d4fbcc2757af8cd53dad5f3f7ce43dd21b8d5aaec8bb9f1d01535ad780f851b79bc93641146182c990ab5c88e63ab8b08"

    {:ok, tx} = Zcashex.decoderawtransaction(hexstring)
    txstruct = tx |> Zcashex.Transaction.from_map()
    assert %Zcashex.Transaction{} = txstruct
  end

  test "joinsplit tx test" do
    hexstring =
      "02000000000000000000010000000000000000102700000000000074ae1eeb205baacbdcc66c5a0226e1c607c0ec78ea11a6fdaf496639bd163d3e0565d3ca1b567d8e788b8ee75006bfa42d1d37e21a13c55e229040a866437d97ab0536f823c1ad6ba07c0676ccd0d45071e88a6705b8732b32408d80349a765822a6a27031f3d86d679d822eb1380d4abd393ac8fa4afb43df736e1934ea1bb2f5833904fa93cc6f49f504c73aff2852a15f9d02203c3111bff2a2102b5dd5c22891f9203268968e4b3abc7f7fa0628973579ada27e7645675dd57f13247135905524ab4d1d80ff35388c8ca9a240a0ae7249e614bc01c109aa40bc6e780e49913bd17c0a42ce26b132e9037e131cf3cc3d7a094d538a6b544f50aa7bccc90268c0dcf0170c83606fe3a118f7932ccae714a0e4a6b33d2440f177d2515b999db0204411dbe02293b99da3a180dfb9a26b6c697e88a708376856d8726d046d789470326b094c9e16eec0b127b993e7ea4fcf4a5f638232239da6ed4fa3d609bf4cad50a0321c0da4c05bd2dc7ca1f20c235b0fd43f5c130ce1ca615d56e0813ab23a11a7aa803c9cc49d85beb3d1bf52ee37671c467c7ba985c9751c7995b4af10a4df4031364c6cb2dfac60d10a703fc5ba03ed119d911ab29f9c519be96413485c4409a02149ecae57719233634f6dc51b2403ee3cc3c25d051c8b4cf6208ba14ca77af8f02195ec88578bbbf5ff69a6799b6edabdab9ea49bce026f99a64a8eba869bdf7e202255f1946d61822dd0cf15f9e50691f9e62f33167c49e3685c32bbec963f0ab420216e7ace74e80121c93bbedc1eb9967d5d35c13cefec7ff118c072d7ac42985fe8cb337dec002d2ed6b8c230ed3bd128a38c74b28ea3c02b22c56ac6ddb310948e3a6498554932f9e548f7182ca11fbd0d5f49fee4dd58dd007ceef348bd257fcc5bf4577e9d5695f07b0cf28c1af1146ff22143daad751b92fbc676bbf2900f6672758a3d49e3dec23fb5a46d75d4e48ed346a44d7a202bdc1a2e59b44d878c97ed207dac9a81c30fa9a4ed0094c78ea6d265d379b327973ef6d1d1c24716f9eadd5e55898b0f29cdd9a43f4a27c3b45b32f79f324f63178546d914a7d56549d9917bdb0a53975394d94c0b2477ed5da2da05b3bd7b29c354fee575363eff92121037cf2db12c0774d4cd4e6deef4f9dd9b8d165487bc4ae20bb12227c81978a9b8c9b45f330964a5c479ef10b8265bc5f880f8f5f4cdce3c4ddefb30729049597b919ce9b4f0b903eff71ef19b9d9693ccff67b5bd444321b412d5c0fae54f8a6ed0b5d5b846561729dc93822c6553f68692a32938930ee67888bcf67d2c7fa6011d9d6b7ef57568a92ea44d8b2039e1c3dc93660cf0c5d5edf1ea063b3789300280489ebb18f3146f93477d52de113439fc8de52dd126d49840acd4631493fa5258733c5aa09260433dc07dd91957c2ca043a5626d368b208684d6f9d6af85a13fcca5fc7be2df6eb0f562284a250aae23f959f8b63a646300dc48d3fffc3c8312a81a20b4949990dcb861f043ed0d5a5a96cda121d9737b9af15116b69b8c94d8fed0f94c361c4d90d52d5667c83ca4250facebeea748943502e4580d94688592de6c4d89c6b13bfaf150b11218b364a644862fca8b235c1729c43bfbe6c6494134a1d41cb353055db965cc80b124c769b33edf102400033c5e7764dbc5e11a86e1599e2a5eb1d1c625e97cb8cca98daaafc02344f9834ad0c0d3c51dd1bfeab10832c1193340b3f28e5fcdcabc0db7b65cd63609b1306964178d1ff949840b0c735c166e8c855c44d925604e6239dee7e30d10de81077e5cef2608fcdad7926764138320d34ab7176de66825f6307a26a8eaa7dabeba28e5d5fd40018e78e8071c3cdbe44e4dee54a0412216dc1e1339d749338b2bfd516839c951288bfb54ae85e499be2346149c57251890b747da1c531f2cb0ab0685a0160d1f2c9dc46e2992d6a40b5b7ee5d59744c4e1ac71d48e2c2e39466a6371d8c27f978660031e6e17d2597187f50cb1e5477c43908b3524eaacc066ba4ce373e9b4cc3994665d25c03163cdcdf50ebf7789ea306163a3ebe919012222975291c90c18e4886a24b9ff06089e2001f623bd32de0ecff492233ab6192bb4a0bcdfe66b3c83cae1755fe939630b79dd5c259f95389868ab126b7243697ad9caeea22de8381b18db8ae46ba691fe4f995903805a9ca8a5ab115c42924c6890c8d3bf2c2ce317f34e5cc5db184950bf050e1f62003fda1cfb26669aa8f5815db79ee678a6806de08166cec288c50ba771db8ae3c38b52414b78d69308dbee8fd52e3fe3d0b1bfb6b062706e992a3c06755da193474a6365b283297a335b0db5361ecd4c3b300bdee69d99610b33bd90ed23c5b9f98a08f6787cfd8be89ce057180ec5d44f6da9be370844f346653d36187ff232308f8365af5976d8a1c2d0ebf6606f7dd6fe78a8166bb7f999a0eacb54b05153cba566f351b5b5b1ac15302f114f03ba395e807b85ea4a27501969ceb6be5c13d61255c04c4d0aacc61f44b6346edd8b12eea39527a757aab7c35c212bf12f11a6784e0fab4d62cdf224db4cfc817a2f33af7ece6c6eef154489c2775f62d51ce6a47fa1e004fe7f55f67d640f36bdfacf0aa1b07199beb587adae9ce9cf400fd94bed304afb00"

    {:ok, tx} = Zcashex.decoderawtransaction(hexstring)
    txstruct = tx |> Zcashex.Transaction.from_map()
    assert %Zcashex.Transaction{} = txstruct
  end
end
