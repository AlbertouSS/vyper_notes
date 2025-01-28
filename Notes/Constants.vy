# pragma version ^0.4.0
# @license MIT

# Vars whose value will never change can be declared as constant, it saves gas
# They do not use storage on the blockchain. Their values are embedded in the contract's bytecode.
# Uppercase is recommended to name constants
# Constants must be known at compilation time
OWNER: public(constant(address)) = 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045 # vitalik.eth
VALUE: public(constant(uint256)) = 100

@deploy
def __init__():
    pass