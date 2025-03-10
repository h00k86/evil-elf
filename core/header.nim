
type
 ELF_Header* = object
  magic*: array[4, char] # 0x7F, 'E', 'L', 'F'
  class*: byte           # 1 = 32-bit, 2 = 64-bit
  data*: byte            # 1 = little-endian, 2 = big-endian
  version*: byte         # ELF version (1 attuale)
  osAbi*: byte           # ABI target
  abiVersion*: byte      # ABI version
  pad*: array[7, byte]   # Padding
  eType*: uint16         # Tipo di ELF file
  eMachine*: uint16      # Architettura
  eVersion*: uint32      # Versione ELF
  eEntry*: uint64        # Entry point (dove inizia l'esecuzione)
  ePhoff*: uint64        # Offset della program header table
  eShoff*: uint64        # Offset della section header table
  eFlags*: uint32        # Flags del processore
  eEhsize*: uint16       # Dimensione dell'ELF header
  ePhentsize*: uint16    # Dimensione di ogni entry della program header table
  ePhnum*: uint16        # Numero di entry nella program header table
  eShentsize*: uint16    # Dimensione di ogni entry della section header table
  eShnum*: uint16        # Numero di entry nella section header table
  eShstrndx*: uint16     # Indice della sezione contenente i nomi delle sezioni


type 
  Elf64Phdr* = object
   p_type*  : uint32
   p_flags* : uint32
   p_offset*: uint64
   p_vaddr* : uint64
   p_paddr* : uint64
   p_filesz*: uint64
   p_memsz* : uint64
   p_align* : uint64


