
import std/parseopt
import os
import elf_parser
import ../core/header
type 
 ParserObj = object
  filename:string
  all:bool
  check_file_header:bool
  check_segment_header:bool
  check_section_header:bool

proc help() =
 echo """Usage: evil-elf [OPTION] ... -f:elf-file
	 Display information about the contents of ELF format files
	 For short option use -key:value 
	 For long option use --key value
	 -a --all		Display all Elf information. equal to: -h -l -s
	 -h --file-header	Display ELF file header 	 
         -l --segments          Display segments header
         -s --sections 		Display sections header

	 -H --help 		Display this information
	 -V --version		Display the version number of evil-elf
"""



proc version()=
 echo "version"


proc file_header()=
 echo "file header information"

proc file_segment()=
 echo "file segment information"

proc file_section()=
 echo "file section information"

proc check_filename(filename:string)=
 if not fileExists(filename):
  echo "please provide a valid elf file"
  quit(80)

proc init(par:ParserObj)=
 
 var param=par
 check_filename(param.filename)
 if param.all:
  param.check_file_header=true
  param.check_segment_header=true
  param.check_section_header=true
 if param.check_file_header:
  file_header()
 if param.check_segment_header:
  file_segment()
 if param.check_section_header:
  file_section()
 
 var ELFH:ELF_Header
 ELFH = elf_parser(param.filename)
 echo ELFH.e_ident
proc parse_input*() =
 var param:ParserObj
 var p = initOptParser()
 for kind,key,val in p.getopt():
  case kind
  of cmdArgument:
   discard
  of cmdLongOption,cmdShortOption:
   case key
   of "help","H":
    help()
    quit(0)
   of "version","V":
    version()
    quit(0)
   of "filename","f": param.filename=val
   of "all","a":param.all=true
   of "file-header","h" :param.check_file_header = true
   of "segments"   ,"l" :param.check_segment_header = true
   of "sections"   ,"s" :param.check_section_header = true
  of cmdEnd: discard
 init(param)
 
