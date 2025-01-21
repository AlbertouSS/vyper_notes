# pragma version 0.4.0
# @license MIT

init_var: uint256

@external
def test_conditionals(init_var: uint256) -> String[20]:

    if init_var < 0:
        return "Negative number"
    elif init_var >= 0 and init_var < 1000:
        return "Small number"
    else:
        return "Large number"
