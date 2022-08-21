# Zcashex

A elixir client library to interact with the JSON-RPC endpoint provided by a [Zcash full node](https://github.com/zcash/zcash).

[![Zcashex CI](https://github.com/nighthawk-apps/zcashex/actions/workflows/elixir.yml/badge.svg)](https://github.com/nighthawk-apps/zcashex/actions/workflows/elixir.yml)

Note: This project is under active development, in line with Zcash Network Upgrades.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `zcashex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:zcashex, "~> 0.1.0"}
  ]
end
```

Usage:

manually:

```


{ok, pid} = Zcashex.start_link("localhost", 8232, "zcashrpc", "changeme")
GenServer.call(pid, {:call_endpoint, "getinfo"})
// or
Zcashex.getinfo
```

Example result:


```
{:ok,
 %{
   "balance" => 0.0,
   "blocks" => 1373123,
   "build" => "v4.2.0",
   "connections" => 6,
   "difficulty" => 50.67076107617935,
   "errors" => "",
   "errorstimestamp" => 1618768136,
   "keypoololdest" => 1609001920,
   "keypoolsize" => 101,
   "paytxfee" => 0.0,
   "protocolversion" => 170013,
   "proxy" => "",
   "relayfee" => 1.0e-6,
   "subversion" => "/MagicBean:4.2.0/",
   "testnet" => true,
   "timeoffset" => 0,
   "version" => 4020050,
   "walletversion" => 60000
 }}
 ```


Benchmarks:
```
Benchee.run(
  %{
    "info" => fn  -> Zcashex.getinfo end
  },
    time: 10,
  memory_time: 2,
  formatters: [{Benchee.Formatters.Console, extended_statistics: true}]
)
```
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/zcashex](https://hexdocs.pm/zcashex).

## Disclosure Policy
Do not disclose any bug or vulnerability on public forums, message boards, mailing lists, etc. prior to responsibly disclosing to the developers and giving sufficient time for the issue to be fixed and deployed. Do not execute on or exploit any vulnerability.

### Reporting a Bug or Vulnerability
When reporting a bug or vulnerability, please provide the following to nighthawkwallet@protonmail.com

A short summary of the potential impact of the issue (if known).
Details explaining how to reproduce the issue or how an exploit may be formed.
Your name (optional). If provided, we will provide credit for disclosure. Otherwise, you will be treated anonymously and your privacy will be respected.
Your email or other means of contacting you.
A PGP key/fingerprint for us to provide encrypted responses to your disclosure. If this is not provided, we cannot guarantee that you will receive a response prior to a fix being made and deployed.

## Encrypting the Disclosure
We highly encourage all disclosures to be encrypted to prevent interception and exploitation by third-parties prior to a fix being developed and deployed.  Please encrypt using the PGP public key with fingerprint: `8c07e1261c5d9330287f4ec35aff0fd018b01972`

## Contact Nighthawk Devs
zs1nhawkewaslscuey9qhnv9e4wpx77sp73kfu0l8wh9vhna7puazvfnutyq5ymg830hn5u2dmr0sf

### License
Apache License 2.0
