# Waterwheel Resolver

This [Truffle box](https://truffleframework.com/boxes) comes with everything you need to deploy your own Snowflake periodic subscrition Resolver.

[Snowflake](https://github.com/hydrogen-dev/smart-contracts/tree/master/snowflake) is an on-chain identity framework built on [ERC-1484](https://erc1484.org/) offering powerful tools to developers building dApps on top of it. The docs for Snowflake are [available on GitBook](https://hydro.gitbook.io/docs/).

## FAQs

### What is `SnowflakeResolver`?
`SnowflakeResolver` is [a contract which all Resolvers must inherit from](./contracts/SnowflakeResolver.sol); it ensures that Resolvers are compatible with the Snowflake smart contract. It's essentially a parent class that defines a few helpful variables and functions!

### How do I keep track of addresses and smart contracts derived from `Snowflake`?
The easiest way is to override the `setSnowflakeAddress` function of `SnowflakeResolver`. This allows you to declare variables such as `SnowflakeInterface snowflake;` and initialize them like so `snowflake = SnowflakeInterface(snowflakeAddress);`

### How do I initiate Transfers?
Assuming you have the proper allowance, call `snowflake.transferSnowflakeBalanceFrom(einFrom, einTo, amount)`. To use a via, simply call `snowflake.transferSnowflakeBalanceFromVia(einFrom, via, einTo, amount)`.

### How do I initiate Withdrawals?
Assuming you have the proper allowance, call `snowflake.withdrawSnowflakeBalanceFrom(einFrom, to, amount)`. To use a via, simply call `snowflake.withdrawSnowflakeBalanceFromVia(einFrom, via, einTo, amount)`.

### How do I initiate Escrowed Transfers?
First, ensure that you have properly escrowed funds using `withdrawSnowflakeBalanceFrom`. Then, call `snowflake.transferHydroBalanceTo(to, amount)` or `snowflake.transferHydroBalanceToVia(to, via, amount, _bytes)`.

### How do I initiate Escrowed Withdrawals Via?
First, ensure that you have properly escrowed funds using `withdrawSnowflakeBalanceFrom`. Then, call `snowflake.withdrawHydroBalanceTo(to, amount)` or `snowflake.withdrawHydroBalanceToVia(to, via, amount, _bytes)`.

### What if I don't want to pass any bytes in my Via calls?
Simply use `hex""` to pass an empty argument.

## Overview

### Waterwheel contract
Deployed by vendor, manages list of subscribers

#### Subscribers
Identified by their EIN, each has a list of subscriptions

### Subscrption
Manages Subscriber subscription to an individual service provided by vendor, no restriction on how many times a use can subscribe to a single service, or have a single subscription to handle a quantity of more than 1 "units" of provided product
Each subscription holds info like when subscription started etc. and delegates cost calculation to a list of "Plans"

### Plan
Plan is a contract that uses subscriber and subscrption data to calculate the cost, Plans; and plan addons, same here; examples are
"1000 hydro monthly for a website hosting"
"10 000 hydro annually for wordpress hosting avaialble only to subscriber wiht qty more than a specifc amount, etc."
"10% discount on subscription for one time avialble to EINs only from Russia"
"500 hydro gift card usable 3 times, and transferable between users"
"tiered plan"
"prorating " etc.
A subscriber has to be authorized to subscribe to a plan and add it to a subscription list, but can unsubscribe from such plans at his own will.

### PlanCollector
Is responsible on how to execute plan lists,current default impl just calls them in order and returns the value of the last plan "collect" invokation


## Known arch issues,
if collection fails, e.g; not enough credit still invoking collect method on plan would count as used once, not a little modification on invokation to roll back in case of failure

