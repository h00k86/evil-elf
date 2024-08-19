
type 
 ELF_Header* = object
  e_ident*: array[4,char]
  e_class*  : int
  e_data*   : int
  e_version*: int
  e_type*   : int
  e_machine*: int





