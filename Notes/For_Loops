# pragma version 0.4.0
# @license MIT

@external
@pure
def for_loop_range() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []
    # range from 0 to 9
    for i: uint256 in range(10): 
        arr.append(i)
    return arr

@external
@pure
def for_loop_range_index() -> DynArray[uint256, 10]:
    arr: DynArray[uint256, 10] = []
    # range from 5 to 9
    for i: uint256 in range(5,10): 
        arr.append(i)
    return arr

@external
@pure
def for_loop_list() -> DynArray[uint256, 5]:
    numbers: uint256[5] = [6,7,8,9,10]
    arr: DynArray[uint256,5] = []
    #iterating over the list/array
    for i: uint256 in numbers: 
        arr.append(i)
    return arr

############## CONTINUE

@external
@pure
def for_loop_continue() -> DynArray[uint256, 5]:
    numbers: uint256[5] = [6,7,8,9,10]
    arr: DynArray[uint256,5] = []
    for i: uint256 in numbers:
        if i == 8:
            # skips the rest of the code in the loop, and jumps into the next cycle
            continue 
        arr.append(i)
    return arr

############## BREAK
@external
@pure
def for_loop_break() -> DynArray[uint256, 5]:
    numbers: uint256[5] = [6,7,8,9,10]
    arr: DynArray[uint256,5] = []
    for i: uint256 in numbers:
        if i == 8:
            # breaks the whole loop, the rest of cycles are not executed
            break 
        arr.append(i)
    return arr