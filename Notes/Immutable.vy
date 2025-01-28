# pragma version ^0.4.0
# @license MIT

# vars whose value will never change can be declared as immutable, it saves gas
# Uppercase is recommended to name immutable vars
OWNER: public(immutablle(address))
VALUE: public(immutable(uint256))

@deploy
def __init__(val: uint256):
    # immutable vars must be initialized at deploying time
    # 'self' is not required
    VALUE: val