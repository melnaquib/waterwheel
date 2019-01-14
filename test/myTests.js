const common = require('./common.js')
const MyResolver = artifacts.require('./MyResolver.sol')

let instances
contract('Testing MyResolver', function (accounts) {
  it('initialized successfully', async () => {
    instances = await common.initialize(accounts[0], accounts, 1000)
  })

  it('MyResolver deployed successfully', async () => {
    instances.MyResolver = await MyResolver.new(instances.Snowflake.address, { from: accounts[0] })
  })
})
