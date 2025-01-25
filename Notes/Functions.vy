# pragma version 0.4.0
# @license MIT

# variables are internal by default, unless publec is specified
favorite_number: public(uint256) 

# if this decorator is not set, then the function is internal by default
# external means the function can be call only outside the contract
@external 
def store_external(new_number: uint256):
    # self in this context refers to the current contract. Therefore this variable from this contract
    self.favorite_number = new_number

# internal means function can be read from within the contract (no external calls)
# to call an internal function use "self" -: self.favorite_number()
@internal
def store_internal(new_number: uint256):
    self.favorite_number = new_number

@external
# view means the function wont write to the blockchain, it will read only
@view 
def view() -> uint256:
    return self.favorite_number

@external
# pure means the function does not reads or writes from or to the blockchain
@pure
def pure(any_number: uint8 = 255) -> uint8:
    return any_number

# CALLING AN INTERNAL FUNCTION
@external
def call_internal():
    self.store_internal(800)

# RETURNING MULTIPLE VALUES
@external
@pure
def return_multiple() -> (uint256, bool, String[5]):
    return(256, True, "abcde")    