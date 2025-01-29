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

# these are not state vars
MINIMUM_USD: public(constant(uint256)) = 5 # Dolars
ETH_TO_WEI: public(constant(uint256)) = 10**18
PRICE_FEED: public(immutable(AggregatorV3Interface))
OWNER: public(immutable(address))
PRECISION: constant(uint256) = 10**18

# state/storage vars
funders: public(DynArray[address, 100])
funder_to_amount_funded: public(HashMap[address, uint256])

@deploy
def __init__(price_feed_address: address):
    # Address of the chainlink (sepolia) contract data feed for ETH/USD price 0x694AA1769357215DE4FAC081bf1f309aDC325306
    PRICE_FEED = AggregatorV3Interface(price_feed_address)
    OWNER = msg.sender

@external
@payable
def __default__():
    self._fund()

@external
@payable
def fund():
    self._fund()

@internal
@payable # payable allows this function to handle value/crypto
def _fund():
    '''
    Allows users to send a minimum amount of crypto to this contract
    Amount is expected in wei
    '''
    minimum_usd_in_wei: uint256 = (ETH_TO_WEI * MINIMUM_USD) // self._get_eth_to_usd_rate(msg.value)
    assert msg.value >= minimum_usd_in_wei, "The minimum amount to fund is $"
    self.funders.append(msg.sender)
    self.funder_to_amount_funded[msg.sender] += msg.value

@external
def withdraw():
    assert msg.sender == OWNER, "You-re not the owner"
    # send(OWNER, self.balance) -> this could be a way to send ETH but DO NOT USE IT
    raw_call(OWNER, b"", value = self.balance) # prefer this way instead
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
    price: int256 = staticcall PRICE_FEED.latestAnswer() #this returns something like 332777940000
    decimals: uint8 = staticcall PRICE_FEED.decimals() # this returns something like 8
    eth_amount_in_usd: uint256 = (convert(price, uint256)) // (10 ** convert(decimals, uint256)) 
    return eth_amount_in_usd


@external
@view
def get_eth_to_usd_rate(eht_amount: uint256) -> uint256:
    return self._get_eth_to_usd_rate(eht_amount)