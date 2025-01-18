# pragma version 0.4.0
# @license MIT

                                                # FIXED SIZE LIST
# array of integers
int_array : public(uint256[5])

                                                # DYNAMIC ARRAYS
#TODO

                                                # MAPPINGS
# mapping of an address and an integer
mapping : public(HashMap[address, uint256])

                                                # STRUCTS
# defining a person
struct Person:
    name: String[10]
    age: uint256
# declaring a person
person: public(Person)

@deploy
def __init__():
    self.int_array = [1,2,3,4,5]
    self.mapping[msg.sender] = 100
    self.person.name = "Alfred"
    self.person.age = 20

    # this is a copy in memory of the original person
    copy_of_person: Person = self.person
    copy_of_person.name = "Frank"
    copy_of_person.age = 30
