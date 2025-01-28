# pragma version ^0.4.0
# @license MIT

# Vars whose value will never change can be declared as immutable
# They do not use storage on the blockchain. Their values are embedded in the contract's bytecode.
# Uppercase is recommended to name immutables
OWNER: public(immutablle(address))
VALUE: public(immutable(uint256))

@deploy
def __init__(val: uint256):
    # immutable vars must be initialized at deploying time
    # 'self' is not required, they are not technically state/storage variables
    VALUE: val