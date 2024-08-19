import os
import ../core/header
import ../core/elf_costant
import streams
proc elf_parser*(filename:string):ELF_Header =
 echo "name of the file is: ",filename
 var stream = newFileStream(filename, fmRead)
 defer: stream.close()
 var ELFH:ELF_Header
 
 if isNil(stream):
  echo "stream is null"
  quit(123)
 #read MAGIC NUMBER
 var x:int = stream.readData(ELFH.e_ident.addr,4)
 if ELFH.e_ident != ELF_MAGIC :
  echo "error, this is not an elf file"
  quit(123)
 if x==0:
  echo "read 0 byte, exit"
  quit(1)
 return ELFH
