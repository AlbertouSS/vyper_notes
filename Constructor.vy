# pragma version 0.4.0
# @license MIT

owner: public(address)
alias: public(String[100])
created_at: public(uint256)

@deploy
def __init__(alias: String[100]):
    self.owner = msg.sender
    self.alias = alias
    self.created_at = block.timestamp
