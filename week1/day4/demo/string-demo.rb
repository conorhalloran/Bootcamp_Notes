a = 'Hello'
a.object_id

b = a #'Hello'
b.object_id

c = a.upcase 'HELLO'
a.reverse! #"olleH"

capitalize vs capitalize!
  - capitalize: Returns a copy of str with the first character converted to uppercase and the remainder to lowercase.
  - capitalize!: Modifies str by converting the first character to uppercase and the remainder to lowercase. Returns nil if no changes are made.
