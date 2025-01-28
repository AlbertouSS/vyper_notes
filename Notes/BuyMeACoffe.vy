# pragma version ^0.4.0
'''
@license MIT
@title Buy Me A Coffe
@author albertou.eth
'''

# Get funds from users
# Withdraw funds
# Set a minimum funding value in USD
# keep track of who sent funds and how much they sent

# In this contract, this interface acts as an ABI that allows to call these functions implemented in any other SC
interface AggregatorV3Interface:
    def decimals() -> uint8: view
    def description() -> String[1000]: view
    def version() -> uint256: view
    def latestAnswer() -> int256: view


MINIMUM_USD: public(constant(uint256)) = as_wei_value(5, "ether") # 18 decimals
price_feed: public(AggregatorV3Interface)
owner: public(address)
funders: public(DynArray[address, 100])
funder_to_amount_funded: public(HashMap[address, uint256])

@deploy
def __init__(price_feed_address: address):
    # Address of the chainlink (sepolia) contract data feed for ETH/USD price 0x694AA1769357215DE4FAC081bf1f309aDC325306
    self.price_feed = AggregatorV3Interface(price_feed_address)
    self.owner = msg.sender

@external
@payable # payable allows this function to handle value/crypto
def fund():
    '''
    Allows users to send a minimum amount of crypto to this contract
    '''
    usd_value_of_eth: uint256 = self._get_eth_to_usd_rate(msg.value)
    assert usd_value_of_eth >= MINIMUM_USD, "The minimum amount to fund is $"
    self.funders.append(msg.sender)
    self.funder_to_amount_funded[msg.sender] += msg.value

@external
def withdraw():
    assert msg.sender == self.owner, "You-re not the owner"
    send(self.owner, self.balance)
    # resetting array
    self.funders = []
    # resetting hash (this implementation is not effective to save gas)
    for funder: address in self.funders:
        self.funder_to_amount_funded[funder] = 0


@internal
@view
def _get_eth_to_usd_rate(eth_amount: uint256) -> uint256:
    '''
    Convert ETH to USD using the chainlink data feed smart contracts
    Pass the amount of ETH to donate
    '''
    # calling an EXTERNAL contract through the AggregatorV3Interface interface
    # staticcall in this context means, no change is intended in the EVM via this call (used in pure or view functions)
    price: int256 = staticcall self.price_feed.latestAnswer() #this returns something like 332777940000
    decimals: uint8 = staticcall self.price_feed.decimals() # this returns something like 8
    # For the sake of calculations, We increment the decimals precision from 8 to 10
    # We need 10 more zeroes. So, mutiply the price by 10**10
    eth_price: uint256 = (convert(price, uint256)) * (10**10) # 332777940000 -> 3327779400000000000000 with a 10 digit precision
    eth_amount_in_usd: uint256 = (eth_amount * eth_price) // (10**18) # integer division
    return eth_amount_in_usd

@external
@view
def get_eth_to_usd_rate(eht_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eht_amount)